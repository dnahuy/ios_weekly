//
//  ViewController.swift
//  Icons
//
//  Created by Huy Du on 1/28/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didFirstIcon() {
        DispatchQueue.main.async {
            UIApplication.shared.setAlternateIconName(nil)
        }
    }

    @IBAction func didSecondIcon() {
        DispatchQueue.main.async {
            UIApplication.shared.setAlternateIconName("AppIcon2")
        }
    }

}

