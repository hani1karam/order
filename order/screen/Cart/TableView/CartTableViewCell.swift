//
//  CartTableViewCell.swift
//  order
//
//  Created by hany karam on 8/27/21.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var price: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.cornerRadius = 15.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func reloadImage(image: CartItemProduct) {
        self.img.kf.indicatorType = .activity
        if let img = URL(string: image.image ?? ""){
            DispatchQueue.main.async {
                self.img.kf.setImage(with: img)
            }
            
        }
    }
    
}
