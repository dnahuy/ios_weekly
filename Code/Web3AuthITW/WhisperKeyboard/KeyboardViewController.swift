//
//  KeyboardViewController.swift
//  WhisperKeyboard
//
//  Created by anhhuy.du on 18/04/2024.
//

import UIKit
import SwiftUI
import KeyboardKit
import AVFoundation

final class KeyboardViewController: KeyboardInputViewController {
    private let textIdKey = "textId"
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let translatedText = PersistentStore.translatedText,
              let textId = PersistentStore.textId,
              UserDefaults.standard.string(forKey: textIdKey) != textId
        else {
            return
        }
        
        textDocumentProxy.insertText(translatedText)
        UserDefaults.standard.set(textId, forKey: textIdKey)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PersistentStore.save(hostBundleId: hostBundleId ?? "")
    }
    
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        setup { [unowned self] controller in
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { _ in
                    Button("Whisper", action: {
                        guard let extensionContext = self.extensionContext else {
                            return
                        }
                        
                        // Keyboard Extension doesn't have access to Microphone, we need to navigate to Containing App to record voice
                        ExtensionNavigator.navigateToContainingApp(
                            viewController: self,
                            extensionContext: extensionContext)
                    })
                }
            )
        }
    }
}
