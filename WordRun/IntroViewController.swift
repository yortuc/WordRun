//
//  IntroViewController.swift
//  English Speaking Practice - Words
//
//  Created by Evren Yortuçboylu on 04/12/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import Foundation
import UIKit
import Speech

class IntroViewController: UIViewController {
    
    @IBOutlet weak var btnGrantPermissions: UIButton!
    
    @IBAction func grantPermissions(_ sender: Any) {
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4

            switch authStatus {
            case .authorized:
                
                let defaults = UserDefaults.standard
                defaults.setValue("ok", forKey: "user_permission")
                defaults.synchronize()
                
                OperationQueue.main.addOperation {
                    self.performSegue(withIdentifier: "gotoGame", sender: self)
                }
                
                break

            case .denied:
                print("User denied access to speech recognition")
                
            case .restricted:
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                print("Speech recognition not yet authorized")
            }
        } 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.btnGrantPermissions.layer.cornerRadius = 3
    }
    
    override func viewDidLoad() {
        
    }
}
