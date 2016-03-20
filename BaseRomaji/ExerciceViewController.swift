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
    var lesson: Lesson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = lesson!.name
        labelSearchWord.text = mode
    }
}
