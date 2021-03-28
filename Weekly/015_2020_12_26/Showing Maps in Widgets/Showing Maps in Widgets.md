[Original Link](https://useyourloaf.com/blog/showing-maps-in-widgets/)

# Showing Maps in Widgets
## Introduction
Bài viết hướng dẫn Show Map trong Widget. Cách tạo ra 1 Widget cơ bản đã được trình bày trong 1 bài khác.

## Show map bằng MapKit
Ví dụ:

```swift
struct CountryView: View {
  let country: Country

  var body: some View {
    VStack {
      CountryFields(country: country)
      Divider()
      Map(coordinateRegion: .constant(country.region))
    }
    .navigationBarTitle(Text(country.name), displayMode: .inline)
  }
}
```

## Show map trong Widget
Tuy nhiên, Widget giới hạn chúng ta chỉ được sử dụng 1 vài SwiftUI View và Map không được phép. Chúng ta cũng không thể dùng MKMapView của UIKit vì Widget cũng không cho phép dùng UIKit View wrapper.
Cái mà chúng ta sẽ làm là dùng MKMapSnapshotter để capture 1 map thành image.

```swift
struct MapWidgetEntryView : View {
  var entry: MapEntry
  var body: some View {
    Image(uiImage: entry.image)
      .widgetURL(entry.country.url)
  }
}
```

Do đó, trong hàm __getTimeline__ của Timeline Provider, ta sẽ tạo ra 1 image snapshot của map

```swift
func getTimeline(
    in context: Context,
    completion: @escaping (Timeline<MapEntry>) -> Void
) {
    .....
    mapSnapshotter.start { snapshot, error in
        guard let snapshot = snapshot else { return }
        
        let date = Date()
        let nextUpdate = Calendar.current.date(
            byAdding: .hour,
            value: 1,
            to: date)!
        
        let entry = MapEntry(
            date: date,
            country: country,
            image: snapshot.image)

        let timeline = Timeline(
            entries: [entry],
            policy: .after(nextUpdate))

        completion(timeline)        
    }
}
```