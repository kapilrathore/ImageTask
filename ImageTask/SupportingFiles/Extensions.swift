//
//  Extensions.swift
//  FlickrSearch
//
//  Created by Kapil Rathore on 09/05/18.
//  Copyright © 2018 Kapil Rathore. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 5
    }
}

extension UIViewController {
    
    func showAlert(_ msg : String) {
        let alertController = UIAlertController(title: "Flickr Search", message: msg, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showLoadingView() {
        
        let loadingView = UIView()
        loadingView.tag = 1098
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColor.black
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd = UIActivityIndicatorView()
        actInd.tag = 1099
        actInd.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        actInd.transform = CGAffineTransform(scaleX: 2, y: 2)
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        actInd.startAnimating()
        
        loadingView.addSubview(actInd)
        self.view.addSubview(loadingView)
    }
    
    func hideLoadingView() {
        for subViews in self.view.subviews {
            if subViews.tag == 1098 {
                for subview in subViews.subviews {
                    if subview.tag == 1099 {
                        subview.removeFromSuperview()
                    }
                }
                subViews.removeFromSuperview()
            }
        }
    }
}
