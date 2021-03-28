[Original Link](https://www.swiftbysundell.com/articles/handling-loading-states-in-swiftui/)

# Handling loading states within SwiftUI views
## Introduction
Bài viết hướng dẫn cách implement Loading trong SwiftUI, để dùng cho các trường hợp như đợi response từ Network chẳng hạn.

## View tự thực hiện Loading
Bài viết hướng dẫn cách implement Loading trong SwiftUI, để dùng cho các trường hợp như đợi response từ Network chẳng hạn.
```swift
struct ArticleView: View {
    var articleID: Article.ID
    var loader: ArticleLoader
    
    @State private var result: Result<Article, Error>?

    var body: some View {
        switch result {
        case .success(let article):
            ScrollView {
                VStack(spacing: 20) {
                    Text(article.title).font(.title)
                    Text(article.body)
                }
                .padding()
            }
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadArticle)
        case nil:
            ProgressView().onAppear(perform: loadArticle)
        }
    }

    private func loadArticle() {
        loader.loadArticle(withID: articleID) {
            result = $0
        }
    }
}
```

Đây là cách làm thông thường, NetworkAPI sẽ được gọi ngay trong View (__ProgressView().onAppear(perform: loadArticle)__). Sau đó, dựa vào result mà View sẽ show content hoặc show ErrorView.

## ViewModel
Cách 1 đương nhiên là work, tuy nhiên rõ ràng nó không phải là cách tốt nhất vì phần xử lý logic nằm ngay luôn trong View (tương tự như vấn đề Massive View Controller của UIKit).
Và cũng giống như UIKit, ta có thể sử dụng ViewModel để tách Logic và Presenter ra.
```swift
class ArticleViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded(Article)
    }

    ...
    
    @Published private(set) var state = State.idle
    
    func load() {
        state = .loading

        loader.loadArticle(withID: articleID) { [weak self] result in
            switch result {
            case .success(let article):
                self?.state = .loaded(article)
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
}
```
Và View sẽ dựa vào state của ViewModel để render lên tương ứng.

```swift
struct ArticleView: View {
    @ObservedObject var viewModel: ArticleViewModel

    var body: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView().onAppear(perform: viewModel.load)
        case .failed(let error):
            ErrorView(error: error, retryHandler: viewModel.load)
        case .loaded(let article):
            ScrollView {
                VStack(spacing: 20) {
                    Text(article.title).font(.title)
                    Text(article.body)
                }
                .padding()
            }
        }
    }
}
```
Cách tiếp cận này rõ ràng là hợp lý hơn và dễ maintain hơn.

## Cách Generic hơn
Do việc show Loading hầu như được dùng rất nhiều nên ta có thể làm theo 1 cách Generic hơn để giảm bớt effort cũng như bị duplicate code.
```swift
enum LoadingState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}
```

Định nghĩa 1 LoadableObject protocol để có thể flexible sử dụng cho nhiều Async.
Sau đó ta sẽ định nghĩa 1 AsyncView mà sẽ sử dụng 1 LoadableObject để show content tương ứng lên.
```swift
struct AsyncContentView<Source: LoadableObject, Content: View>: View {
    @ObservedObject var source: Source
    var content: (Source.Output) -> Content

	init(source: Source,
     	@ViewBuilder content: @escaping (Source.Output) -> Content)
	{
	    self.source = source
    		self.content = content
	}

    var body: some View {
        switch source.state {
        case .idle, .loading:
            ProgressView().onAppear(perform: source.load)
        case .failed(let error):
            ErrorView(error: error, retryHandler: source.load)
        case .loaded(let output):
            content(output)
        }
    }
}
```

Như đoạn code trên, dựa vào state của LoadableObject, AsyncContentView sẽ show hoặc Progress hoặc Error hoặc Content với output nhận về từ LoadableObject.
Ta sẽ thử apply AsyncContentView cho ArticleView
```swift
struct ArticleView: View {
    @ObservedObject var viewModel: ArticleViewModel

    var body: some View {
        AsyncContentView(source: viewModel) { article in
            ScrollView {
                VStack(spacing: 20) {
                    Text(article.title).font(.title)
                    Text(article.body)
                }
                .padding()
            }
        }
    }
}
```
## Custom lại Loading View
Ngoài việc sử dụng flexible Datasource (bằng cách định nghĩa LoadableObject protocol), ta còn có thể custom lại LoadingView thay vì sử dụng ProgressView mặc định.
```swift
struct AsyncContentView<Source: LoadableObject,
                        LoadingView: View,
                        Content: View>: View {

    ....
    
    var body: some View {
        switch source.state {
        case .idle, .loading:
            loadingView.onAppear(perform: source.load)
        case .failed(let error):
            ErrorView(error: error, retryHandler: source.load)
        case .loaded(let output):
            content(output)
        }
    }
}
```
