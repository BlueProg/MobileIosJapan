//
//  ExerciceViewController.swift
//  BaseRomaji
//
//  Created by Mathieu MOLE on 3/20/16.
//  Copyright © 2016 Mathieu MOLE. All rights reserved.
//

import UIKit

class ExerciceViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSearchWord: UILabel!
    
    @IBOutlet weak var outletButtonTopLeft: UIButton!
    @IBOutlet weak var outletButtonTopRight: UIButton!
    @IBOutlet weak var outletButtonBottomLeft: UIButton!
    @IBOutlet weak var outletButtonBottomRight: UIButton!
    
    @IBOutlet weak var labelQuestionNumber: UILabel!
    
    var mode = "train"
    var lesson: Lesson!
    
    var number = -1
    var buttonWord = 0
    var indexWord = 0
    
    func RandomExclu(Exclu: [Int]) -> Int {
    
        var newRandom = -1
        
        while (newRandom == -1) {
            let testNumber = Int(arc4random_uniform(UInt32(lesson.dicoFr.count)))
            newRandom = testNumber
            for numberExclu in Exclu {
                if newRandom == numberExclu {
                    newRandom = -1
                    break
                }
            }
        }
        return newRandom
    }
    
    func NewWord() {
        print("newWord with mode: " + mode)
        number += 1
        if mode == "TrainingMode" {
            print("enter train mode")
            var numberGenerate = [Int]()
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            print("0: " + String(numberGenerate[0]) + " dicoJap: " + lesson.dicoJap[numberGenerate[0]])
            print("1: " + String(numberGenerate[1]) + " dicoJap: " + lesson.dicoJap[numberGenerate[1]])
            print("2: " + String(numberGenerate[2]) + " dicoJap: " + lesson.dicoJap[numberGenerate[2]])
            print("3: " + String(numberGenerate[3]) + " dicoJap: " + lesson.dicoJap[numberGenerate[3]])
            outletButtonTopLeft.setTitle(lesson.dicoJap[numberGenerate[0]], forState: .Normal)
            outletButtonTopRight.setTitle(lesson.dicoJap[numberGenerate[1]], forState: .Normal)
            outletButtonBottomLeft.setTitle(lesson.dicoJap[numberGenerate[2]], forState: .Normal)
            outletButtonBottomRight.setTitle(lesson.dicoJap[numberGenerate[3]], forState: .Normal)
            
            outletButtonTopLeft.setTitleColor(UIColor.blueColor(), forState: .Normal)
            outletButtonTopRight.setTitleColor(UIColor.blueColor(), forState: .Normal)
            outletButtonBottomLeft.setTitleColor(UIColor.blueColor(), forState: .Normal)
            outletButtonBottomRight.setTitleColor(UIColor.blueColor(), forState: .Normal)
            buttonWord = Int(arc4random_uniform(4))
            indexWord = numberGenerate[buttonWord]
            
            print("bottonWord: " + String(buttonWord))
            print("indexWord: " + String(indexWord) + " , label: " + lesson.dicoFr[indexWord])
            labelSearchWord.text = lesson.dicoFr[indexWord]
        }
        else if mode == "ExamMode" {
        
        }
        else {
        
        }
    }
    
    /*
 
     Training: Pas de limite de question, les mots sont choisie de maniere random
     Exam: 35 Questions posé avec répetition si erreur, les mots sont listés de 3 à 4fois
     Focus:Pas de limite mais le random aventage les mots ayant des erreurs plus forte
     
     */
    
    func CheckWord(choice: Int) {
        
        // actualisation call
        lesson.dicoCall[indexWord] += 1
        if choice != buttonWord {
            if choice == 0 {
                outletButtonTopLeft.setTitleColor(UIColor.redColor(), forState: .Normal)
            }
            else if choice == 1 {
                outletButtonTopRight.setTitleColor(UIColor.redColor(), forState: .Normal)
            }
            else if choice == 2 {
                outletButtonBottomLeft.setTitleColor(UIColor.redColor(), forState: .Normal)
            }
            else {
                outletButtonBottomRight.setTitleColor(UIColor.redColor(), forState: .Normal)
            }
        }
        else {
            if choice == 0 {
                outletButtonTopLeft.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            else if choice == 1 {
                outletButtonTopRight.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            else if choice == 2 {
                outletButtonBottomLeft.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            else {
                outletButtonBottomRight.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            lesson.dicoSucess[indexWord] += 1
            NewWord()
        }
        print("Word: " + lesson.dicoFr[indexWord] + " was call :" + String(lesson.dicoCall[indexWord]))
        print("Find :" + String(lesson.dicoSucess[indexWord]) + " with sucess")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = lesson.lessonTitle
        NewWord()
    }
  
    @IBAction func buttonTopLeft(sender: AnyObject) {
        print("buttonLeft")
        CheckWord(0)
    }
    
    @IBAction func buttonTopRight(sender: AnyObject) {
        print("buttonRight")
        CheckWord(1)
    }
    
    @IBAction func buttonBottomLeft(sender: AnyObject) {
        print("buttonBottomLeft")
        CheckWord(2)
    }
    
    @IBAction func buttonBottomRight(sender: AnyObject) {
        print("buttonBottomRight")
        CheckWord(3)
    }
}
