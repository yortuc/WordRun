//
//  WordController.swift
//  English Speaking Practice - Words
//
//  Created by Evren Yortuçboylu on 04/12/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

import Foundation

struct WordList {
    
    static let decs = [
        
        Deck(title: "Colors",
             description:"",
             words: ["black","blue","brown","gray","green","orange","pink","purple","red","white","yellow"]),
        
        Deck(title: "Body",
             description: "",
             words:["back","ears","eyes","face","feet","fingers","foot","hair","hands","head","knees","legs","mouth","neck","nose","shoulders","skin","stomach","teeth","thumbs","toes","tongue","tooth"
        ]),

        Deck(title: "Weather",
             description: "",
             words: ["clear","cloudy","cold","cool","foggy","hot","humid","rainy","snowy","stormy","sunny","warm","windy"]),
        
        Deck(title: "Months",
             description: "",
             words: ["January","February","March","April","May","June","July","August","September","October","November","December"
        ]),
        
        Deck(title: "Post office",
             description: "",
             words: ["letter","post card","mail","post office box","PO box","stamp","deliver mail","address","return address","zip code","insurance","printed matter","junk mail","personal mail","postal money order","air mail","sea mail","mailman","postal clerk","picture post car","postage","cancelled stamp","commemorative stamp","postbox","mailbox","stamp machine"
        ]),
        
        Deck(title: "transportation", description: "", words: [
            "airport","apartment building","bank","barber shop","book store","bowling alley","bus stop","church","convenience store","department store","fire department","gas station","hospital","house","library","movie theater","museum","office building","post office","restaurant","school","mall","supermarket","train station"
        ]),
        
        Deck(title: "animals", description: "", words: ["lligator","ant","bear","bee","bird","camel","cat","cheetah","chicken","chimpanzee","cow","crocodile","deer","dog","dolphin","duck","eagle","elephant","fish","fly","fox","frog","giraffe","goat","goldfish","hamster","hippopotamus","horse","kangaroo","kitten","lion","lobster","monkey","octopus","owl","panda","pig","puppy","rabbit","rat","scorpion","seal","shark","sheep","snail","snake","spider","squirrel","tiger","turtle","wolf","zebra"]),

        Deck(title: "fruits", description: "", words: ["apple","banana","cherry","grapefruit","grapes","lemon","lime","melon","orange","peach","pear","persimmon","pineapple","plum","strawberry","tangerine","watermelon"]),
        
        Deck(title: "bank", description: "", words: ["account","bills","borrow","alarm","cash","cashier","check","coins","credit","credit card","currency","customer","deposit","interest","lend","loan","manager","money","mortgage","pay","save"]),
        
        Deck(title: "cooking", description: "", words: ["bake","boil","broil","can opener","fry","grill","measuring cup","measuring spoon","microwave","mixing bowl","paper towels","poach","potholder","roast","rolling pin","scramble","simmer","knife","spoon","spatula","steam","strainer","timer","fork"]),
        
        Deck(title: "clothes", description: "", words: ["belt","boots","cap","coat","dress","gloves","hat","jacket","jeans","pajamas","pants","raincoat","scarf","shirt","shoes","skirt","slacks","slippers","socks","stockings","suit","sweater","sweatshirt","t-shirt","tie","trousers","underclothes","underpants","undershirt"]),

        Deck(title: "family members", description: "", words: ["aunt","brother","cousin","daughter","father","granddaughter","grandmother","grandson","mother","nephew","niece","sister","son","stepdaughter","stepmother","stepson","uncle"]),
        
        Deck(title: "Jobs", description:"", words: ["accountant","actor","actress","athlete","author","baker","banker","barber","beautician","broker","burglar","butcher","carpenter","chauffeur","chef","clerk","coach","craftsman","criminal","crook","dentist","doctor","editor","engineer","farmer","fire fighter","fisherman","judge","lawyer","magician","mechanic","musician","nurse","pharmacist","pilot","poet","policeman","politician","printer","professor","rabbi","priest","pastor","sailor","salesman","shoemaker","soldier","tailor","teacher","veterinarian","waiter","waitress","watchmaker"]),
        
        Deck(title: "House", description: "english adjectives blah blah", words:[ "apartment","ashtray","attic","basement","bathroom","bath tub","bed","bedding","bedroom","blanket","bolt","bookcase","brick","carpet","ceiling","cellar","cement","chair","chimney","closet","concrete","couch","curtain","cushion","desk","dining room","door","doorstep","drapes","dresser","fan","faucet","fireplace","floor","foundation","furnace","furniture","glass","hall","hinge","key","lamp","living room","lock","mirror","nail","paint","picture","plaster","plumbing","plywood","porch","rafter","roof","room","rug","screw","shelf","sink","sofa","stairs","table","toilet","wall","window","wire","wood"])
    ]
    
    static var deckIndex = 0
    
    static var wordIndex = 0
    
    
    // gets next word
    // getWord() -> (String,String) : (currentWord, currentDeckTitle)
    mutating func getWord() -> (String, String) {
        
        if WordList.wordIndex < WordList.decs[WordList.deckIndex].words.count {
            let retWord = WordList.decs[WordList.deckIndex].words[WordList.wordIndex]
            WordList.wordIndex += 1
            print("wordIndex \(WordList.wordIndex) deckIndex \(WordList.deckIndex)")
            
            return (retWord, WordList.decs[WordList.deckIndex].title)
        }
        
        WordList.deckIndex += 1
        WordList.wordIndex = 1
        let retWord = WordList.decs[WordList.deckIndex].words[0]
    
        print("wordIndex \(WordList.wordIndex) deckIndex \(WordList.deckIndex)")

        return (retWord, WordList.decs[WordList.deckIndex].title)
        
    }
    
    mutating func resetDeck() {
        WordList.wordIndex = 0
    }
    
    static var currentDeck: Deck {
        return WordList.decs[WordList.deckIndex]
    }
    
    static var currentWord: String {
        return WordList.currentDeck.words[WordList.wordIndex]
    }
    
    static var currentTitle: String {
        return WordList.currentDeck.title
    }
}
