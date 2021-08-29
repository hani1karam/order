//
//  SignUPViewModel.swift
//  order
//
//  Created by hany karam on 8/27/21.
//

import Foundation
import RxCocoa
import RxSwift
class RgisterViewModel {
    var EmailBehavior = BehaviorRelay<String>(value: "")
    var PasswordBehavior = BehaviorRelay<String>(value: "")
    var nameBehavior = BehaviorRelay<String>(value: "")
    var phoneBehavior = BehaviorRelay<String>(value: "")

    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var loginModelSubject = PublishSubject<RegisterModel>()
    var loginModelObservable: Observable<RegisterModel> {
        return loginModelSubject
    }
    
    func registerTapped() {
        loadingBehavior.accept(true)
        let params = [
            "email": EmailBehavior.value,
            "password": PasswordBehavior.value,
            "name": nameBehavior.value,
            "phone": phoneBehavior.value,
            "image":"",
        ]
        NetWorkManager.sendRequest(method: .post, url: register,parameters:params) {[weak self] (err, response:RegisterModel?) in
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
