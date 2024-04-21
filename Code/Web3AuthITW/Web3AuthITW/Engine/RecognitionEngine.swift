//
//  RecognitionEngine.swift
//  Web3AuthITW
//
//  Created by anhhuy.du on 20/04/2024.
//

import Foundation
import Combine

@MainActor
final class RecognitionEngine {
    private let whisperState = WhisperState()
    private var anyCancellables = Set<AnyCancellable>()

    init() {
        whisperState.$translatedText.sink(receiveValue: {
            PersistentStore.save(translatedText: $0)
        }).store(in: &anyCancellables)
    }
    
    func startRecognition() async {
        await whisperState.toggleRecord()
    }
    
    func stopRecognition() async {
        await whisperState.toggleRecord()
    }
}
