//
//  ViewController.swift
//  English Speaking Practice - Words
//
//  Created by Evren Yortuçboylu on 04/12/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    //- outlets
    @IBOutlet weak var lblDeckTitle: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var imgLive1: UIImageView!
    @IBOutlet weak var imgLive2: UIImageView!
    @IBOutlet weak var imgLive3: UIImageView!
    @IBOutlet weak var imgMic: UIImageView!
    @IBOutlet weak var lblSay: UILabel!
    
    //- fields
    private var currentWord: String = ""
    private var currentTitle: String = ""
    private var livesCount = 3
    private var index = 0
    private var wordList = WordList()
    private var score = 0.0
    private var speechController: SpeechController?
    
    override func viewWillAppear(_ animated: Bool) {
        self.microphoneButton.layer.cornerRadius = 5
        self.lblDeckTitle.isHidden = true
        
        self.lblSay.alpha = 0
        self.imgMic.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Skip word
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        // DEBUG: swipe right for wrong answer
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.wrongAnswer))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        self.textView.slideInFromLeft()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            print("AVAudioSession error. cant set category")
        }
    
        self.speakWord(word: "Welcome to the Word Run")
    }
    
    func swiped(_ gesture: UIGestureRecognizer) {
        // skipped
        
        print("skipped")
        self.score = self.score * 0.75;
        OperationQueue.main.addOperation {
            self.lblScore.text = "Score: \(Int(self.score))"
        }
        self.textView.slideInFromLeft()
        
        var word: String
        var title: String
        (word, title) = self.wordList.getWord()
        self.createWordTask(word: word, title: title)
    }

    
    @IBAction func microphoneTapped(_ sender: AnyObject) {
        startGame()
        self.lblSay.fadeInOutDispose()
        self.imgMic.fadeInOutDispose()
    }
    
    func startGame() {
        self.microphoneButton.slideInFromLeft()
        self.microphoneButton.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.15) {
            self.textView.slideInFromLeft()
            
            var word: String
            var title: String
            (word, title) = self.wordList.getWord()
            
            self.lblScore.isHidden = false
            self.lblScore.slideInFromRight()
            
            /*
            self.imgLive1.isHidden = false
            self.imgLive2.isHidden = false
            self.imgLive3.isHidden = false
            
           
            self.imgLive1.slideInFromLeft()
            self.imgLive2.slideInFromLeft()
            self.imgLive3.slideInFromLeft()*/
            
            self.createWordTask(word: word, title: title)
        }
    }
    
    func createWordTask(word: String, title: String) {
        
        self.speechController = SpeechController(word: word, response: {
            (result, error, word, sc) in
            
            self.taskResult(result: result, error: error, word: word, speechController: sc )
        })
        
        self.currentWord = word
        
        OperationQueue.main.addOperation {
            self.textView.text =  word
        }
        
        if title != self.currentTitle {
            
            self.currentTitle = title
            
            print("current title changed: \(self.currentTitle)")
            
            // self.showDeckTitle()
        }
    }
    
    func showDeckTitle() {
        OperationQueue.main.addOperation {
            self.lblDeckTitle.isHidden = false
            self.lblDeckTitle.text = self.currentTitle
            self.view.layoutIfNeeded()
            
            self.lblDeckTitle.fadeInOutDispose(dispose: false)
        }
    }
    
    func taskResult(result: String?, error: Error?, word: String, speechController: SpeechController) -> Void {
        
        print("result: \(result)")
        
        if result != nil && self.speaking == false {
            
            print("word: \(result!)")
            
            // speechController.dispose()
            
            if result == currentWord {
                print("correct")
                self.score += 100
                OperationQueue.main.addOperation {
                    self.lblScore.text = "Score: \(Int(self.score))"
                }
                self.textView.slideInFromLeft()
                
                var title:String
                var word:String
                (word, title) = self.wordList.getWord()
                self.createWordTask(word: word, title: title)
                
                self.index += 1
            }
            else{
                print("wrong")
                
                self.score = self.score * 0.9
                
                OperationQueue.main.addOperation {
                    self.wrongAnswer()
                }
            }
        }
    }
    
    func wrongAnswer () {
        self.textView.shake()
        self.wordTaskWaiting = true
        self.speakWord(word: self.currentWord)
    }
    
    func speakWord(word:String) {
        
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.delegate = self
        
        if self.speaking {
            // TODO: öncekini sonlandır
        }
        
        synthesizer.speak(utterance)
        
        print("speak \(word)")
    }
    
    private var wordTaskWaiting = false
    
    private var speaking = false
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        self.speaking = true
        print("speaking started: \(self.speaking)")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.speaking = false
        print("speaking finished: \(self.speaking)")
        
        if self.wordTaskWaiting {
            self.createWordTask(word: self.currentWord, title: self.currentTitle)
            self.wordTaskWaiting = false
        }
    }
}



