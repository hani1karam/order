//
//  CategoriesCollectionViewCell.swift
//  order
//
//  Created by hany karam on 8/24/21.
//

import UIKit
import Kingfisher
class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ViewHome: UIView!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewHome.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        ViewHome.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        ViewHome.layer.cornerRadius = 10
    }
    func reloadImage(image: CatrogyDatum) {
        self.image.kf.indicatorType = .activity
        if let img = URL(string: image.image ?? ""){
            DispatchQueue.main.async {
                self.image.kf.setImage(with: img)
            }
            
        }
    }
    
}
