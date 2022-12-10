//
//  SampleAfterTheFactReportOfLatenessWidget.swift
//  SampleAfterTheFactReportOfLatenessWidget
//
//  Created by 近藤宏輝 on 2022/12/10.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct SampleAfterTheFactReportOfLatenessWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color.red
            VStack {
                Text("今から出発しても\n遅刻しています♪\n")
                    .font(.system(size: 18, weight: .bold))
                Text(entry.date, style: .time)
            }
        }
        
    }
}

@main
struct SampleAfterTheFactReportOfLatenessWidget: Widget {
    let kind: String = "SampleAfterTheFactReportOfLatenessWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SampleAfterTheFactReportOfLatenessWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct SampleAfterTheFactReportOfLatenessWidget_Previews: PreviewProvider {
    static var previews: some View {
        SampleAfterTheFactReportOfLatenessWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
