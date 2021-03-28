[Original Link](https://medium.com/swlh/ios-14-modern-cell-configuration-for-beginners-programmatically-2a1be3f12a90)

# iOS 14 — Modern Cell Configuration for Beginners (Programmatically)
## Introduction
Bài viết hướng dẫn cách dùng __cell configuration__ để update các Standard Cell 

## Cách cũ
Thông thường, chúng ta sẽ configure resuable cell trong hàm cellForRowAt.
```swift
cell.textLabel?.text = "Hello World"
cell.imageView?.image = UIImage(systemName: "bell")
```
Chúng ta sử dụng “resuable cell” nhưng việc configure cell lại bị lặp đi lặp lại.

## Sử dụng new API
```swift
class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomTableViewCell"

    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)

        var contentConfig = defaultContentConfiguration().updated(for: state)
        contentConfig.text = "Hello World"
        contentConfig.image = UIImage(systemName: "bell")

        var backgroundConfig = backgroundConfiguration?.updated(for: state)
        backgroundConfig?.backgroundColor = .purple

        if state.isHighlighted || state.isSelected {
            backgroundConfig?.backgroundColor = .orange
            contentConfig.textProperties.color = .red
            contentConfig.imageProperties.tintColor = .yellow
        }

        contentConfiguration = contentConfig
        backgroundConfiguration = backgroundConfig
    }
}
```
Hàm __updateConfiguration__ được tự động gọi, trong hàm này ta sẽ configure content và background cho cell dựa theo state tương ứng.

## Benefit
Nhìn qua ta có thể thấy update configuration về cơ bản cũng giống như cách chúng ta config cell trong cellForRowAt. Vậy lợi ích ở đây là gì?
Chúng ta chỉ set value cho content config nên chúng ta không cần phải đụng vào trực tiếp UILabel hay UIImageView của cell.
Do đó, chúng ta có thể tái sử dụng đoạn code config content này cho bất cứ view nào support content configuration, thậm chí cho dù đó không phải là cell, chẳng hạn như table header hoặc footer.

## Advanced config
Ở mức advanced, ta có thể tạo ra 1 custom configuration cùng với 1 content view sẽ render configuration đó.
```swift
struct Configuration : UIContentConfiguration {
    let text1: String
    let text2: String
    let text3: String
    let text4: String
    func makeContentView() -> UIView & UIContentView {
        let c = MyContentView(configuration: self)
        return c
    }
    func updated(for state: UIConfigurationState) -> MyCell.Configuration {
        return self
    }
}

class MyContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            self.configure()
        }
    }
    private let lab1 = UILabel()
    private let lab2 = UILabel()
    private let lab3 = UILabel()
    private let lab4 = UILabel()
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        // ... configure the subviews ...
        // ... and add them as subviews to self ...
        self.configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        guard let config = self.configuration as? Configuration else { return }
        self.lab1.text = config.text1
        self.lab2.text = config.text2
        self.lab3.text = config.text3
        self.lab4.text = config.text4
    }
}

override func tableView(_ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: self.cellID, for: indexPath) as! MyCell
        let config = MyCell.Configuration(
            text1: "Harpo",
            text2: "Groucho",
            text3: "Chico",
            text4: "Zeppo"
        )
        cell.contentConfiguration = config
        return cell
}
```
