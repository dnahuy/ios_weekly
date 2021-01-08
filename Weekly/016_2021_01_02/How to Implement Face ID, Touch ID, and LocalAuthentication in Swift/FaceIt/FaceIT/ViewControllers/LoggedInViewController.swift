//
//  LoggedInViewController.swift
//  FaceIT
//
//  Created by Steven Curtis on 20/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class LoggedInViewController: UIViewController {

    let kc = KeyChainManager(KeyChain())

    @IBAction func logout(_ sender: UIButton) {
        _ = try? kc.delete(key: "token")
        performSegue(withIdentifier: "logout", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
