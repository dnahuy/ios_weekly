//
//  ViewController.swift
//  FaceIT
//
//  Created by Steven Curtis on 17/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let kc = KeyChainManager(KeyChain())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        if let receivedData = kc.load(key: "token"), let _ = String(data: receivedData, encoding: .utf16) {
            // the token is avaliable through unnamed parameter above
            // authenticate also checks if the policy can be evaluated
            BiometricsManager().authenticateUser(completion: { [weak self] (response) in
                switch response {
                case .failure:
                    DispatchQueue.main.async {
                        self?.performSegue(withIdentifier: "auth", sender: nil)
                    }
                case .success:
                    DispatchQueue.main.async {
                        self?.performSegue(withIdentifier: "login", sender: nil)
                    }
                }
            })
        } else {
            // no token so therefore we have never logged in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "auth", sender: nil)
            }
        }
    }
}

