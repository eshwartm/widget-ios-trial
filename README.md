# Pick Your Vibe

This repo contains a tiny SwiftUI demo app and WidgetKit extension. The app lets you choose a daily "vibe" and the widget shows your latest pick.

## Features

- Four vibe choices: 🧠 Focus, 💪 Power, 😴 Chill and 😂 Joy
- Vibe history is shared between the app and the widget using App Groups
- The widget displays your current vibe and how many vibes you've picked in the last week
- Every seventh pick triggers a small celebration
- Tapping the widget opens the app

## Building

Open the project folder in Xcode and run the `VibeApp` target on an iOS 14+ device or simulator. The widget is included in the same workspace and can be added to the home screen after running the app once.
