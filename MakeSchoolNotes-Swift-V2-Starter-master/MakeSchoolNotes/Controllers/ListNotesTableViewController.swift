//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {

    var notes = [Note]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue){
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
        
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell
        
        let row = indexPath.row
        let note = notes[row]
        
        cell.noteTitleLabel.text = note.title
        cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()
        
        return cell
        
    }
    
    // Prepare for Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            
            if identifier == "displayNote" {
                print("Table view cell tapped")
                
                //MARK: Determining the selected note
                //1
                let indexPath = tableView.indexPathForSelectedRow!
                //2 Identifying each cell with the indexpath to retrieve the note from notes array.
                let note = notes[indexPath.row]
                //3 Getting access to the display note VC with segue
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                //4 Setting the note property
                displayNoteViewController.note = note
                
            } else if identifier == "addNote" {
                print("+ button tapped")

            }
        }
    }
    
    
}