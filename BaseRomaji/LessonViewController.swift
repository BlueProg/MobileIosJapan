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
    
    var lesson: Lesson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lesson = lesson {
            labelTitle.text = lesson.name
        }
    }

    @IBAction func Cancel(sender: UIBarButtonItem) {
        
       // dismissViewControllerAnimated(true, completion: nil)  avec navigation
        navigationController!.popViewControllerAnimated(true) // lien direct
    }
}
