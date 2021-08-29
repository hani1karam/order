//
//  BestSellingTableViewCell.swift
//  order
//
//  Created by hany karam on 8/24/21.
//

import UIKit

class BestSellingTableViewCell: UITableViewCell {
    @IBOutlet weak var ViewHome: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var price: UILabel!
    var buttonPressed : (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewHome.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        ViewHome.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        img.layer.cornerRadius = 15.0
        ViewHome.layer.cornerRadius = 10
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func reloadImage(image: Datum) {
        self.img.kf.indicatorType = .activity
        if let img = URL(string: image.image ?? ""){
            DispatchQueue.main.async {
                self.img.kf.setImage(with: img)
            }
            
        }
    }
    
    @IBAction func addCart(_ sender: Any) {
        buttonPressed()
    }
    
}
