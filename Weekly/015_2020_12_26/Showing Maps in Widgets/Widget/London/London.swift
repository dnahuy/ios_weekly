//
//  London.swift
//  London
//
//  Created by Huy Du on 12/28/20.
//

import WidgetKit
import SwiftUI
import MapKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> MapEntry {
        MapEntry(
            date: Date(),
            image: UIImage(named: "hcm_center")!)
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (MapEntry) -> ()
    ) {
        let entry = MapEntry(
            date: Date(),
            image: UIImage(named: "hcm_center")!)
        completion(entry)
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        // Ho Chi Minh city's center
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 10.762622,
                longitude: 106.660172),
            latitudinalMeters: 500,
            longitudinalMeters: 500)
        
        let mapSnapshotter = makeSnapshotter(
            for: region,
            with: context.displaySize)
        
        mapSnapshotter.start { snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
            
            let date = Date()
            let nextUpdate = Calendar.current.date(
                byAdding: .hour,
                value: 1,
                to: date)!
            
            let entry = MapEntry(
                date: date,
                image: snapshot.image)
            
            let timeline = Timeline(
                entries: [entry],
                policy: .after(nextUpdate))
            
            completion(timeline)
        }
    }
    
    private func makeSnapshotter(
        for region: MKCoordinateRegion,
        with size: CGSize
    ) -> MKMapSnapshotter {
        let options = MKMapSnapshotter.Options()
        options.region = region
        options.size = size
        
        // Force light mode snapshot
        options.traitCollection = UITraitCollection(traitsFrom: [
            options.traitCollection,
            UITraitCollection(userInterfaceStyle: .light)
        ])

        return MKMapSnapshotter(options: options)
    }
}

struct MapEntry: TimelineEntry {
    let date: Date
    let image: UIImage
}

struct MapWidgetEntryView : View {
    var entry: MapEntry
    var body: some View {
        Image(uiImage: entry.image)
    }
}

@main
struct London: Widget {
    let kind: String = "London"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MapWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("London Widget")
        .description("This is an example widget.")
    }
}

struct London_Previews: PreviewProvider {
    static var previews: some View {
        MapWidgetEntryView(
            entry: MapEntry(
                date: Date(),
                image: UIImage(named: "hcm_center")!))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
