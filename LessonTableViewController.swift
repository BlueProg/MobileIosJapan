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

        loadSampleLesson()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    
    func    loadSampleLesson() {
        
        let photo1 = UIImage(named: "image1")!
        var dico1 = [DictionaryLesson]()
        
        dico1.append(DictionaryLesson(
            fr: "grand",
            jap: "ooki",
            call: 0,
            sucess: 0
        ))
        
        dico1.append(DictionaryLesson(
            fr: "petit",
            jap: "chiisai",
            call: 0,
            sucess: 0
        ))
        
        dico1.append(DictionaryLesson(
            fr: "chaud",
            jap: "atsui",
            call: 0,
            sucess: 0
        ))
        
        dico1.append(DictionaryLesson(
            fr: "froid",
            jap: "samui",
            call: 0,
            sucess: 0
        ))
        
        let lesson1 = Lesson(lessonTitle: "Adjectif1", picture: photo1, complet: 1, sucess: 1, words: dico1)!
        
        let photo2 = UIImage(named: "image2")!
        var dico2 = [DictionaryLesson]()
        
        dico2.append(DictionaryLesson(
            fr: "gros",
            jap: "futoi",
            call: 0,
            sucess: 0
        ))
        
        dico2.append(DictionaryLesson(
            fr: "mince",
            jap: "usui",
            call: 0,
            sucess: 0
        ))
        
        dico2.append(DictionaryLesson(
            fr: "haut, cher",
            jap: "takai",
            call: 0,
            sucess: 0
        ))
        
        dico2.append(DictionaryLesson(
            fr: "bas",
            jap: "hikui",
            call: 0,
            sucess: 0
        ))
        let lesson2 = Lesson(lessonTitle: "Adjectif2", picture: photo2, complet: 0.9, sucess: 0.7, words: dico2)!
        
        let photo3 = UIImage(named: "image3")!
        var dico3 = [DictionaryLesson]()
        
        dico3.append(DictionaryLesson(
            fr: "nouveau, récent",
            jap: "atarashii",
            call: 0,
            sucess: 0
        ))
        
        dico3.append(DictionaryLesson(
            fr: "vieux",
            jap: "furui",
            call: 0,
            sucess: 0
        ))
        
        dico3.append(DictionaryLesson(
            fr: "rapide",
            jap: "hayai",
            call: 0,
            sucess: 0
        ))
        
        dico3.append(DictionaryLesson(
            fr: "lent",
            jap: "osoi",
            call: 0,
            sucess: 0
        ))
        let lesson3 = Lesson(lessonTitle: "Adjectif3", picture: photo3, complet: 0.4, sucess: 0.2, words: dico3)!
        
        lessons += [lesson1, lesson2, lesson3]
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
