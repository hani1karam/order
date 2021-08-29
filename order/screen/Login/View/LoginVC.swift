//
//  LoginVC.swift
//  order
//
//  Created by hany karam on 8/22/21.
//

import UIKit

class LoginVC: UIViewController {
 
 
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func loginTapped(_ sender: Any) {
        let sampleVC = Signin(nibName: "Signin", bundle: nil)
        self.navigationController?.pushViewController(sampleVC, animated: false)
        
    }
    @IBAction func registerTapped(_ sender: Any) {
        let sampleVC = signup(nibName: "signup", bundle: nil)
        self.navigationController?.pushViewController(sampleVC, animated: false)
        
    }
 
}
