//
//  BranchesViewModel.swift
//  order
//
//  Created by hany karam on 8/27/21.
//

import Foundation
import RxCocoa
import RxSwift
 class BranchesViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    var branchesModelSubject = PublishSubject<[CatrogyDatum]>()
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    func showCatrogy() {
        loadingBehavior.accept(true)
        NetWorkManager.sendRequest(method: .get, url: categories) { [weak self](err, response:ShowCatrogy?) in
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
