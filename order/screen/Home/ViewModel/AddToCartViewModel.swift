//
//  AddToCartViewModel.swift
//  order
//
//  Created by hany karam on 8/28/21.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire
class AddToCartViewModel {
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    private var branchesModelSubject = PublishSubject<[AddCartModel]>()
    var branchesModelObservable: Observable<[AddCartModel]> {
        return branchesModelSubject
    }
    private var loginModelSubject = PublishSubject<AddCartModel>()
    var loginModelObservable: Observable<AddCartModel> {
        return loginModelSubject
    }
    func addToCart(productid:Int?) {
        loadingBehavior.accept(true)
        let params = ["product_id":productid ?? 0,] as [String : Any]
        
        NetWorkManager.sendRequest(method: .post, url: carts,parameters:params,header: ["Authorization": "\(NetworkHelper.getAccessToken() ?? "" )"]) {[weak self] (err, response:AddCartModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
                // network error
            }
            else {
                guard let loginModel = response else { return }
                print(response)
                self.loginModelSubject.onNext(loginModel)
            }
        }
    }
}
