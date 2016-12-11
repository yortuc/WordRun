//
//  LogoPlaceholderViewController.swift
//  WordRun
//
//  Created by Evren Yortuçboylu on 09/12/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit

class LogoPlaceholderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        
        if let _ = defaults.string(forKey: "user_permission") {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                self.performSegue(withIdentifier: "gotoGame", sender: self)
            })
        }
        else{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                self.performSegue(withIdentifier: "gotoIntro", sender: self)
            })
        }
    }

    

}
