//
//  ContentView.swift
//  bing-bong Watch App
//
//  Created by rob kerr on 2024-01-10.
//

import SwiftUI

struct ContentView: View {
  @State var bpm: Double = 120.0
  @State var viewID = 0
  @State var isPlaying: Bool = false
  @State var buttonIcon: Image = Image(systemName: "play.fill")

  let rotato: Double = 60.0

  var body: some View {
    VStack(spacing: 0) {
      Text("\(Int(bpm))")
        .font(.system(size: 100))
        .fontDesign(.monospaced)
      Button(
        action: { togglePlayPause() },
        label: { buttonIcon }
      )
        .id(viewID)
        .padding(.bottom, 10.0)
        .font(.system(size: 100))
        .clipShape(Circle())
        .tint(.black)
        .aspectRatio(contentMode: .fill)
        .rotationEffect(Angle.degrees(isPlaying ? 60.0 : 0.0))
        .animation(Animation.linear(duration: 60.0 / Double(bpm)).repeatForever(autoreverses: true), value: isPlaying)
    }
    .foregroundColor(.accentColor)
    Spacer()
  }

  func togglePlayPause() {
    if isPlaying {
      isPlaying = false
      buttonIcon = Image(systemName: "play.fill")
      viewID += 1
    } else {
      isPlaying = true
      buttonIcon = Image(systemName: "play")
    }
  }
}

#Preview {
  ContentView()
}
