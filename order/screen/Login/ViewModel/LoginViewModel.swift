//
//  LoginViewModel.swift
//  order
//
//  Created by hany karam on 8/27/21.
//

import Foundation
import RxCocoa
import RxSwift
class LoginViewModel {
    var EmailBehavior = BehaviorRelay<String>(value: "")
    var PasswordBehavior = BehaviorRelay<String>(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var loginModelSubject = PublishSubject<LoginModel>()
    var loginModelObservable: Observable<LoginModel> {
        return loginModelSubject
    }
    
    func Login() {
        loadingBehavior.accept(true)
        let params = [
            "email": EmailBehavior.value,
            "password": PasswordBehavior.value,
        ]
        NetWorkManager.sendRequest(method: .post, url: login,parameters:params) {[weak self] (err, response:LoginModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            self.loadingBehavior.accept(false)
            if let error = err {
                // network error
             }
            else {
                guard let loginModel = response else { return }
                self.loginModelSubject.onNext(loginModel)
                NetworkHelper.accessToken = response?.data?.token
                UserDefaults.standard.set(response?.data?.id, forKey: "IDUSER")
                UserDefaults.standard.set(response?.data?.name, forKey: "NAMEUSER")
                UserDefaults.standard.set(response?.data?.phone, forKey: "NAMEPHONE")
                UserDefaults.standard.set(response?.data?.email, forKey: "NAMEEMAIL")
                UserDefaults.standard.synchronize()
                
            }
        }
    }
}
