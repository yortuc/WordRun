//
//  SegueFromLeft.swift
//  WordRun
//
//  Created by Evren Yortuçboylu on 09/12/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class SegueFromLeft: UIStoryboardSegue
{
    override func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.40,
                       delay: 0.0,
                       options: UIViewAnimationOptions.transitionFlipFromLeft,
                       animations: {
                            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
                       }) { finished in
                            src.present(dst, animated: false, completion: nil)
                       }
        
        UIView.animate(withDuration: 0.40,
                       delay: 0.0,
                       options: UIViewAnimationOptions.transitionFlipFromRight,
                       animations: {
                            src.view.transform = CGAffineTransform(translationX: -src.view.frame.width, y: 0)
                       },
                       completion: nil)
    }
}
