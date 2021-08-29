//
//  signup.swift
//  order
//
//  Created by hany karam on 8/22/21.
//

import UIKit
import RxCocoa
import RxSwift

class signup: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var nametxt: UITextField!
    @IBOutlet weak var phonetxt: UITextField!
    
    let loginViewModel = RgisterViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setImage(UIImage(named: "Group 1606"), for: .normal)
        PasswordTxt.rightViewMode = .unlessEditing
        bindTextFieldsToViewModel()
        subscribeToLoading()
        subscribeToResponse()
        subscribeToLoginButton()
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
    @IBAction func btnPasswordVisiblityClicked(_ sender: Any) {
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected {
            self.PasswordTxt.isSecureTextEntry = false
            button.setImage(UIImage(named: "Path 50"), for: .normal)
        } else {
            self.PasswordTxt.isSecureTextEntry = true
            button.setImage(UIImage(named: "Group 1606"), for: .normal)
        }
    }
    func bindTextFieldsToViewModel() {
        EmailTxt.rx.text.orEmpty.bind(to: loginViewModel.EmailBehavior).disposed(by: disposeBag)
        PasswordTxt.rx.text.orEmpty.bind(to: loginViewModel.PasswordBehavior).disposed(by: disposeBag)
        phonetxt.rx.text.orEmpty.bind(to: loginViewModel.phoneBehavior).disposed(by: disposeBag)
        nametxt.rx.text.orEmpty.bind(to: loginViewModel.nameBehavior).disposed(by: disposeBag)
    }
    func subscribeToLoading() {
        loginViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoader()
                
            } else {
                self.hideLoader()
                
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToResponse() {
        loginViewModel.loginModelObservable.subscribe(onNext: {
            if $0.status == true {
                ToastManager.shared.showError(message: "SUCCESS", view: self.view, backgroundColor: .black)
                let sampleVC = MainTabBarVC(nibName: "MainTabBarVC", bundle: nil)
                self.navigationController?.pushViewController(sampleVC, animated: false)
            }
            else {
                ToastManager.shared.showError(message: "Error", view: self.view, backgroundColor: .red)
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToLoginButton() {
        loginButton.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.loginViewModel.registerTapped()
            }).disposed(by: disposeBag)
    }
    
    
}
