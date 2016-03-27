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
        print("newWord")
        number += 1
        if mode == "train" {
            var numberGenerate = [Int]()
            numberGenerate[0] = RandomExclu(numberGenerate)
            numberGenerate[1] = RandomExclu(numberGenerate)
            numberGenerate[2] = RandomExclu(numberGenerate)
            numberGenerate[3] = RandomExclu(numberGenerate)
            outletButtonTopLeft.setTitle(lesson.dicoJap[numberGenerate[0]], forState: .Normal)
            outletButtonTopRight.setTitle(lesson.dicoJap[numberGenerate[1]], forState: .Normal)
            outletButtonBottomLeft.setTitle(lesson.dicoJap[numberGenerate[2]], forState: .Normal)
            outletButtonBottomRight.setTitle(lesson.dicoJap[numberGenerate[3]], forState: .Normal)
            buttonWord = Int(arc4random_uniform(4))
            indexWord = numberGenerate[buttonWord]
            labelSearchWord.text = lesson.dicoFr[indexWord]
        }
        else if mode == "exam" {
        
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
        
        if choice != buttonWord {
            if choice == 1 {
                outletButtonTopLeft.setTitleColor(UIColor.redColor(), forState: .Normal)
            }
            else if choice == 2 {
                outletButtonTopRight.setTitleColor(UIColor.redColor(), forState: .Normal)
            }
            else if choice == 3 {
                outletButtonBottomLeft.setTitleColor(UIColor.redColor(), forState: .Normal)
            }
            else {
                outletButtonBottomRight.setTitleColor(UIColor.redColor(), forState: .Normal)
            }
            // save Error
        }
        else {
            if choice == 1 {
                outletButtonTopLeft.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            else if choice == 2 {
                outletButtonTopRight.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            else if choice == 3 {
                outletButtonBottomLeft.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            else {
                outletButtonBottomRight.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            // save Sucess
            NewWord()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = lesson.lessonTitle
        /*labelSearchWord.text = lesson.dicoFr[0]
        
        outletButtonTopLeft.setTitle(lesson.dicoFr[0], forState: .Normal)
        outletButtonTopRight.setTitle(lesson.dicoFr[1], forState: .Normal)
        outletButtonBottomLeft.setTitle(lesson.dicoFr[2], forState: .Normal)
        outletButtonBottomRight.setTitle(lesson.dicoFr[3], forState: .Normal)*/
        print("viewLoad")
        NewWord()
        
    }
  
    @IBAction func buttonTopLeft(sender: AnyObject) {
        print("buttonLeft")
        CheckWord(1)
    }
    
    @IBAction func buttonTopRight(sender: AnyObject) {
        print("buttonRight")
        CheckWord(2)
    }
    
    @IBAction func buttonBottomLeft(sender: AnyObject) {
        print("buttonBottomLeft")
        CheckWord(3)
    }
    
    @IBAction func buttonBottomRight(sender: AnyObject) {
        print("buttonBottomRight")
        CheckWord(4)
    }
}
