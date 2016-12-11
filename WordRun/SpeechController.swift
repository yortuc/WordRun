//
//  SpeechController.swift
//  WordRun
//
//  Created by Evren Yortuçboylu on 10/12/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import Foundation
import Speech

class SpeechController: NSObject, SFSpeechRecognizerDelegate {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest? = nil
    
    private var audioEngine = AVAudioEngine()
    private let audioSession = AVAudioSession.sharedInstance()

    private var word: String
    private var taskResult: (_ result: String?, _ error: Error?, _ word: String, _ speechController: SpeechController)-> ()
    
    init(word: String, response: @escaping (String?, Error?, String, SpeechController)->()) {
        self.word = word
        self.taskResult = response

        super.init()

        self.speechRecognizer?.delegate = self
        
        self.runRequest()
    }
    
    func runRequest() {
        self.initAudio()
        self.createRequest()
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        print("Speech Recognizer \(available)")
    }
    
    
    
    // Init Audio
    func initAudio() {
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
            
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
    
    func createRequest() {
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.contextualStrings = [ self.word ]
        
        recognitionRequest.shouldReportPartialResults = true
        
        speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            let word = result?.bestTranscription.formattedString.lowercased()
            
            self.taskResult(word, error, self.word, self)
        })
    }
    
    func dispose() {
        self.recognitionRequest?.endAudio()
        self.recognitionRequest = nil
        
        self.audioEngine.stop()
        
        if audioEngine.isRunning {
            print("audioEngine is running")
            audioEngine = AVAudioEngine()
            try! AVAudioSession.sharedInstance().setActive(false)
        }
        
        print("word task ended")
    }
    
    deinit {
        self.dispose()
        print("word task ended")
    }
}
