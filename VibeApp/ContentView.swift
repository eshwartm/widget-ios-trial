import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: VibeStore
    @State private var showCelebration = false
    @State private var animateID: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(store.selectedVibe != nil ? "Your vibe today: \(store.selectedVibe!.emoji) \(store.selectedVibe!.name)!" : "Pick your vibe!")
                    .font(.headline)
                    .padding()
                HStack(spacing: 15) {
                    ForEach(Vibe.samples) { vibe in
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                animateID = vibe.id
                                store.select(vibe: vibe)
                                if store.vibesThisWeek() % 7 == 0 {
                                    showCelebration = true
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                animateID = nil
                            }
                        }) {
                            Text(vibe.emoji)
                                .font(.system(size: 40))
                                .padding()
                                .background(Color(.systemGray6))
                                .clipShape(Circle())
                                .scaleEffect(animateID == vibe.id ? 1.2 : 1.0)
                        }
                    }
                }
                Text("You've picked \(store.vibesThisWeek()) vibes this week.")
                    .padding()
            }
            .navigationTitle("Pick Your Vibe")
        }
        .alert(isPresented: $showCelebration) {
            Alert(title: Text("🎉 Keep it up!"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(VibeStore.shared)
    }
}
