//
//  Lesson.swift
//  BaseRomaji
//
//  Created by Mathieu MOLE on 3/15/16.
//  Copyright © 2016 Mathieu MOLE. All rights reserved.
//

import UIKit

struct DictionaryLesson {
    var fr = String()
    var jap = String()
    var call:Int
    var sucess:Int
}

class Lesson: NSObject, NSCoding {

    var lessonTitle: String
    var picture: UIImage?
    var complet: Float
    var sucess: Float
    var dico: [DictionaryLesson]
    //var dico: NSMutableArray = NSMutableArray()
    
    init?(lessonTitle: String, picture: UIImage?, complet: Float, sucess: Float, words: [DictionaryLesson]) {
    
        self.lessonTitle = lessonTitle
        self.picture = picture
        self.complet = complet
        self.sucess = sucess
        self.dico = words
     
        if lessonTitle.isEmpty || complet < 0 {
            return nil
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(lessonTitle, forKey: "lessonTitle")
        aCoder.encodeObject(picture, forKey: "picture")
        aCoder.encodeObject(complet, forKey: "complet")
        aCoder.encodeObject(sucess, forKey: "sucess")
//        aCoder.encodeObject(dico, forKey: "lessonTitle")
    }
    
//    required convenience init?(coder aDecoder: NSCoder) {
//        let lessonTitle = aDecoder.decodeObjectForKey("lessonTitle") as! String
//        
//        self.init(lessonTitle: lessonTitle)
//    }
}
