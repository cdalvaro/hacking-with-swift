/*:
 # Hacking with Swift
 
 [Day 1 - First Steps in Swift](https://www.hackingwithswift.com/100/1)
 
 ## Variables
 */
var str = "Hello, playground"
//: Because str is a variable we can change it
str = "Goodbye"
/*:
 ## Strings and integers
 
 Swift is what’s known as a type-safe language, which means that every variable must be of one specific type.
 The str variable holds a string of letters that spell “Goodbye”, so Swift assigns it the type `String`.
 
 On the other hand, if we want to store someone’s age we might make a variable like this:
 */
var age = 38
/*:
 That holds a whole number, so Swift assigns the type `Int`

 If you have large numbers, Swift lets you use underscores as thousands separators
 */
var population = 8_000_000
/*:
 ## Multi-line strings
 
 Standard Swift strings use double quotes, but you can’t include line breaks in there.
 If you want multi-line strings you need slightly different syntax
 */
var str1 = """
This goes
over multiple
lines
"""
/*:
 If you only want multi-line strings to format your code neatly,
 and you don’t want those line breaks to actually be in your string, end each line with a `\`, like this:
 */
var str2 = """
This goes \
over multiple \
lines
"""
/*:
 ## Doubles and booleans
 
 `Double` is short for “double-precision floating-point number”,
 and it’s a fancy way of saying it holds fractional values such as 38.1, or 3.141592654.
 Whenever you create a variable with a fractional number,
 Swift automatically gives that variable the type `Double`. For example:
 */
var pi = 3.141
//: As for booleans: `Bool`, they are much simpler: they just hold either true or false
var awesome = true
/*:
 ## String interpolation
 
 You can place any type of variable inside your string – all you have to do
 is write a backslash, `\`, followed by your variable name in parentheses. For example:
 */
var score = 85
str = "Your score was \(score)"
//: You can do this as many times as you need, making strings out of strings if you want:
var results = "The test results are here: \(str)"
/*:
 ## Constants
 
 The `let` keyword creates constants, which are values that can be set once and never again.
 If you try to change that, Xcode will refuse to run your code.
 It’s a form of safety: when you use constants you can no longer change something by accident.
 */
let taylor = "swift"
/*:
 ## Type annotations
 
 Swift is able to infer the type of something based on how you created it.
 If you want you can be explicit about the type of your data rather than relying on Swift’s type inference, like this:
 */
let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylorRocks: Bool = true
