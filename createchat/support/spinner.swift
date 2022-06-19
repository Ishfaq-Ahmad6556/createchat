//
//  spinner.swift
//  Instagram Clone
//
//  Created by Ishfaq Ahmad on 26/02/2022.
//

import Foundation
import UIKit

 var  spinview : UIView?
extension UIViewController {
    
 func createspinner(){

     spinview = UIView(frame: self.view.bounds)
     spinview?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.4)
     
     let ai = UIActivityIndicatorView(style:.whiteLarge)
     ai.center = spinview!.center
     ai.startAnimating()
     spinview?.addSubview(ai)
     self.view.addSubview(spinview!)
//     DispatchQueue.main.asyncAfter(deadline: .now() + 10){
//                 self.removespinner()
//                    }
     
 }
    
    func removespinner(){
        spinview?.removeFromSuperview()
        spinview = nil
    }
}


