//
//  UIView+fadeInOutDispose.swift
//  WordRun
//
//  Created by Evren Yortuçboylu on 11/12/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func fadeInOutDispose(dispose:Bool = true) {
        
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            self.alpha = 1
            self.alpha = 1
        }) { (Bool) -> Void in
            
            // After the animation completes, fade out the view after a delay
            
            UIView.animate(withDuration: 3.5, delay: 2.0, options: .curveEaseInOut, animations: { () -> Void in
                self.alpha = 0
            },completion: { finished in
                if dispose {
                    self.removeFromSuperview()
                }
            })
        }
    }
    
}
