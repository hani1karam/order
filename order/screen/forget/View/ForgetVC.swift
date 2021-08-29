//
//  ForgetVC.swift
//  order
//
//  Created by hany karam on 8/22/21.
//

import UIKit
import RxCocoa
import RxSwift

class ForgetVC: UIViewController {
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    let loginViewModel = ForgertViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTextFieldsToViewModel()
        subscribeToLoading()
        subscribeToResponse()
        subscribeToLoginButton()
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
    @IBAction func confirmCode(_ sender: Any) {
        
    }
    func bindTextFieldsToViewModel() {
        EmailTxt.rx.text.orEmpty.bind(to: loginViewModel.EmailBehavior).disposed(by: disposeBag)
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
                let sampleVC = RetriveCodeVC(nibName: "RetriveCodeVC", bundle: nil) as! RetriveCodeVC
                sampleVC.email = self.EmailTxt.text
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
                self.loginViewModel.forgertTapped()
            }).disposed(by: disposeBag)
    }

}
