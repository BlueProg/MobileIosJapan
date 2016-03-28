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
