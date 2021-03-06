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
    var complet: Int
    var sucess: Int

    var dicoFr: [String]
    var dicoJap: [String]
    var dicoCall: [Int]
    var dicoSucess: [Int]
    var seedRandom: Int
    
    init?(lessonTitle: String, picture: UIImage?, complet: Int, sucess: Int, dicoFr: [String], dicoJap: [String], dicoCall: [Int], dicoSucess: [Int], seedRandom: Int) {
    
        self.lessonTitle = lessonTitle
        self.picture = picture
        self.complet = complet
        self.sucess = sucess
        self.dicoFr = dicoFr
        self.dicoJap = dicoJap
        self.dicoCall = dicoCall
        self.dicoSucess = dicoSucess
        self.seedRandom = seedRandom
     
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
        aCoder.encodeObject(dicoCall, forKey: "dicoCall")
        aCoder.encodeObject(dicoSucess, forKey: "dicoSucess")
        aCoder.encodeObject(Int(seedRandom), forKey: "seedRandom")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let lessonTitle = aDecoder.decodeObjectForKey("lessonTitle") as! String
        let picture = aDecoder.decodeObjectForKey("picture") as! UIImage
        let complet = aDecoder.decodeObjectForKey("complet") as! Int
        let sucess = aDecoder.decodeObjectForKey("sucess") as! Int
        let dicoFr = aDecoder.decodeObjectForKey("dicoFr") as! [String]
        let dicoJap = aDecoder.decodeObjectForKey("dicoJap") as! [String]
        let dicoCall = aDecoder.decodeObjectForKey("dicoCall") as! [Int]
        let dicoSucess = aDecoder.decodeObjectForKey("dicoSucess") as! [Int]
        let seedRandom = aDecoder.decodeObjectForKey("seedRandom") as! Int
        
        self.init(lessonTitle: lessonTitle, picture: picture, complet: complet, sucess: sucess, dicoFr: dicoFr, dicoJap: dicoJap, dicoCall: dicoCall, dicoSucess: dicoSucess, seedRandom: seedRandom)
    }
}
