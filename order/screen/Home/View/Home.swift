//
//  Home.swift
//  order
//
//  Created by hany karam on 8/23/21.
//

import UIKit
import RxSwift
import RxCocoa

class Home: UIViewController,UICollectionViewDelegateFlowLayout, UITableViewDelegate{
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var HomeCV: UICollectionView!
    
    static let cellIdentifierDemoCell = "CategoriesCollectionViewCell"
    static let cellIdentifierTableViewCell = "BestSellingTableViewCell"
    let branchesViewModel = BranchesViewModel()
    let productViewModel = ProductViewModel()
    let cartViewModel = AddToCartViewModel()
    let disposeBag = DisposeBag()
    var branchesModel = [CatrogyDatum]()
    var productbranchesModel = [Datum]()
    var cartbranchesModel = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.delegate = self
        tableView.delegate = self
        setupUI()
        setUpUI()
    }
    func setupUI(){
        collectionview.register(UINib(nibName: Home.cellIdentifierDemoCell, bundle: nil), forCellWithReuseIdentifier: Home.cellIdentifierDemoCell)
        
        self.tableView.register(UINib(nibName: Home.cellIdentifierTableViewCell, bundle: nil), forCellReuseIdentifier:  Home.cellIdentifierTableViewCell)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width * 0.5) - 10, height: 183)
        
    }
    func setUpUI() {
        setUpLoading()
        setUpBinding()
        setUpUTableViewDataSource()
        setUpUTableViewDelegate()
        getBranches()
        productSetUpLoading()
        productsetUpBinding()
        productSetUpUTableViewDataSource()
        productsetUpUTableViewDelegate()
        productgetBranches()
        addCartsetUpLoading()
        subscribeToResponse()
    }
    func setUpLoading() {
        productViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoader()
                
            } else {
                self.hideLoader()
            }
        }).disposed(by: disposeBag)
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
    
    
    
    func productSetUpLoading() {
        productViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
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
    
    func productsetUpBinding() {
        self.productViewModel.branchesModelSubject.subscribe { (model) in
            self.productbranchesModel = model
        }.disposed(by: disposeBag)
    }
    func setUpUTableViewDataSource() {
        self.branchesViewModel.branchesModelSubject.asObservable()
            .bind(to: self.HomeCV
                    .rx
                    .items(cellIdentifier: Home.cellIdentifierDemoCell,
                           cellType: CategoriesCollectionViewCell.self)) { row, branch, cell in
                cell.titleLBL.text =  self.branchesModel[row].name
                cell.reloadImage(image: branch)
            }.disposed(by:disposeBag)
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
    
    
    
    func setUpUTableViewDelegate() {
        HomeCV
            .rx
            .modelSelected(CatrogyDatum.self)
            .subscribe(onNext: { [weak self]  branch in
                let sampleVC = DetailsVC(nibName: "DetailsVC", bundle: nil) as! DetailsVC
                sampleVC.id = branch.id
                self?.navigationController?.pushViewController(sampleVC, animated: false)
                
                
            })
            .disposed(by: disposeBag)
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
    
    func getBranches() {
        branchesViewModel.showCatrogy()
    }
    func productgetBranches() {
        productViewModel.showProduct(id: 45)
    }
    
}
