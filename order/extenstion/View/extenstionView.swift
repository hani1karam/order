//
//  extenstionView.swift
//  order
//
//  Created by hany karam on 8/24/21.
//

import UIKit
extension UIView{
    func static_shadow(withOffset value:CGSize,color: CGColor){
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 2.5
        self.layer.shadowOffset = value
        self.layer.shadowRadius = 2.25
        
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}

