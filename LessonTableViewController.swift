//
//  LessonTableViewController.swift
//  BaseRomaji
//
//  Created by Mathieu MOLE on 3/15/16.
//  Copyright © 2016 Mathieu MOLE. All rights reserved.
//

import UIKit
import SwiftyJSON

class LessonTableViewController: UITableViewController {

    var lessons = [Lesson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let dataLesson = loadData() {
//            lessons += dataLesson
//            print("Data load")
//        }
//        else {
//            loadSampleLesson()
//            print("Data sample")
//        }
        loadDataJson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func    loadData() -> [Lesson]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Lesson.ArchiveURL.path!) as? [Lesson]
    }
    
    func    saveLessons() {
        let isSucessfulSave = NSKeyedArchiver.archiveRootObject(lessons, toFile: Lesson.ArchiveURL.path!)
        if !isSucessfulSave {
            print("Failed to save lessons ...")
        }
    }
    
    func    loadDataJson() {
        
        if let file = NSBundle(forClass:LessonTableViewController.self).pathForResource("Data", ofType: "json") {
            let data = NSData(contentsOfFile: file)
            let jsonObj = JSON(data: data!)
            if jsonObj != JSON.null {
                for i in 0 ... jsonObj.count - 1 {
                    let lesson = Lesson(
                        lessonTitle:  jsonObj[i]["lessonTitle"].stringValue,
                        picture: UIImage(named: "image1"),
                        complet: 0,
                        sucess: 0,
                        dicoFr: jsonObj[i]["dictonaryFr"].arrayValue.map { "\($0)"},
                        dicoJap: jsonObj[i]["dictonaryJap"].arrayValue.map { "\($0)"},
                        dicoCall: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                        dicoSucess: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                        seedRandom: 0
                    )!
                    lessons.append(lesson)
                }
                
            } else {
                print("could not get json from file, make sure that file contains valid json.")
            }
        }
        else {
            print("Invalid filename/path.")
        }
    }
    
    func    loadSampleLesson() {
        
        let photo1 = UIImage(named: "image1")!
        let dicofr1 = ["grand", "petit","chaud", "froid", "loin"]
        let dicojap1 = ["ookii", "chiisai","atsui", "samui", "tooi"]
        let lesson1 = Lesson(lessonTitle: "Adjectif1", picture: photo1, complet: 0, sucess: 0, dicoFr: dicofr1, dicoJap: dicojap1, dicoCall: [0, 0, 0, 0, 0], dicoSucess: [0, 0, 0, 0, 0], seedRandom: 0)!
        
        let photo2 = UIImage(named: "image2")!
        let dicofr2 = ["gros", "mince","haut, cher", "bas", "proche"]
        let dicoJap2 = ["futoi", "usui","takai", "hikui", "chikai"]
        let lesson2 = Lesson(lessonTitle: "Adjectif2", picture: photo2, complet: 0, sucess: 0, dicoFr: dicofr2, dicoJap: dicoJap2, dicoCall: [0, 0, 0, 0, 0], dicoSucess: [0, 0, 0, 0, 0], seedRandom: 1)!
        
        let photo3 = UIImage(named: "image3")!
        let dicoFr3 = ["nouveau, récent", "vieux", "rapide", "lent", "sucré"]
        let dicoJap3 = ["atarashii", "furui","hayai", "osoi", "amai"]
        let lesson3 = Lesson(lessonTitle: "Adjectif3", picture: photo3, complet: 0, sucess: 0, dicoFr: dicoFr3, dicoJap: dicoJap3, dicoCall: [0, 0, 0, 0, 0], dicoSucess: [0, 0, 0, 0, 0], seedRandom: 42)!
        
        lessons += [lesson1, lesson2, lesson3]
        saveLessons()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "LessonTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! LessonTableViewCell
        let focusLesson = lessons[indexPath.row]
        
        cell.titleLabel.text =  focusLesson.lessonTitle
        cell.completBar.progress = Float(focusLesson.complet) / Float(focusLesson.dicoFr.count * 3)
        cell.sucessBar.progress = Float(focusLesson.sucess) / Float(focusLesson.dicoFr.count * 3)
        cell.imageSet.image = focusLesson.picture
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowLesson" {
            let lessonDetailViewController = segue.destinationViewController as! LessonViewController
            
            if let selectedLessonCell = sender as? LessonTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedLessonCell)!
                let selectedLesson = lessons[indexPath.row]
                lessonDetailViewController.lesson = selectedLesson
            }
        }
    }
    
    @IBAction func unwindToLessonList(sender: UIStoryboardSegue) {

        if let sourceViewController = sender.sourceViewController as? LessonViewController, lesson = sourceViewController.lesson {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                lessons[selectedIndexPath.row] = lesson
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            saveLessons()
        }
    }
    
}
