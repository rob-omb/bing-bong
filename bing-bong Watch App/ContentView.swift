//
//  ContentView.swift
//  bing-bong Watch App
//
//  Created by rob kerr on 2024-01-10.
//

import SwiftUI

struct ContentView: View {
  @State var bpm = 120;
  @State var isPlaying = false
  @State var buttonIcon = Image(systemName: "play.fill")

  var body: some View {
    VStack(spacing: 5) {
      Text("BPM: \(bpm)")
        .font(.title)
      Button(
        action: { togglePlayPause() },
        label: { buttonIcon }
      )
        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
        .clipShape(Circle())
        .foregroundColor(Color.accentColor)
    }
    .foregroundColor(.accentColor)
    Spacer()
  }

  func togglePlayPause() {
    if isPlaying {
      isPlaying = false
      buttonIcon = Image(systemName: "play.fill")
    } else {
      isPlaying = true
      buttonIcon = Image(systemName: "stop.fill")
    }
  }
}

// macro for what to render in the canvas
#Preview {
  ContentView()
}
