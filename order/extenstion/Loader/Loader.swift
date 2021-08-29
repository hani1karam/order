//
//  Loader.swift
//  order
//
//  Created by hany karam on 8/27/21.
//

import Foundation
import NVActivityIndicatorView

extension UIViewController : NVActivityIndicatorViewable{
    
    func showLoader() {
        DispatchQueue.main.async {
            let size = CGSize(width: 40, height: 40)
            self.startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.ballClipRotate)
        }
    }
    //
    //    //hide loader from screen
    func hideLoader() {
        DispatchQueue.main.async {
            self.stopAnimating()
        }
    }
    
    func hideNavigationBarWithImage(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    // Hide the navigation bar on the this view controller
    func hideNavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.isUserInteractionEnabled = false
    }
    // Show the navigation bar on other view controllers
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isUserInteractionEnabled = true
    }
    
    func noConnectionAlertError() {
        let alert = UIAlertController(title: "Error",
                                      message: "Please check your internet connection",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        alert.view.tintColor = UIColor.red
        
        self.present(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.red
        
    }
    
    func showError(_ errorMsg: String, _ title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: "\(errorMsg)",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            alert.view.tintColor = UIColor.red
        }
    }
    
    //MARK: Segue
    
    func goToPopupView(storyboardName: String, withIdentifier : String){
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: withIdentifier)
        screen.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        view.window?.layer.add(transition, forKey: kCATransition)
        self.present(screen, animated: false, completion: nil)
    }
    
    func goToPresentVC(storyboard: String,withIdentifier: String ){
        let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: withIdentifier)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func goToPresentWithNavigation(storyboard: String,withIdentifier: String ){
        let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: withIdentifier)
        let nvg = UINavigationController(rootViewController: vc)
        nvg.modalPresentationStyle = .fullScreen
        self.present(nvg, animated: true, completion: nil)
    }
    
    func goToPushVC(storyboard: String,withIdentifier: String ){
        let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: withIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
