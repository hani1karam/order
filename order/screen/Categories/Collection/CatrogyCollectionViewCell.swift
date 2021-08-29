//
//  CatrogyCollectionViewCell.swift
//  order
//
//  Created by hany karam on 8/25/21.
//

import UIKit

class CatrogyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ViewHome: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var opcoty: UIView!
    @IBOutlet weak var titleLBL: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewHome.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        ViewHome.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        ViewHome.layer.cornerRadius = 10
        img.layer.cornerRadius = 15.0
        opcoty.backgroundColor = UIColor(white: 0.9, alpha: 0.08)


    }
    func reloadImage(image: CatrogyDatum) {
        self.img.kf.indicatorType = .activity
        if let img = URL(string: image.image ?? ""){
            DispatchQueue.main.async {
                self.img.kf.setImage(with: img)
            }
            
        }
    }

}
