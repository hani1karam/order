//
//  ProducrtViewModel.swift
//  order
//
//  Created by hany karam on 8/28/21.
//

import Foundation
import RxCocoa
import RxSwift
 class ProductViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    var branchesModelSubject = PublishSubject<[Datum]>()
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    func showProduct(id:Int?) {
        loadingBehavior.accept(true)
        NetWorkManager.sendRequest(method: .get, url: "https://student.valuxapps.com/api/products?category_id=\(id!)") { [weak self](err, response:ShowProduct?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
                print(err)
            }  else {
                guard let branchesModel = response else { return }
                if branchesModel.data?.data?.count ?? 0 > 0 {
                    self.branchesModelSubject.onNext(branchesModel.data?.data ?? [])
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
            }
        }
    }
}
