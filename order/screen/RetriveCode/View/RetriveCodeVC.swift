//
//  RetriveCodeVC.swift
//  order
//
//  Created by hany karam on 8/22/21.
//

import UIKit

class RetriveCodeVC: UIViewController {
    @IBOutlet weak var CodeTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var email:String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func confirmCode(_ sender: Any) {
        let sampleVC = ChangePasswordVC(nibName: "ChangePasswordVC", bundle: nil)
        self.navigationController?.pushViewController(sampleVC, animated: false)
        
    }
    
    
}
