//
//  ContentView.swift
//  bing-bong Watch App
//
//  Created by rob kerr on 2024-01-10.
//

import SwiftUI

struct ContentView: View {
  @State private var bpm: Int  = 120
  @State private var viewID: Int = 0
  @State private var prevBpm: Int = 0
  @State private var isEditing: Bool = false
  @State private var isPlaying: Bool = false
  @State private var buttonIcon: Image = Image(systemName: "play.fill")

  var body: some View {
    VStack(spacing: 0) {
      if isEditing {
        EditView(
          bpm: $bpm,
          prevBpm: $prevBpm,
          isEditing: $isEditing
        )
      } else {
        Text("\(bpm)")
          .font(.system(size: 100))
          .fontDesign(.monospaced)
          .gesture(
            TapGesture()
              .onEnded { _ in
                viewID += 1
                prevBpm = bpm
                isEditing = true
                isPlaying = false
                buttonIcon = Image(systemName: "play.fill")
              }
          )

        Button(
          action: { togglePlayPause() },
          label: { buttonIcon }
        )
        .id(viewID)
        .padding(.top, -10.0)
        .padding(.bottom, 20.0)
        .font(.system(size: 100))
        .clipShape(Circle())
        .tint(.black)
        .aspectRatio(contentMode: .fill)
        .rotationEffect(Angle.degrees(isPlaying ? 60.0 : 0.0))
        .animation(.linear(duration: 60.0 / (Double(bpm))).repeatForever(autoreverses: true), value: isPlaying)
        .sheet(isPresented: $isEditing) {
          EditView(
            bpm: $bpm,
            prevBpm: $prevBpm,
            isEditing: $isEditing
          )
        }
      }
    }
      .foregroundColor(.accentColor)
    }

  func togglePlayPause() {
    if isPlaying {
      viewID += 1
      isPlaying = false
      buttonIcon = Image(systemName: "play.fill")
    } else {
      isPlaying = true
      buttonIcon = Image(systemName: "play")
    }
  }
}

struct EditView: View {
  @Binding var bpm: Int
  @Binding var prevBpm: Int
  @Binding var isEditing: Bool

  var body: some View {
    VStack (alignment: .leading, spacing: 7) {
      Text("Edit BPM")
        .font(.headline)

      Picker("Edit BPM", selection: $bpm) {
        ForEach(0..<421) {
          Text("\($0)")
        }
      }
        .labelsHidden()
        .focusable()
        .digitalCrownRotation(
          detent: $bpm,
          from: 0,
          through: 420,
          by: 1,
          sensitivity: .medium,
          isHapticFeedbackEnabled: true
        )
        .frame(height: 75)
        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)

      Button("Done") {
        isEditing.toggle()
      }
        .frame(height: 40.0)
        .background(Color.accentColor)
        .foregroundColor(.black)
        .clipShape(Capsule())

      Button("Cancel") {
        isEditing.toggle()
        bpm = prevBpm
      }
      .frame(height: 40.0)
      .clipShape(Capsule())
    }
  }
}

#Preview {
  ContentView()
}
