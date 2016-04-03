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
        
        if let dataLesson = loadData() {
            lessons += dataLesson
        }
        else {
            loadDataJson()
        }
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
                        picture: UIImage(named: jsonObj[i]["picture"].stringValue),
                        complet: 0,
                        sucess: 0,
                        dicoFr: jsonObj[i]["dictonaryFr"].arrayValue.map { "\($0)"},
                        dicoJap: jsonObj[i]["dictonaryJap"].arrayValue.map { "\($0)"},
                        dicoCall: [Int](count: jsonObj[i]["dictonaryFr"].count, repeatedValue: 0),
                        dicoSucess: [Int](count: jsonObj[i]["dictonaryFr"].count, repeatedValue: 0),
                        seedRandom: Int(arc4random_uniform(777))
                    )!
                    lessons.append(lesson)
                }
                saveLessons()
            } else {
                print("could not get json from file, make sure that file contains valid json.")
            }
        }
        else {
            print("Invalid filename/path.")
        }
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
