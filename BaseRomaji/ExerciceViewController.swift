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
    
    @IBOutlet weak var labelChoice1: UILabel!
    @IBOutlet weak var labelChoice2: UILabel!
    @IBOutlet weak var labelChoice3: UILabel!
    @IBOutlet weak var labelChoice4: UILabel!
    
    @IBOutlet weak var labelQuestionNumber: UILabel!
    
    var mode = "train"
    var lesson: Lesson!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = lesson.lessonTitle
        labelSearchWord.text = lesson.dicoFr[0]
        labelChoice1.text = lesson.dicoFr[0]
        
        labelChoice2.text = lesson.dicoFr[1]
        labelChoice3.text = lesson.dicoFr[2]
        labelChoice4.text = lesson.dicoFr[3]
//        labelSearchWord.text = lesson.dico[0].fr
//        labelChoice1.text = lesson.dico[0].jap
//        
//        labelChoice2.text = lesson.dico[1].jap
//        labelChoice3.text = lesson.dico[2].jap
//        labelChoice4.text = lesson.dico[3].jap
    }
}
