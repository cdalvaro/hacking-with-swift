/*:
 # Hacking with Swift
 
 [Day 10 - Classes](https://www.hackingwithswift.com/100/10)
 
 ## Creating your own classes
 
 Classes are similar to structs in that they allow you to create new types with properties and methods,
 but they have five important differences and I’m going to walk you through each of those differences one at a time.
 
 The first difference between classes and structs is that classes never come with a memberwise initializer.
 This means if you have properties in your class, you must always create your own initializer.
 
 For example:
 */
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
//: Creating instances of that class looks just the same as if it were a struct:
let poppy = Dog(name: "Poppy", breed: "Poodle")
/*:
 ## Class inheritance
 
 The second difference between classes and structs is that you can create a class based on an existing class
 – it inherits all the properties and methods of the original class, and can add its own on top.
 
 This is called class inheritance or subclassing, the class you inherit from is called the “parent” or “super” class,
 and the new class is called the “child” class.
 
 We could create a new class based on the `Dog` one called `Poodle`.
 It will inherit the same properties and initializer as `Dog`.
 
 We can also give `Poodle` its own initializer.
 We know it will always have the breed “Poodle”, so we can make a new initializer that only needs a `name` property.
 Even better, we can make the `Poodle` initializer call the `Dog` initializer directly so that all the same setup happens:
 */
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}
/*:
 For safety reasons, Swift always makes you call `super.init()` from child classes
 – just in case the parent class does some important work when it’s created.
 
 ## Overriding methods
 
 Child classes can replace parent methods with their own implementations – a process known as *overriding*.
 Here’s a trivial `Cat` class with a `makeNoise()` method:
 */
class Cat {
    func makeNoise() {
        print("MEOOOOW!")
    }
}
/*:
 If we create a new `LittleCat` class that inherits from `Cat`, it will inherit the `makeNoise()` method.
 So, this will print “meow”.
 
 Method overriding allows us to change the implementation of `makeNoise()` for the `LittleCat` class.
 
 Swift requires us to use `override func` rather than just `func` when *overriding* a method
 – it stops you from overriding a method by accident, and you’ll get an error if you try to override something
 that doesn’t exist on the parent class:
 */
class LittleCat: Cat {
    override func makeNoise() {
        print("meow")
    }
}
//: With that change, `littleCat.makeNoise()` will print “meow” rather than “MEOW!”.
let littleCat = LittleCat()
littleCat.makeNoise()

class Exercise {
    func describe() {
    }
}
class ChinUps: Exercise {
    override func describe() {
    }
}
let firstRep = ChinUps()
firstRep.describe()
/*:
 ## Final classes
 
 Although class inheritance is very useful – and in fact large parts of Apple’s platforms require you to use it –
 sometimes you want to disallow other developers from building their own class based on yours.
 
 Swift gives us a `final` keyword just for this purpose: when you declare a class as being *final*, no other class can inherit from it.
 This means they *can’t override* your methods in order to change your behavior – they need to use your class the way it was written.
 
 To make a class final just put the `final` keyword before it, like this:
 */
final class Horse {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
/*:
 ## Copying objects
 
 The third difference between classes and structs is how they are copied.
 When you copy a `struct`, both the original and the copy are different things – changing one won’t change the other.
 When you copy a `class`, both the original and the copy point to the same thing, so changing one does change the other.
 
 For example, here’s a simple `Singer` class that has a name property with a default value:
 */
class Singer {
    var name = "Taylor Swift"
}
//: If we create an instance of that class and prints its name, we’ll get “Taylor Swift”:
var singer = Singer()
print(singer.name)
//: Now let’s create a second variable from the first one and change its name:
var singerCopy = singer
singerCopy.name = "Justin Bieber"
/*:
 Because of the way classes work, both `singer` and `singerCopy` point to the same object in memory,
 so when we print the singer name again we’ll see “Justin Bieber”:
 */
print(singer.name)
/*:
 On the other hand, if `Singer` were a struct then we would get “Taylor Swift” printed a second time.
 
 ## Deinitializers
 
 The fourth difference between classes and structs is that classes can have deinitializers
 – code that gets run when an instance of a class is destroyed.
 
 To demonstrate this, here’s a `Person` class with a `name` property,
 a simple initializer, a `printGreeting()` method that prints a message and a deinitializer:
 */
class Person {
    var name = "John Doe"
    
    init() {
        print("\(name) is alive!")
    }
    
    deinit {
        print("\(name) is no more!")
    }
    
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
}
/*:
 We’re going to create a few instances of the `Person` class inside a loop,
 because each time the loop goes around a new person will be created then destroyed:
 */
for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}
/*:
 ## Mutability
 
 The final difference between classes and structs is the way they deal with constants.
 If you have a constant struct with a variable property, that property can’t be changed because the struct itself is constant.
 
 However, if you have a constant *class* with a variable property, that property can be changed.
 Because of this, classes don’t need the `mutating` keyword with methods that change properties; that’s only needed with structs.
 
 This difference means you can change any variable property on a *class* even when the class is created as a constant
 – this is perfectly valid code:
 */
let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)
/*:
 If you want to stop that from happening you need to make the `name` property constant.

 ## Summary
 
 You’ve made it to the end of the eighth part of this series, so let’s summarize:
 
 1. Classes and structs are similar, in that they can both let you create your own types with properties and methods.
 1. One class can inherit from another, and it gains all the properties and methods of the parent class.
    It’s common to talk about class hierarchies – one class based on another, which itself is based on another.
 1. You can mark a class with the `final` keyword, which stops other classes from inheriting from it.
 1. Method overriding lets a child class replace a method in its parent class with a new implementation.
 1. When two variables point at the same class instance, they both point at the same piece of memory – changing one changes the other.
 1. Classes can have a deinitializer, which is code that gets run when an instance of the class is destroyed.
 1. Classes don’t enforce constants as strongly as structs
    – if a property is declared as a variable, it can be changed regardless of how the class instance was created.
 */
