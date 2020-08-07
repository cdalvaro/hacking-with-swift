/*:
 # Hacking with Swift
 
 [Day 9 - Structs, Part Two](https://www.hackingwithswift.com/100/9)
 
 ## Initializers
 
 Initializers are special methods that provide different ways to create your struct.
 All structs come with one by default, called their *memberwise initializer* – this asks you to provide a value for each property when you create the struct.
 
 You can see this if we create a `User` struct that has one property:
 */
struct User {
    var username: String
}
//: When we create one of those structs, we must provide a username:
var user = User(username: "twostraws")
/*:
 We can provide our own initializer to replace the default one.
 For example, we might want to create all new users as “Anonymous” and print a message, like this:
 */
struct UserWithCustomInit {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}
/*:
 You *don’t* write `func` before initializers, but you do need to make sure all properties have a value before the initializer ends.
 
 Now our initializer accepts no parameters, we need to create the struct like this:
 */
var userWithCustomInit = UserWithCustomInit()
userWithCustomInit.username = "twostraws"
/*:
 ## Referring to the current instance
 
 Inside methods you get a special constant called `self`, which points to whatever instance of the struct is currently being used.
 This `self` value is particularly useful when you create initializers that have the same parameter names as your property.
 
 For example, if you create a `Person` struct with a `name` property, then tried to write an initializer that accepted a `name` parameter,
 `self` helps you distinguish between the property and the parameter –
 `self.name` refers to the *property*, whereas
 `name` refers to the *parameter*.
 
 Here’s that in code:
 */
struct Person {
    var name: String
    
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}
/*:
 ## Lazy properties
 
 As a performance optimization, Swift lets you create some properties only when they are needed.
 As an example, consider this `FamilyTree` struct – it doesn’t do much, but in theory creating a family tree for someone takes a long time:
 */
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}
//: We might use that `FamilyTree` struct as a property inside a `Person` struct, like this:
struct PersonWithFamilyTree {
    var name: String
    lazy var familyTree = FamilyTree()
    
    init(name: String) {
        self.name = name
    }
}

var ed = PersonWithFamilyTree(name: "Ed")
/*:
 But what if we didn’t always need the family tree for a particular person?
 If we add the `lazy` keyword to the familyTree property, then Swift will only create the `FamilyTree` struct when it’s first accessed.
 
 So, if you want to see the “Creating family tree!” message, you need to access the property at least once:
 */
ed.familyTree
/*:
 ## Static properties and methods
 
 All the properties and methods we’ve created so far have belonged to individual instances of structs,
 which means that if we had a `Student` struct we could create several student instances each with their own properties and methods:
 */
struct StudentWithoutStatic {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let edd = StudentWithoutStatic(name: "Edd")
let taylor = StudentWithoutStatic(name: "Taylor")
/*:
 You can also ask Swift to share specific properties and methods across all instances of the struct by declaring them as `static`.
 
 To try this out, we’re going to add a `static` property to the `Student` struct to store how many students are in the class.
 Each time we create a new student, we’ll add one to it:
 */
struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let mael = Student(name: "Mael")
let leire = Student(name: "Leire")
/*:
 Because the `classSize` struct belongs to the struct itself rather than instances of the struct,
 we need to read it using `Student.classSize`:
 */
print(Student.classSize)
/*:
 ## Access control
 
 Access control lets you restrict which code can use properties and methods.
 This is important because you might want to stop people reading a property directly, for example.
 
 We could create a `PersonWithId` struct that has an `id` property to store their social security number.
 
 Once that person has been created, we can make their `id` be `private` so you can’t read it from outside the struct
 – *trying to write `ed.id` simply won’t work*.
 
 Just use the `private` keyword.
 
 Now only methods inside `PersonWithId` can read the `id` property. For example:
 */
struct PersonWithId {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is \(id)"
    }
}
let jorge = PersonWithId(id: "1234ABC")
jorge.identify()
/*:
 Another common option is `public`, which lets all other code use the property or method.
 
 ## Summary
 
 You’ve made it to the end of the seventh part of this series, so let’s summarize:
 
 1. You can create your own types using structures, which can have their own properties and methods.
 1. You can use stored properties or use computed properties to calculate values on the fly.
 1. If you want to change a property inside a method, you must mark it as `mutating`.
 1. Initializers are special methods that create structs.
    You get a memberwise initializer by default, but if you create your own you must give all properties a value.
 1. Use the `self` constant to refer to the current instance of a struct inside a method.
 1. The `lazy` keyword tells Swift to create properties only when they are first used.
 1. You can share properties and methods across all instances of a struct using the `static` keyword.
 1. Access control lets you restrict what code can use properties and methods.
 */
