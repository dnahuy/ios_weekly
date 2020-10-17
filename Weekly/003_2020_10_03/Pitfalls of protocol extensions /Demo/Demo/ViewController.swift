//
//  ViewController.swift
//  Demo
//
//  Created by Huy Du on 10/5/20.
//

import UIKit
import DemoLib

@main
struct MyCollection: DemoProtocol {

}

extension MyCollection: Filtrable {}

protocol Filtrable {
    
}

extension Filtrable {
    func filter() {
        print("huydna Filtrable filter")
    }
}

class ViewController: UIViewController {

    private let button = UIButton()
    private let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didDetectRecording),
            name: UIScreen.capturedDidChangeNotification,
            object: nil)
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didDetectRecording),
            name: UIApplication.userDidTakeScreenshotNotification,
            object: nil)
    }

    private func setupViews() {
        button.frame = CGRect(x: 40, y: 300, width: 100, height: 40)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4.0
        
        textView.frame = CGRect(x: 40, y: 100, width: 400, height: 800)
        textView.text = "Do not screen record!"
        textView.isHidden = true
        
        view.addSubview(button)
        view.addSubview(textView)
    }
    
    @objc private func didDetectRecording() {
        DispatchQueue.main.async { [self] in
            button.isHidden = true
            textView.isHidden = false
        }
    }
}

