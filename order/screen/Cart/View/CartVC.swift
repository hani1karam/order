//
//  CartVC.swift
//  order
//
//  Created by hany karam on 8/27/21.
//

import UIKit
import RxSwift
import RxCocoa

class CartVC: UIViewController,UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var total: UILabel!
    
    static let cellIdentifierTableViewCell = "CartTableViewCell"
    let branchesViewModel = CartViewModel()
    let disposeBag = DisposeBag()
    var branchesModel = [CartItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        settup()
        tableView.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        setUpLoading()
        setUpBinding()
        setUpUTableViewDataSource()
        setUpUTableViewDelegate()
        getBranches()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 173
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func settup(){
        self.tableView.register(UINib(nibName: CartVC.cellIdentifierTableViewCell, bundle: nil), forCellReuseIdentifier:  CartVC.cellIdentifierTableViewCell)
        
    }
    @IBAction func back(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
        
    }
    func setUpLoading() {
        branchesViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoader()
                
            } else {
                self.hideLoader()
            }
        }).disposed(by: disposeBag)
    }
    func setUpBinding() {
        self.branchesViewModel.branchesModelSubject.subscribe { (model) in
            self.branchesModel = model
        }.disposed(by: disposeBag)
    }
    func setUpUTableViewDataSource() {
        self.branchesViewModel.branchesModelSubject.asObservable()
            .bind(to: self.tableView
                    .rx
                    .items(cellIdentifier: CartVC.cellIdentifierTableViewCell,
                           cellType: CartTableViewCell.self)) { row, branch, cell in
                cell.titleLBL.text =  self.branchesModel[row].product?.name
                cell.price.text = "\(self.branchesModel[row].product?.price ?? 0)"
                cell.reloadImage(image: self.branchesModel[row].product!)
            }.disposed(by:disposeBag)
    }
    func setUpUTableViewDelegate() {
        tableView
            .rx
            .modelSelected(CartItem.self)
            .subscribe(onNext: { [weak self]  branch in
                
                
            })
            .disposed(by: disposeBag)
    }
    func getBranches() {
        branchesViewModel.showcart()
    }
    
}
