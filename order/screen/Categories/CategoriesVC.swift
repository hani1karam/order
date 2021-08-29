//
//  CategoriesVC.swift
//  order
//
//  Created by hany karam on 8/25/21.
//

import UIKit
import RxSwift
import RxCocoa

class CategoriesVC: UIViewController,UICollectionViewDelegate
                    ,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionview: UICollectionView!
    
    static let cellIdentifierDemoCell = "CatrogyCollectionViewCell"
    let branchesViewModel = BranchesViewModel()
    let disposeBag = DisposeBag()
    var branchesModel = [CatrogyDatum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.delegate = self
        setupUI()
        setUpLoading()
        setUpBinding()
        setUpUTableViewDataSource()
        setUpUTableViewDelegate()
        getBranches()
    }
    func setupUI(){
        collectionview.register(UINib(nibName: CategoriesVC.cellIdentifierDemoCell, bundle: nil), forCellWithReuseIdentifier: CategoriesVC.cellIdentifierDemoCell)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width * 0.5) - 10, height: 230)
        
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let sampleVC = DetailsVC(nibName: "DetailsVC", bundle: nil)
//        self.navigationController?.pushViewController(sampleVC, animated: false)
//
//
//    }
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
            .bind(to: self.collectionview
                    .rx
                    .items(cellIdentifier: CategoriesVC.cellIdentifierDemoCell,
                           cellType: CatrogyCollectionViewCell.self)) { row, branch, cell in
                cell.titleLBL.text =  self.branchesModel[row].name
                cell.reloadImage(image: branch)
            }.disposed(by:disposeBag)
    }
    func setUpUTableViewDelegate() {
        collectionview
            .rx
            .modelSelected(CatrogyDatum.self)
            .subscribe(onNext: { [weak self]  branch in
                let sampleVC = DetailsVC(nibName: "DetailsVC", bundle: nil) as! DetailsVC
                sampleVC.id = branch.id
                self?.navigationController?.pushViewController(sampleVC, animated: false)
                
                
            })
            .disposed(by: disposeBag)
    }
    func getBranches() {
        branchesViewModel.showCatrogy()
    }
    
    
}
