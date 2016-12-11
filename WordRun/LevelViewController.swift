//
//  LevelViewController.swift
//  WordRun
//
//  Created by Evren Yortuçboylu on 09/12/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {

    @IBOutlet weak var lblTitle: UITextView!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        let currentDeck = WordList.decs[WordList.deckIndex]
        self.lblTitle.text = currentDeck.title
        self.lblDescription.text = currentDeck.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
            self.performSegue(withIdentifier: "gotoGame", sender: self)
        })
    }
}
