//
//  SoundEffects.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 28/06/2021.
//

import AVKit 
import SwiftUI

class SoundManager {
  static let instance = SoundManager()
  
  enum Sound: String {
    case tada, badum
  }
  
  private var player: AVAudioPlayer?
  
  func play(sound: Sound) {
    guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
    
    do {
      player = try AVAudioPlayer(contentsOf: url)
      player?.play()
    } catch let error {
      print("Error playing the soundfile from \(url). Error: \(error.localizedDescription)")
    }
   
  }
}

struct SoundEffects: View {
  var body: some View {
    VStack(spacing: 40) {
      Button("play sound #1".uppercased()) {
        SoundManager.instance.play(sound: .badum)
      }
      
      Button("play sound #2".uppercased()) {
        SoundManager.instance.play(sound: .tada)
      }
    }
  }
}

struct SoundEffects_Previews: PreviewProvider {
  static var previews: some View {
    SoundEffects()
  }
}
