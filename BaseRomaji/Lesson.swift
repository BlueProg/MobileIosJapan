//
//  Lesson.swift
//  BaseRomaji
//
//  Created by Mathieu MOLE on 3/15/16.
//  Copyright © 2016 Mathieu MOLE. All rights reserved.
//

import UIKit

class Lesson: NSObject, NSCoding {

    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("lessons")
    
    var lessonTitle: String
    var picture: UIImage?
    var complet: Float
    var sucess: Float

    var dicoFr: [String]
    var dicoJap: [String]
    
    
    init?(lessonTitle: String, picture: UIImage?, complet: Float, sucess: Float, dicoFr: [String], dicoJap: [String]) {
    
        self.lessonTitle = lessonTitle
        self.picture = picture
        self.complet = complet
        self.sucess = sucess
        self.dicoFr = dicoFr
        self.dicoJap = dicoJap
     
        if lessonTitle.isEmpty || complet < 0 {
            return nil
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(lessonTitle, forKey: "lessonTitle")
        aCoder.encodeObject(picture, forKey: "picture")
        aCoder.encodeObject(complet, forKey: "complet")
        aCoder.encodeObject(sucess, forKey: "sucess")
        aCoder.encodeObject(dicoFr, forKey: "dicoFr")
        aCoder.encodeObject(dicoJap, forKey: "dicoJap")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let lessonTitle = aDecoder.decodeObjectForKey("lessonTitle") as! String
        let picture = aDecoder.decodeObjectForKey("picture") as! UIImage
        let complet = aDecoder.decodeObjectForKey("complet") as! Float
        let sucess = aDecoder.decodeObjectForKey("sucess") as! Float
        let dicoFr = aDecoder.decodeObjectForKey("dicoFr") as! [String]
        let dicoJap = aDecoder.decodeObjectForKey("dicoJap") as! [String]
        
        self.init(lessonTitle: lessonTitle, picture: picture, complet: complet, sucess: sucess, dicoFr: dicoFr, dicoJap: dicoJap)
    }
}
