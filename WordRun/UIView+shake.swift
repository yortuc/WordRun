//
//  UIView+shake.swift
//  English Speaking Practice - Words
//
//  Created by Evren Yortuçboylu on 05/12/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func shake(duration: CFTimeInterval = 7/100, repeatCount: Int = 2) {
        let anim = CAKeyframeAnimation( keyPath:"transform" )
        anim.values = [
            NSValue( caTransform3D:CATransform3DMakeTranslation(-15, 0, 0 ) ),
            NSValue( caTransform3D:CATransform3DMakeTranslation( 15, 0, 0 ) )
        ]
        anim.autoreverses = true
        anim.repeatCount = 2
        anim.duration = 10/100
        
        self.layer.add( anim, forKey:nil )
    }
}
