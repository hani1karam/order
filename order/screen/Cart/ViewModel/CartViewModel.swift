//
//  CartViewModel.swift
//  order
//
//  Created by hany karam on 8/28/21.
//

import Foundation
import RxCocoa
import RxSwift
class CartViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    var branchesModelSubject = PublishSubject<[CartItem]>()
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    func showcart() {
        loadingBehavior.accept(true)
        NetWorkManager.sendRequest(method: .get, url:carts,header: ["Authorization": "\(NetworkHelper.getAccessToken() ?? "" )"]) { [weak self](err, response:ShowCart?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
                print(err)
            }  else {
                guard let branchesModel = response else { return }
                if branchesModel.data?.cartItems?.count ?? 0 > 0 {
                    self.branchesModelSubject.onNext(branchesModel.data?.cartItems ?? [])
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
            }
        }
    }
}
