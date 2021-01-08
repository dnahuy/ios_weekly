//
//  LoginViewController.swift
//  FaceIT
//
//  Created by Steven Curtis on 18/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    var darkBG: UIView = UIView(frame: .zero)
    let kc = KeyChainManager(KeyChain())
    
    
    @IBAction func login(_ sender: UIButton) {
        darkBG.isHidden = false
        activityIndicator.startAnimating()
        
        
        downloadData(HTTPManager(session: URLSession.shared), completion: {[weak self] response in
            // perform an action with the response
            switch response {
            case .success(let success):
                let decoder = JSONDecoder.init()
                if let decoded = try? decoder.decode(LoginModel.self, from: success) {
                    
                    // store the token in the keychain
                    if let data = decoded.token.data(using: .utf16)  {
                        _ = self?.kc.save(key: "token", data: data )
                    }
                    
                    DispatchQueue.main.async {
                        // now login with the usename and
                        self?.darkBG.isHidden = true
                        self?.activityIndicator.stopAnimating()
                        
                        let alert = UIAlertController(title: "Success", message: "Registered!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                            self?.performSegue(withIdentifier: "toLoggedin", sender: nil)
                        }))
                        
                        self?.present(alert, animated: true, completion: {
                            // completion handler here
                        })
                    }
                    
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.darkBG.isHidden = true
                    self?.activityIndicator.stopAnimating()
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        activityIndicator.frame = self.view.frame
        darkBG.frame = self.view.frame
        darkBG.backgroundColor = .darkGray
        
        darkBG.addSubview(activityIndicator)
        self.view.addSubview(darkBG)
        darkBG.isHidden = true
    }
    
    func downloadData<T: HTTPManagerProtocol>(_ httpManager: T, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = API.postLogin.url {
            // for this API endpoint there is a hardcoded username and password
            httpManager.post(url: url, dta: ("eve.holt@reqres.in" , "pistol"), completionBlock: {data in
                completion(data)
            })
        }
    }
    
}
