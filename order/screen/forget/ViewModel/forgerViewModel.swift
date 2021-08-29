//
//  forgerViewModel.swift
//  order
//
//  Created by hany karam on 8/27/21.
//

import Foundation
import RxCocoa
import RxSwift
class ForgertViewModel {
    var EmailBehavior = BehaviorRelay<String>(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var loginModelSubject = PublishSubject<ForgerModel>()
    var loginModelObservable: Observable<ForgerModel> {
        return loginModelSubject
    }
    
    func forgertTapped() {
        loadingBehavior.accept(true)
        let params = [
            "email": EmailBehavior.value,
        ]
        NetWorkManager.sendRequest(method: .post, url: verifyemail,parameters:params) {[weak self] (err, response:ForgerModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            self.loadingBehavior.accept(false)
            if let error = err {
                // network error
             }
            else {
                guard let loginModel = response else { return }
                self.loginModelSubject.onNext(loginModel)
                
            }
        }
    }
}
