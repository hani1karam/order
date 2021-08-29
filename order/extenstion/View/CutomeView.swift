//
//  CutomeView.swift
//  order
//
//  Created by hany karam on 8/26/21.
//

import UIKit
extension UIViewController{
    func getCard(ViewHome:UIView){
        ViewHome.backgroundColor = UIColor.white
        ViewHome.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        ViewHome.layer.cornerRadius = 13

    }
}
