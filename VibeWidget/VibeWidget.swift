import WidgetKit
import SwiftUI

struct VibeEntry: TimelineEntry {
    let date: Date
    let vibe: Vibe?
    let vibeCount: Int
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> VibeEntry {
        VibeEntry(date: Date(), vibe: nil, vibeCount: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (VibeEntry) -> ()) {
        let store = VibeStore.shared
        completion(VibeEntry(date: Date(), vibe: store.selectedVibe, vibeCount: store.vibesThisWeek()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<VibeEntry>) -> ()) {
        let store = VibeStore.shared
        let entry = VibeEntry(date: Date(), vibe: store.selectedVibe, vibeCount: store.vibesThisWeek())
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*60)))
        completion(timeline)
    }
}

struct VibeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            if let vibe = entry.vibe {
                Text("Your vibe: \(vibe.emoji) \(vibe.name)")
                    .font(.headline)
            } else {
                Text("No vibe yet — pick one!")
                    .font(.headline)
            }
            Text("You've picked \(entry.vibeCount) vibes this week.")
                .font(.footnote)
        }
        .padding()
        .widgetURL(URL(string: "vibeapp://"))
    }
}

@main
struct VibeWidget: Widget {
    let kind: String = "VibeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            VibeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Pick Your Vibe")
        .description("Shows your current vibe and stats.")
    }
}
