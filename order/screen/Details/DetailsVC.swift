//
//  DetailsVC.swift
//  order
//
//  Created by hany karam on 8/25/21.
//

import UIKit
import DropDown
import RxSwift
import RxCocoa

class DetailsVC: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwDropDown: UIButton!
    
    static let cellIdentifierTableViewCell = "BestSellingTableViewCell"
    let dropDownValues = [ "low to height","height to low"]
    let dropDown = DropDown()
    let productViewModel = ProductViewModel()
    let disposeBag = DisposeBag()
    var productbranchesModel = [Datum]()
    let cartViewModel = AddToCartViewModel()
    
    var id:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        setupUI()
        
    }
    
    
    func setupUI(){
        self.tableView.register(UINib(nibName: DetailsVC.cellIdentifierTableViewCell, bundle: nil), forCellReuseIdentifier:  DetailsVC.cellIdentifierTableViewCell)
        
        productSetUpLoading()
        productsetUpBinding()
        productSetUpUTableViewDataSource()
        productsetUpUTableViewDelegate()
        productgetBranches()
        addCartsetUpLoading()
        subscribeToResponse()

        
    }
    @IBAction func Filter(_ sender: Any) {
        dropDown.anchorView = vwDropDown
        dropDown.dataSource = dropDownValues
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            //  self.status = item
        }
        self.dropDown.show()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }

    func productSetUpLoading() {
        productViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoader()
                
            } else {
                self.hideLoader()
            }
        }).disposed(by: disposeBag)
    }
    
    func productsetUpBinding() {
        self.productViewModel.branchesModelSubject.subscribe { (model) in
            self.productbranchesModel = model
        }.disposed(by: disposeBag)
    }
    func productSetUpUTableViewDataSource() {
        self.productViewModel.branchesModelSubject.asObservable()
            .bind(to: self.tableView
                    .rx
                    .items(cellIdentifier: Home.cellIdentifierTableViewCell,
                           cellType: BestSellingTableViewCell.self)) { row, branch, cell in
                cell.titleLBL.text =  self.productbranchesModel[row].name
                cell.reloadImage(image: branch)
                cell.price.text = "\(self.productbranchesModel[row].price!)"
                cell.buttonPressed = {
                    print(self.productbranchesModel[row].id)
                    self.cartViewModel.addToCart(productid: self.productbranchesModel[row].id)
                }
                
            }.disposed(by:disposeBag)
    }
    func productsetUpUTableViewDelegate() {
        tableView.rx.itemSelected
            .subscribe (onNext:{ [weak self] indexPath in
                let sampleVC = SelectDetailsVC(nibName: "SelectDetailsVC", bundle: nil) as? SelectDetailsVC
                sampleVC?.img = self?.productbranchesModel[indexPath.row].image
                sampleVC?.name = self?.productbranchesModel[indexPath.row].name
                sampleVC?.price = self?.productbranchesModel[indexPath.row].price
                sampleVC?.id = self?.productbranchesModel[indexPath.row].id

                self?.navigationController?.pushViewController(sampleVC!, animated: false)

            })
            .disposed(by: disposeBag)
    }
    func productgetBranches() {
        productViewModel.showProduct(id: id)
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
    
}
