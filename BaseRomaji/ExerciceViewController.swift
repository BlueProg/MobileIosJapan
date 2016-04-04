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
    
    func RandFocus() -> Int {

        var max = 0
        for i in 0...lesson.dicoFr.count - 1 {
            max += lesson.dicoCall[i] - lesson.dicoSucess[i]
        }
        
        if max == 0 {
            return -1
        }
        let choose = Int(arc4random_uniform(UInt32(max + 1)))
        max = 0
        for i in 0...lesson.dicoFr.count - 1 {
            max += lesson.dicoCall[i] - lesson.dicoSucess[i]
            if choose < max {
                return i
            }
        }
        return -1
    }
    
    func RandomExclu(Exclu: [Int]) -> Int {
    
        var newRandom = -1
        var testNumber = -1
        
        while (newRandom == -1) {
            if mode == "FocusMode" {
                testNumber = RandFocus()
                if testNumber == -1 {
                    testNumber = Int(arc4random_uniform(UInt32(lesson.dicoFr.count)))
                }
            }
            else {
                testNumber = Int(arc4random_uniform(UInt32(lesson.dicoFr.count)))
            }
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
        
        usleep(200000)
        var numberGenerate = [Int]()
        
        buttonWord = Int(arc4random_uniform(4)) + 1
        
        if mode == "ExamMode" {
            if (arrayWord.count == 0) {
                srand(UInt32(lesson.seedRandom))
                let newArray = CreateDuplicateArray()
                arrayWord = ArrayShuffle(newArray)
            }
            numberGenerate.append(arrayWord[lesson.complet])
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate[buttonWord] = numberGenerate[0]
            labelQuestionNumber.text = "Question: " + String(lesson.complet + 1) + " / " + String(arrayWord.count)
        }
        else {
            numberGenerate.append(-1)
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
            numberGenerate.append(RandomExclu(numberGenerate))
        }
        
        indexWord = numberGenerate[buttonWord]
        outletButtonTopLeft.setTitle(lesson.dicoJap[numberGenerate[1]], forState: .Normal)
        outletButtonTopRight.setTitle(lesson.dicoJap[numberGenerate[2]], forState: .Normal)
        outletButtonBottomLeft.setTitle(lesson.dicoJap[numberGenerate[3]], forState: .Normal)
        outletButtonBottomRight.setTitle(lesson.dicoJap[numberGenerate[4]], forState: .Normal)
        outletButtonTopLeft.setTitleColor(UIColor.blueColor(), forState: .Normal)
        outletButtonTopRight.setTitleColor(UIColor.blueColor(), forState: .Normal)
        outletButtonBottomLeft.setTitleColor(UIColor.blueColor(), forState: .Normal)
        outletButtonBottomRight.setTitleColor(UIColor.blueColor(), forState: .Normal)
        labelSearchWord.text = lesson.dicoFr[indexWord]
    
    }
    
    func LevelFinish() {
        let alert = UIAlertController(title: "Felicitation!", message: "Vous avez terminer l'exam avec un score de: " + String(lesson.sucess) + " /" + String(lesson.complet) + ", pour recommencer, faites reset", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "OK!", style: UIAlertActionStyle.Default)
        {
            (UIAlertAction) -> Void in self.navigationController!.popViewControllerAnimated(true)
        }
        alert.addAction(alertAction)
        presentViewController(alert, animated: true)
        {
            () -> Void in
        }
    }
    
    func CheckWord(choice: Int) {
        
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
            if (mode == "ExamMode") {
                lesson.sucess -= 1
                if lesson.sucess < 0 {
                    lesson.sucess = 0
                }
            }
        }
        else {
            if choice == 0 {
                print("Entre")
                outletButtonTopLeft.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            else if choice == 1 {
                print("Entre1")
                outletButtonTopRight.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            else if choice == 2 {
                print("Entre2")
                outletButtonBottomLeft.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            else {
                print("Entre3")
                outletButtonBottomRight.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            if (mode == "ExamMode") {
                lesson.sucess += 1
                lesson.complet += 1
                print(lesson.complet)
                if lesson.complet == (lesson.dicoFr.count * 3) {
                    LevelFinish()
                    return ()
                }
            }
            lesson.dicoSucess[indexWord] += 1
            NewWord()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = lesson.lessonTitle
        if lesson.complet >= (lesson.dicoFr.count * 3) {
            LevelFinish()
        }
        else {
            NewWord()
        }
    }
  
    @IBAction func buttonTopLeft(sender: AnyObject) {
        CheckWord(0)
    }
    
    @IBAction func buttonTopRight(sender: AnyObject) {
        CheckWord(1)
    }
    
    @IBAction func buttonBottomLeft(sender: AnyObject) {
        CheckWord(2)
    }
    
    @IBAction func buttonBottomRight(sender: AnyObject) {
        CheckWord(3)
    }
}
