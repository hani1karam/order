//
//  MainTabBarVC.swift
//  order
//
//  Created by hany karam on 8/24/21.
//

import UIKit

class MainTabBarVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        tabBarController?.delegate = self
        self.tabBar.tintColor = UIColor.white
        self.tabBar.backgroundColor = #colorLiteral(red: 0.2078222036, green: 0.2078569531, blue: 0.2078112364, alpha: 1)
        tabBar.layer.cornerRadius = 30
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 5)
        tabBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        tabBar.layer.shadowOpacity = 3;
        tabBar.layer.shadowRadius = 5;
        tabBar.isTranslucent = true
        tabBar.barStyle = .blackOpaque

        let item1 = Home()
        let item2 = CategoriesVC()
        let item3 = CartVC()
        let item4 = MoreVC()

        
        let icon1 = UITabBarItem(title: NSLocalizedString("Home",comment:""), image: UIImage(named: "Group 1537"), selectedImage: UIImage(named: "Icon"))
        let icon2 = UITabBarItem(title: NSLocalizedString("Categories",comment:""), image: UIImage(named: "Group 1538"), selectedImage: UIImage(named: "Group 1538"))
        let icon3 = UITabBarItem(title: NSLocalizedString("Cart",comment:""), image: UIImage(named: "Group 1540"), selectedImage: UIImage(named: "Group 1540"))
        let icon4 = UITabBarItem(title: NSLocalizedString("More",comment:""), image: UIImage(named: "Group 61"), selectedImage: UIImage(named: "Group 61"))

        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        item3.tabBarItem = icon3
        item4.tabBarItem = icon4

        let controllers = [item1,item2,item3,item4]
        self.viewControllers = controllers
    }


 
}
