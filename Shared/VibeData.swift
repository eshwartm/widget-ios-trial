import Foundation
import SwiftUI

struct Vibe: Identifiable, Codable {
    let id: String
    let emoji: String
    let name: String
}

final class VibeStore: ObservableObject {
    static let shared = VibeStore()
    private init() {
        load()
    }

    private let appGroup = "group.com.example.vibe"
    private let vibeKey = "selectedVibe"
    private let historyKey = "vibeHistory"

    @Published var selectedVibe: Vibe?
    @Published var history: [Date] = []

    func select(vibe: Vibe) {
        selectedVibe = vibe
        history.append(Date())
        save()
    }

    func vibesThisWeek() -> Int {
        let calendar = Calendar.current
        let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        return history.filter { $0 >= oneWeekAgo }.count
    }

    private func container() -> UserDefaults? {
        UserDefaults(suiteName: appGroup)
    }

    private func save() {
        guard let defaults = container() else { return }
        if let vibe = selectedVibe {
            defaults.set(try? JSONEncoder().encode(vibe), forKey: vibeKey)
        }
        defaults.set(try? JSONEncoder().encode(history), forKey: historyKey)
    }

    private func load() {
        guard let defaults = container() else { return }
        if let data = defaults.data(forKey: vibeKey),
           let vibe = try? JSONDecoder().decode(Vibe.self, from: data) {
            selectedVibe = vibe
        }
        if let histData = defaults.data(forKey: historyKey),
           let hist = try? JSONDecoder().decode([Date].self, from: histData) {
            history = hist
        }
    }
}

extension Vibe {
    static let samples: [Vibe] = [
        Vibe(id: "focus", emoji: "🧠", name: "Focus"),
        Vibe(id: "power", emoji: "💪", name: "Power"),
        Vibe(id: "chill", emoji: "😴", name: "Chill"),
        Vibe(id: "joy", emoji: "😂", name: "Joy")
    ]
}
