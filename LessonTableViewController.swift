//
//  LessonTableViewController.swift
//  BaseRomaji
//
//  Created by Mathieu MOLE on 3/15/16.
//  Copyright © 2016 Mathieu MOLE. All rights reserved.
//

import UIKit

class LessonTableViewController: UITableViewController {

    var lessons = [Lesson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       if let dataLesson = loadData() {
            lessons += dataLesson
            print("Data load")
        }
        else {
            loadSampleLesson()
            print("Data sample")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    
    func    loadSampleLesson() {
        
        let photo1 = UIImage(named: "image1")!
        let dicofr1 = ["grand", "petit","chaud", "froid"]
        let dicojap1 = ["ookii", "chiisai","atsui", "samui"]
        let lesson1 = Lesson(lessonTitle: "Adjectif1", picture: photo1, complet: 1, sucess: 1, dicoFr: dicofr1, dicoJap: dicojap1)!
        
        let photo2 = UIImage(named: "image2")!
        let dicofr2 = ["gros", "mince","haut, cher", "bas"]
        let dicoJap2 = ["futoi", "usui","takai", "hikui"]
        let lesson2 = Lesson(lessonTitle: "Adjectif2", picture: photo2, complet: 0.9, sucess: 0.7, dicoFr: dicofr2, dicoJap: dicoJap2)!
        
        let photo3 = UIImage(named: "image3")!
        let dicoFr3 = ["nouveau, récent", "vieux", "rapide", "lent"]
        let dicoJap3 = ["atarashii", "furui","hayai", "osoi"]
        let lesson3 = Lesson(lessonTitle: "Adjectif3", picture: photo3, complet: 0.4, sucess: 0.2, dicoFr: dicoFr3, dicoJap: dicoJap3)!
        
        lessons += [lesson1, lesson2, lesson3]
        saveLessons()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "LessonTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! LessonTableViewCell
        let focusLesson = lessons[indexPath.row]
        
        cell.titleLabel.text =  focusLesson.lessonTitle
        cell.completBar.progress = focusLesson.complet
        cell.sucessBar.progress = focusLesson.sucess
        cell.imageSet.image = focusLesson.picture
        
        // Configure the cell...
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowLesson" {
            let lessonDetailViewController = segue.destinationViewController as! LessonViewController
            
            if let selectedLessonCell = sender as? LessonTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedLessonCell)!
                let selectedLesson = lessons[indexPath.row]
                lessonDetailViewController.lesson = selectedLesson
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
