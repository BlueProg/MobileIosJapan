//
//  LessonViewController.swift
//  BaseRomaji
//
//  Created by Mathieu MOLE on 3/18/16.
//  Copyright © 2016 Mathieu MOLE. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonReturn: UIBarButtonItem!
    
    var lesson: Lesson!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = lesson.lessonTitle
        
        print(lesson.dicoFr[0])
        print(String(lesson.dicoCall[0]) + " " + String(lesson.dicoSucess[0]))
        print(lesson.dicoFr[1])
        print(String(lesson.dicoCall[1]) + " " + String(lesson.dicoSucess[1]))
        print(lesson.dicoFr[2])
        print(String(lesson.dicoCall[2]) + " " + String(lesson.dicoSucess[2]))
        print(lesson.dicoFr[3])
        print(String(lesson.dicoCall[3]) + " " + String(lesson.dicoSucess[3]))
    }

    @IBAction func Cancel(sender: UIBarButtonItem) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func ResetExam(sender: UIButton) {
        lesson.complet = 0
        lesson.sucess = 0
        lesson.seedRandom = Int(arc4random_uniform(777))
    }
    
    @IBAction func ResetFocus(sender: UIButton) {
        
        for i in 0...lesson.dicoFr.count - 1 {
            lesson.dicoCall[i] = 0
            lesson.dicoSucess[i] = 0
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if buttonReturn !== sender {
            let spec = segue.destinationViewController as! ExerciceViewController
            spec.lesson = lesson
            spec.mode = segue.identifier!
        }
    }
    
}
