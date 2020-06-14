/*:
 # Hacking with Swift
 
 [Day 11 - Protocols And Extensions](https://www.hackingwithswift.com/100/11)
 
 ## Protocols
 
 Protocols are a way of describing what properties and methods something must have.
 You then tell Swift which types use that protocol – a process known as adopting or conforming to a protocol.
 
 For example, we can write a function that accepts something with an `id` property,
 but we don’t care precisely what type of data is used. We’ll start by creating an `Identifiable` protocol,
 which will require all conforming types to have an `id` string that can be read (“*get*”) or written (“*set*”):
 */
protocol Identifiable {
    var id: String { get set }
}
/*:
 We can’t create instances of that protocol - it’s a description, not a type by itself.
 But we can create a struct that conforms to it:
 */
struct User: Identifiable {
    var id: String
}
//: Finally, we’ll write a `displayID()` function that accepts any `Identifiable` object:
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}
/*:
 ## Protocol inheritance
 
 One protocol can inherit from another in a process known as protocol inheritance.
 Unlike with classes, you can inherit from multiple protocols at the same time before you add your own customizations on top.
 
 We’re going to define three protocols:
 
 - `Payable` requires conforming types to implement a `calculateWages()` method,
 - `NeedsTraining` requires conforming types to implement a `study()` method, and
 - `HasVacation` requires conforming types to implement a `takeVacation()` method:
 */
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}
/*:
 We can now create a single `Employee` protocol that brings them together in one protocol.
 We don’t need to add anything on top, so we’ll just write open and close braces:
 */
protocol Employee: Payable, NeedsTraining, HasVacation { }
/*:
 Now we can make new types conform to that single protocol rather than each of the three individual ones.
 
 ## Extensions
 
 Extensions allow you to add methods to existing types, to make them do things they weren’t originally designed to do.
 
 For example, we could add an extension to the `Int` type so that it has a `squared()`
 method that returns the current number multiplied by itself:
 */
extension Int {
    func squared() -> Int {
        return self * self
    }
}
//: To try that out, just create an integer and you’ll see it now has a `squared()` method:
let number = 8
number.squared()
/*:
 Swift doesn’t let you add stored properties in extensions, so you must use computed properties instead.
 For example, we could add a new `isEven` computed property to integers that returns *true* if it holds an even number:
 */
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}
/*:
 ## Protocol extensions
 
 Protocols let you describe what methods something should have, but don’t provide the code inside.
 Extensions let you provide the code inside your methods,
 but only affect one data type – you can’t add the method to lots of types at the same time.
 
 Protocol extensions solve both those problems: they are like regular extensions,
 except rather than extending a specific type like `Int` you extend a whole protocol so that all conforming types get your changes.
 
 For example, here is an array and a set containing some names:
 */
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])
/*:
 Swift’s arrays and sets both conform to a protocol called `Collection`,
 so we can write an extension to that protocol to add a `summarize()` method to print the collection neatly
 */
extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        
        for name in self {
            print(name)
        }
    }
}
//: Both `Array` and `Set` will now have that method, so we can try it out:
pythons.summarize()
beatles.summarize()
/*:
 ## Protocol-oriented programming
 
 Protocol extensions can provide default implementations for our own protocol methods.
 This makes it easy for types to conform to a protocol,
 and allows a technique called “*protocol-oriented programming*” – crafting your code around protocols and protocol extensions.
 
 First, here’s a protocol called `Identifiable2` that requires any conforming type to have an `id` property and an `identify()` method:
 */
protocol Identifiable2 {
    var id: String { get set }
    func identify()
}
//: We could make every conforming type write their own `identify()` method, but protocol extensions allow us to provide a default:
extension Identifiable2 {
    func identify() {
        print("My ID is \(id).")
    }
}
//: Now when we create a type that conforms to `Identifiable` it gets `identify()` automatically:
struct User2: Identifiable2 {
    var id: String
}

let twostraws = User2(id: "twostraws")
twostraws.identify()
/*:
 ## Summary
 
 You’ve made it to the end of the ninth part of this series, so let’s summarize:
 
 1. Protocols describe what methods and properties a conforming type must have,
    but don’t provide the implementations of those methods.
 1. You can build protocols on top of other protocols, similar to classes.
 1. Extensions let you add methods and computed properties to specific types such as `Int`.
 1. Protocol extensions let you add methods and computed properties to protocols.
 1. Protocol-oriented programming is the practice of designing your app architecture as a series of protocols,
    then using protocol extensions to provide default method implementations.
 */
