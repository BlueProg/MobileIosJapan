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
    var arrayWord = [Int] ()
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
    
    func ArrayShuffle(var arrayNumber: [Int]) -> [Int] {
        
        for i in 0...arrayNumber.count - 1 {
            let randomIndex = Int(rand()) % lesson.dicoFr.count
            let numberSave = arrayNumber[i]
            arrayNumber[i] = arrayNumber[randomIndex]
            arrayNumber[randomIndex] = numberSave
        }
        return arrayNumber
    }
    
    func CreateDuplicateArray() -> [Int]{
        var arrayNumber = [Int]()
        
        // fill array with triple duplication number
        
        for i in 0...lesson.dicoFr.count - 1 {
            arrayNumber.append(i)
            arrayNumber.append(i)
            arrayNumber.append(i)
        }
        return arrayNumber
    }
    
    func NewWord() {

        // clean color
        
        outletButtonTopLeft.setTitleColor(UIColor.blueColor(), forState: .Normal)
        outletButtonTopRight.setTitleColor(UIColor.blueColor(), forState: .Normal)
        outletButtonBottomLeft.setTitleColor(UIColor.blueColor(), forState: .Normal)
        outletButtonBottomRight.setTitleColor(UIColor.blueColor(), forState: .Normal)
        
        var numberGenerate = [Int]()
        
        buttonWord = Int(arc4random_uniform(4)) + 1
        if mode == "TrainingMode" {
            // Make random choice
            numberGenerate.append(-1)
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
        }
        else if mode == "ExamMode" {
            // Make array of choice
            
            // first creation
            number += 1
            if (arrayWord.count == 0) {
                srand(UInt32(lesson.seedRandom))
                let newArray = CreateDuplicateArray()
                arrayWord = ArrayShuffle(newArray)
            }
            numberGenerate.append(arrayWord[number])
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate[buttonWord] = numberGenerate[0]
        }

        // set word in view
        
        indexWord = numberGenerate[buttonWord]
        outletButtonTopLeft.setTitle(lesson.dicoJap[numberGenerate[1]], forState: .Normal)
        outletButtonTopRight.setTitle(lesson.dicoJap[numberGenerate[2]], forState: .Normal)
        outletButtonBottomLeft.setTitle(lesson.dicoJap[numberGenerate[3]], forState: .Normal)
        outletButtonBottomRight.setTitle(lesson.dicoJap[numberGenerate[4]], forState: .Normal)
        
        // choose looking word and set
        
        
        
        labelSearchWord.text = lesson.dicoFr[indexWord]
    }
    
    /*
 
     Training: Pas de limite de question, les mots sont choisie de maniere random
     Exam: 35 Questions posé avec répetition si erreur, les mots sont listés de 3 à 4fois
     Focus:Pas de limite mais le random aventage les mots ayant des erreurs plus forte
     
     */
    
    func CheckWord(choice: Int) {
        
        // actualisation call
        lesson.dicoCall[indexWord] += 1
        if choice != buttonWord - 1 {
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
