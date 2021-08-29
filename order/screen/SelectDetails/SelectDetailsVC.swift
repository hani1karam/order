//
//  SelectDetailsVC.swift
//  order
//
//  Created by hany karam on 8/26/21.
//

import UIKit
import RxSwift
import RxCocoa

class SelectDetailsVC: UIViewController {
    
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var desProduct: UILabel!
    let cartViewModel = AddToCartViewModel()
    var cartbranchesModel = [Product]()
    let disposeBag = DisposeBag()
    let productViewModel = ProductViewModel()

    var img:String?
    var name:String?
    var descrption:String?
    var price:Double?
    var id:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.kf.setImage(with: URL(string:img ?? ""))
        self.nameProduct.text = name
        self.priceProduct.text = "\(price!)"
        self.desProduct.text = descrption ?? "NO Descrption"
        self.navigationController?.isNavigationBarHidden = true
        addCartsetUpLoading()
        subscribeToResponse()
    }


    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
    func addCartsetUpLoading() {
        cartViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoader()
                
            } else {
                self.hideLoader()
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToResponse() {
        cartViewModel.loginModelObservable.subscribe(onNext: {
            if $0.status == true {
                ToastManager.shared.showError(message: $0.message ?? "", view: self.view, backgroundColor: .black)
            }
            else {
                ToastManager.shared.showError(message: $0.message ?? "", view: self.view, backgroundColor: .red)
            }
        }).disposed(by: disposeBag)
    }

    @IBAction func addCart(_ sender: Any) {
        cartViewModel.addToCart(productid: id)

    }
}
