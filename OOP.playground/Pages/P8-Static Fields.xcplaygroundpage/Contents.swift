/*:
 ![Make School Banner](./swift_banner.png)
 # Type Properties
 
 Sometimes the zookeepers are getting confused about how many animals they're feeding and how many total animals are at the zoo. Just yesterday, Zeb the zookeeper said to ZoeBot, "Was I supposed to feed 3 bears and 5 bees, or 3 of the 5 bears?" Let's help them remember.
 
 To do this, we would like to add in a `population` counter in our `Animal` class, which keeps track of how many times an `Animal` has been instantiated. But this seems impossible, given what we know – all instance variables are unique to the _instance_ of the class, which means that such a variable wouldn't be able to count _across_ instances of a class...
 
 Enter _type_ properties!
 
 */
class AnotherExampleClass {
    static var counter = 8999
    var message: String
    
    init(message: String) {
        self.message = message
    }
    
    func increaseAndCheckTheCounter() {
        AnotherExampleClass.counter += 1
        print("\(self.message) \(AnotherExampleClass.counter)!")
    }
}
/*:
 
 In this example, we have an instance variable `message`, and a _static_ property `counter`, initialized to `8999`. After each call of `increaseAndCheckTheCounter()`, the type variable is incremented, and is printed, along with the `message` instance variable. Note that difference in the syntax as well: `message` is accessed from within the class as `self.message`, while `counter` is accessed as `AnotherExampleClass.counter`, signifying that the variable `counter` is _shared_ across the entire type `AnotherExampleClass`.
 
 The code below prints the following result. Can you explain why?
 
     What does your counter say? 9000!
     That can't be! It says it's... 9001!
 
 */
let instanceOne = AnotherExampleClass(message: "What does your counter say?")
let instanceTwo = AnotherExampleClass(message: "That can't be! It says... it's...")
instanceOne.increaseAndCheckTheCounter()
instanceTwo.increaseAndCheckTheCounter()
/*:
 
 # Type methods
 
 Methods can be marked as `static`, too. For example, if we subclassed `AnotherExampleClass` to create `CrushingExampleClass` and decided to add a method `crushTheCounter` to `CrushingExampleClass`, you would call it as: `CrushingExampleClass.crushTheCounter()`. You won't be able to access any instance variables from within a type method, though – this is because a type method is not tied to any given instance of the class.
 
 - callout(Try it out!): Add a call to `instanceThree.increaseAndCheckTheCounter()` and `CrushingExampleClass.crushTheCounter()` below to see it in action!

 
 */
class CrushingExampleClass: AnotherExampleClass {
    static func crushTheCounter() {
        CrushingExampleClass.counter = 0
        print("Don't worry... *crush* the counter reads \(CrushingExampleClass.counter) now!")
    }
}
let instanceThree = CrushingExampleClass(message: "WHAT! NO! It's now...")




/*:
 
 - note: You can actually use the keyword `class` in place of `static` _when writing type methods_. The difference is minute – a method marked with `class` allows one to _override_ the method implementation in a subclass, while a method marked with `static` does not allow this. 
 
 You can read more about this at Apple's Swift documentation [here](http://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html).
 
 # Back to the animals
 
 Now that you know how to use type properties, let's use them to count our `Animal` population. Add a type property `population` to the `Animal` class that counts how many instances of Animal have been created. Keeping track of this will require incrementing the count in the initializer method each time a new `Animal` object is initialized. To make the count accessible, add a type method `populationCount` that simply returns the value of population.
 
 - callout(Challenge): Implement the new features on the Animal superclass below! Show the total Animal population a line to the top of the `Zookeeper.feedAnimals` method to print `"<name> is feeding <food> to <number of animals feeding> of <population> total animals"`.
 
 */

// Copy your Animal class here and modify it to automatically count population
// Hint: Modify the initializer method to count the number of animals created
class Animal {
    // here, make yourself a new type variable!
    var name: String
    var favoriteFood: String
    static var population = 0
    
    init(name: String, favoriteFood: String) {
        self.name = name
        self.favoriteFood = favoriteFood
    }
    
    func sleep(name: String) {
        print("\(name) sleeps for 8 hours")
    }
    
    func eat(food: String) {
        print("\(name) eats \(food)")
        if food == favoriteFood {
            print("YUM!! \(name) wants more \(food)")
        } else {
            sleep(name)
        }
    }
    
    func populationCount(){
        Animal.population += 1
    }
}


class Tiger: Animal {
    
    init(name: String) {
        super.init(name: name, favoriteFood: "meat")
    }
}

class Bear: Animal {
    
    init(name: String){
        super.init(name: name, favoriteFood: "fish")
    }
    
    // overriding lets this class to do run its owns methods
    override func sleep(name: String) {
        print("\(name) hibernates for 4 months")
    }
}

class Unicorn: Animal {
    
    init(name: String) {
        super.init(name: name, favoriteFood: "marsh")
    }
    
    override func sleep(name: String) {
        print("\(name) sleeps in a cloud")
    }
    
    override func eat(food:String) {
        super.eat(food)
    }
}

class Giraffe: Animal {
    
    init(name: String) {
        super.init(name: name, favoriteFood: "leaves")
    }
    
    override func eat(food: String) {
        // check here if you don't like the food you were given...
        if food != favoriteFood {
            print("YUCK! \(name) will not eat \(food)")
        } else {
            super.eat(food)
        }
    }
}

class Bee: Animal {
    
    init(name: String) {
        super.init(name: name, favoriteFood: "pollen")
    }
    
    override func sleep(name: String) {
        print("\(name) never sleeps")
    }
    
    override func eat(food:String) {
        print("YUCK!! \(name) will not eat \(food)")
    }
    
}

class Zookeeper {
    // put instance variables here
    var name: String
    var population = animals.count
    
    init(name: String) {
        self.name = name
    }
    
    func feedAnimals(animals: [Animal], food: String) {
        // complete your feedAnimals function here.
        print("\(name) is feeding \(food) to \(animals.count) of \(population) total animals")
        for animal in animals {
            animal.eat(food)
        }
    }
}

/*:
 ## Testing
 
 The following code is similar to the last one, except we add some more animals to our population, that aren't part of the array of animals getting fed. You should get the following output:
 
     Zoe is feeding meat to 5 of 10 total animals
     Tigger eats meat
     YUM!!! Tigger wants more meat
     Pooh eats meat
     Pooh hibernates for 4 months
     Rarity eats meat
     Rarity sleeps in a cloud
     YUCK!!! Gemma will not eat meat
     YUCK!!! Stinger will not eat meat
 
 */

let animals: [Animal] = [
    Tiger(name: "Tigger"),
    Bear(name: "Pooh"),
    Unicorn(name: "Rarity"),
    Giraffe(name: "Gemma"),
    Bee(name: "Stinger")
]
let unfedTiger = Tiger(name: "full Tiger")
let unfedBear = Bear(name: "full Bear")
let unfedUnicorn = Unicorn(name: "full Unicorn")
let unfedGiraffe = Giraffe(name: "full Giraffe")
let unfedBee = Bee(name: "full bee")

let zookeeper = Zookeeper(name: "Zoe")
zookeeper.feedAnimals(animals, food: "meat")

/*:
 ## Conclusion
 
 Congratulations! In this tutorial you learned about the basic principles of Object-Oriented Programming – namely:
 
 - how to leverage the abstraction of classes in order to organize data
 - how to use class inheritance in order to make use of overlapping or similar behaviors
 - the difference between type and instance variables and methods
 
 Object-Oriented Programming is the basis of many complex programs. You'll be using these abstractions as core principles as you delve into many of your programming projects.
 
 */
//: [Previous](@previous)
