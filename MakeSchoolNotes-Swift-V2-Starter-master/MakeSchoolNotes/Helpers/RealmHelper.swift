//
//  RealmHelper.swift
//  MakeSchoolNotes
//
//  Created by Edrick Pascual on 6/23/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    // Adding notes
    static func addNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(note)
        }
    }
    
    // Delete notes
    static func deleteNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(note)
        }
    }
    
    // Updating notes
    static func updateNote(noteToBeUpdated: Note, newNote: Note) {
        let realm = try! Realm()
        try! realm.write() {
            noteToBeUpdated.title = newNote.title
            noteToBeUpdated.content = newNote.content
            noteToBeUpdated.modificationTime = newNote.modificationTime
        }
    }
    
    // Retreiving notes
    static func retrieveNotes() -> Results<Note> {
        let realm = try! Realm()
        return realm.objects(Note).sorted("modificationTime", ascending: false)
    }
}







//MARK Realm: How to modify objects
// try! realm.write() {
//   realm.add(chris)
//}

// How to update objects in realm
//try! realm.write() {
//    chris.age = 100
//}

// Retrieving objects
//let realm = try! Realm()
//let people = realm.objects(Person)
