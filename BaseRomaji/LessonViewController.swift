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
    
    var lesson: Lesson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lesson = lesson {
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
    }

    @IBAction func Cancel(sender: UIBarButtonItem) {
        
       // dismissViewControllerAnimated(true, completion: nil)  avec navigation
        navigationController!.popViewControllerAnimated(true) // lien direct
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if buttonReturn !== sender {
            let spec = segue.destinationViewController as! ExerciceViewController
            spec.lesson = lesson!
            spec.mode = segue.identifier!
        }
    }
    
}
