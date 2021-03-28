[Original Link](https://www.swiftbysundell.com/articles/the-lifecycle-and-semantics-of-a-swiftui-view/)

# The lifecycle and semantics of a SwiftUI view
## Introduction
Bài viết giới thiệu đôi nét về Life Cycle và Semantics của SwiftUI View

## Vai trò của body
Đối với property body của View, nó chỉ nên được dùng theo đúng nghĩa là để declare view hierachy. Chúng ta nên tránh tình trạng sử dụng body theo kiểu imperative.

```swift
struct ArticleView: View {
    @ObservedObject var viewModel: ArticleViewModel

    var body: some View {
        viewModel.update()

        return VStack {
            Text(viewModel.article.text)
            ...
        }
    }
}
```

Như ví dụ trên, chúng ta không gọi __viewModel.update()__ trong body, như thế nó không còn là declarative nữa. Bên cạnh đó, body của SwiftUI View có thể được gọi nhiều lần (để hiểu nguyên nhân cụ thể ta có thể tham khảo sách “Thinking in SwiftUI”) dẫn đến viewModel.update() có thể được gọi dư thừa nhiều lần không cần thiết.
Nói chung, nếu chúng ta cần phải sử dụng đến keyword return trong body có nghĩa là chúng ta đang làm sai gì đó, body không nên performs action hoặc trigger side effect.
Trong trường hợp ví dụ trên, chúng ta có thể dùng các modifier có sẵn của __View (onAppear)__:
```swift
    var body: some View {
        VStack {
            Text(viewModel.article.text)
            ...
        }
        .onAppear(perform: viewModel.update)
    }
```

## Vấn đề init
Như trong UIKit, thông thường chúng ta có thể có vài setup trong hàm init. Ví dụ như chúng ta có thể register observer nào đó.

```swift
struct ArticleView: View {

    init(viewModel: ArticleViewModel) {
        cancellable = NotificationCenter.default.publisher(
            for: UIApplication.willEnterForegroundNotification
        )
        .sink { _ in
            viewModel.update()
        }
    }
}
```

Tuy nhiên, trong SwiftUI, cách làm này sẽ nảy sinh vấn đề. Ví dụ như sau:

```swift
struct ArticleListView: View {

    var body: some View {
        List(store.articles) { article in
            NavigationLink(article.title,
                destination: ArticleView(
                    viewModel: ArticleViewModel(
                        article: article,
                        store: store
                    )
                )
            )
        }
    }
}
```

Mặc dù ArticleView chỉ mới được declare chứ chưa thực sự được render lên (nó chỉ render khi được navigate qua), tuy nhiên ngay khi lúc declare trong body của ArticleListView thì ArticleView đã được tạo ra (vì NavigationLink yêu cầu chúng ta phải chỉ định destination từ trước). Do đó hàm init của ArticleView đã được gọi và đã bắt đầu observe NotificationCenter.
Để giải quyết vấn đề trên, ta có thể dùng modifier .onReceive

```swift
struct ArticleView: View {

    var body: some View {
        VStack {
            ...
        }
        .onReceive(NotificationCenter.default.publisher(
            for: UIApplication.willEnterForegroundNotification
        )) { _ in
            viewModel.update()
        }
    }
}
```

## Bảo đảm UIKit View được reuse đúng cách
Để có thể tích hợp UIKit View vào trong SwiftUI, ta phải sử dụng protocol UIViewRepresentable. Protocol này chủ yếu có 2 func, 1 để tạo View và 1 để  Update.Ví dụ như sau:

```swift
struct AttributedText: UIViewRepresentable {
    var string: NSAttributedString

    private let label = UILabel()

    func makeUIView(context: Context) -> UILabel {
        label.attributedText = string
        return label
    }

    func updateUIView(_ view: UILabel, context: Context) {
        // No-op
    }
}
```

Tuy vẫn work nhưng implementation trên thực ra vẫn chưa đúng cách.  SwiftUI View có thể được tạo lại nhiều lần. Do đó, UILabel sẽ được tạo lại mỗi lần struct AttributeText được tạo lại.
Cách implement đúng đắn sẽ như sau:

```swift
struct AttributedText: UIViewRepresentable {
    var string: NSAttributedString

    func makeUIView(context: Context) -> UILabel {
        UILabel()
    }

    func updateUIView(_ view: UILabel, context: Context) {
        view.attributedText = string
    }
}
```
Ta sẽ để việc quản lý underlying UIKit View lại cho System và chỉ update lại nó trong hàm updateUIView.