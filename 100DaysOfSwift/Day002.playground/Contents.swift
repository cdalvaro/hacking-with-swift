/*:
 # Hacking with Swift
 
 [Day 2 - Complex Types](https://www.hackingwithswift.com/100/2)

 ## Arrays

 Arrays are collections of values that are stored as a single value.
 */
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"
/*:
 This last line makes the array:
 it starts and ends with brackets, with each item in the array separated by a comma.
 */
let beatles = [john, paul, george, ringo]
//: You can read values from an array by writing a number inside brackets.
beatles[1]
/*:
 Be careful: Swift crashes if you read an item that doesn’t exist.
 ```swift
 beatles[9]
 ```
 
 If you’re using type annotations, arrays are written in brackets: `[String]`, `[Int]`, ...

 ## Sets

 Sets are collections of values just like arrays, except they have two differences:

 1. *Items aren’t stored in any order*; they are stored in what is effectively a random order.
 1. *No item can appear twice in a set*; all items must be unique.

 You can create sets directly from arrays, like this:
 */
let colors = Set(["red", "green", "blue"])
/*:
 Because they are unordered, you can’t read values from a set using numerical positions like you can with arrays.

 If you try to insert a duplicate item into a set, the duplicates get ignored.
 */
let colors2 = Set(["red", "green", "blue", "red", "blue"])
/*:
 ## Tuples

 Tuples allow you store several values together in a single value.
 That might sound like arrays, but tuples are different:

 1. *You can’t add or remove items from a tuple*; they are fixed in size.
 1. *You can’t change the type of items in a tuple*; they always have the same types they were created with.
 1. *You can access items in a tuple using numerical positions or by naming them*,
    but Swift won’t let you read numbers or names that don’t exist.

 Tuples are created by placing multiple items into parentheses, like this:
 */
var name = (first: "Taylor", last: "Swift")
//: You then access items using numerical positions starting from `0`:
name.0
//: Or you can access items using their names:
name.first
/*:
 Remember, you can change the values inside a tuple after you create it, but not the types of values.

 ## Arrays vs Sets vs Tuples

 If you need a specific, fixed collection of related values where each item has a precise position or name, you should use a `Tuple`:
 */
let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")
/*:
 If you need a collection of values that must be unique or you need to be able to check
 whether a specific item is in there extremely quickly, you should use a `Set`:
 */
let set = Set(["aardvark", "astronaut", "azalea"])
//: If you need a collection of values that can contain duplicates, or the order of your items matters, you should use an `Array`:
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
/*:
 ## Dictionaries

 Dictionaries are collections of values just like arrays,
 but rather than storing things with an integer position you can access them using anything you want (identifiers).

 The most common way of storing dictionary data is using strings.
 */
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
//: These identifiers are called keys, and you can use them to read data back out of the dictionary:
heights["Taylor Swift"]
/*:
 When using type annotations, dictionaries are written in brackets with a colon between your identifier and value types.
 For example, `[String: Double]` and `[String: String]`.

 ## Dictionary Default Values

 If you try to read a value from a dictionary using a key that doesn’t exist, Swift will send you back nil – nothing at all.
 While this might be what you want, there’s an alternative:
 we can provide the dictionary with a default value to use if we request a missing key.
 */
heights["Albert Einstein", default: 1.80]
/*:
 ## Creating empty collections

 Arrays, sets, and dictionaries are called collections, because they collect values together in one place.

 If you want to create an empty collection just write its type followed by opening and closing parentheses.
 For example, we can create an empty dictionary with strings for keys and values like this:
 */
var teams = [String: String]()
//: We can then add entries later on, like this:
teams["Paul"] = "Red"
//: Similarly, you can create an empty array to store integers like this:
var results = [Int]()
//: The exception is creating an empty `Set`, which is done differently:
var words = Set<String>()
var numbers = Set<Int>()
/*:
 This is because Swift has special syntax only for dictionaries and arrays;
 other types must use angle bracket syntax like sets.

 If you wanted, you could create arrays and dictionaries with similar syntax:
 */
var scores = Dictionary<String, Int>()
var results2 = Array<Int>()
/*:
 ## Enumerations

 Enumerations – *usually called just enums* – are a way of defining groups of
 related values in a way that makes them easier to use.

 With enums we can define a Result type that can be either success or failure, like this:
 */
enum Result {
    case success
    case failure
}
//: And now when we use it we must choose one of those two values:
let result1 = Result.failure
//: This stops you from accidentally using different strings each time.
let result2 = "failure"
let result3 = "failed"
let result4 = "fail"
/*:
 ## Enum associated values

 As well as storing a simple value, enums can also store associated values attached to each case.
 This lets you attach additional information to your enums so they can represent more nuanced data.

 For example, we might define an enum that stores various kinds of activities:
 */
enum Activity {
    case bored
    case running
    case talking
    case singing
}
/*:
 That let’s us say that someone is talking, but we don’t know what they talking about,
 or we can know that someone is running, but we don’t know where they are running to.

 Enum associated values let us add those additional details:
 */
enum Activity2 {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}
//: Now we can be more precise – we can say that someone is talking about football:
let talking = Activity2.talking(topic: "football")
/*:
 ## Enum raw values

 Sometimes you need to be able to assign values to enums so they have meaning.
 This lets you create them dynamically, and also use them in different ways.

 For example, you might create a Planet enum that stores integer values for each of its cases:
 */
enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}
/*:
 Swift will automatically assign each of those a number starting from `0`,
 and you can use that number to create an instance of the appropriate `enum case`.
 For example, earth will be given the number `2`, so you can write this:
 */
let earth = Planet(rawValue: 2)
/*:
 If you want, you can assign one or more cases a specific value, and Swift will generate the rest.
 It’s not very natural for us to think of Earth as the second planet, so you could write this:
 */
enum Planet2: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}
/*:
 Now Swift will assign `1` to mercury and count upwards from there, meaning that earth is now the third planet.

 ## Summary

 1. Arrays, sets, tuples, and dictionaries let you store a group of items under a single value.
    They each do this in different ways, so which you use depends on the behavior you want.
 1. Arrays store items in the order you add them, and you access them using numerical positions.
 1. Sets store items without any order, so you can’t access them using numerical positions.
 1. Tuples are fixed in size, and you can attach names to each of their items.
    You can read items using numerical positions or using your names.
 1. Dictionaries store items according to a key, and you can read items using those keys.
 1. Enums are a way of grouping related values so you can use them without spelling mistakes.
 1. You can attach raw values to enums so they can be created from integers or strings,
    or you can add associated values to store additional information about each case.
 */
