//
//  ViewController.swift
//  Web3AuthITW
//
//  Created by anhhuy.du on 18/04/2024.
//

import UIKit

final class ViewController: UIViewController {
    private var engine = RecognitionEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(startRecording),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        Task {
            await engine.stopRecognition()
            ContainerNavigator.backToExtension()
        }
    }

    @objc func startRecording() {
        Task {
            await engine.startRecognition()
        }
    }
}

