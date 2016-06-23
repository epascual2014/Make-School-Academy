//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {

    var note: Note?
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    
    @IBOutlet weak var noteContentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        
        if segue.identifier == "Save" {
            // Instance of Note class
            if let note = note {
                //1
                note.title = noteTitleTextField.text ?? ""
                note.content = noteContentTextView.text ?? ""
                
                listNotesTableViewController.tableView.reloadData()
                
            } else {
                
                let newNote = Note()
                // 2
                newNote.title = noteTitleTextField.text ?? ""
                newNote.content = noteContentTextView.text ?? ""
                // 3
                newNote.modificationTime = NSDate()
            
                // append New Notes
                listNotesTableViewController.notes.append(newNote)
                
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = note {
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
            
        } else {
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }
}
