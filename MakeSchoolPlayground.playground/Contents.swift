//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//class Person {
//    
//    var name: String!
//    var alive = true
//
//    func sayHello() {
//        
//        print("Hello my name is \(name)")
//        
//    }

    
    class Musician {
        
        var name: String!
        
        func playInstrument() {
            
            
            
        }
        
    }
    
    class Guitarist: Musician {
        
        override func playInstrument() {
            
        }
        
    }
    
    let person = Guitarist()
    person.name = "Dave"
    print(person.name)
    

