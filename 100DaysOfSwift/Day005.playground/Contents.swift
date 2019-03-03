/*:
 # Hacking with Swift
 
 [Day 5 - Functions](https://www.hackingwithswift.com/100/5)
 
 ## Writing functions
 
 Functions let us re-use code, which means we can write a function to do something interesting then run that function from lots of places.
 Repeating code is generally a bad idea, and functions help us avoid doing that.
 
 To start with, we’re going to write a function that prints help information for users of our app.
 We might need this anywhere in our app, so having it as a function is a good idea.
 
 Swift functions start with the `func` keyword, then your function name, then open and close parentheses.
 All the body of your function – the code that should be run when the function is requested – is placed inside braces.
 
 Let’s write the `printHelp()` function now:
 */
func printHelp() {
    let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""
    print(message)
}
//: We can now run that using printHelp() by itself:
printHelp()
/*:
 Running a function is often referred to as calling a function.
 
 ## Accepting parameters
 
 Functions become more powerful when they can be customized each time you run them.
 Swift lets you send values to a function that can then be used inside the function to change the way it behaves.
 We’ve used this already – we’ve been sending strings and integers to the `print()` function, like this:
 */
print("Hello, world!")
/*:
 Values sent into functions this way are called parameters.
 
 To make your own functions accept parameters, give each parameter a name, then a colon, then tell Swift the type of data it must be.
 All this goes inside the parentheses after your function name.
 
 For example, we can write a function to print the square of any number:
 */
func printSquare(number: Int) {
    print(number * number)
}
/*:
 That tells Swift we expect to receive an `Int`, and it should be called `number`.
 This name is used both inside the function when you want to refer to the parameter, but also when you run the function, like this:
 */
printSquare(number: 8)
/*:
 ## Returning values
 
 As well as receiving data, functions can also send back data.
 To do this, write a dash then a right angle bracket after your function’s parameter list,
 then tell Swift what kind of data will be returned.
 
 Inside your function, you use the `return` keyword to send a value back if you have one.
 Your function then immediately exits, sending back that value – no other code from that function will be run.
 
 We could rewrite our `square()` function to return a value rather than print it directly:
 */
func square(number: Int) -> Int {
    return number * number
}
//: Now we can grab that return value when the function is run, and print it there:
let result = square(number: 8)
print(result)
/*:
 If you need to return multiple values, this is a perfect example of when to use tuples.
 
 ## Parameter labels
 
 Swift lets us provide two names for each parameter:
 one to be used externally when calling the function, and one to be used internally inside the function.
 This is as simple as writing two names, separated by a space.
 
 To demonstrate this, here’s a function that uses two names for its string parameter:
 */
func sayHello(to name: String) {
    print("Hello, \(name)!")
}
/*:
 The parameter is called `to name`, which means externally it’s called `to`, but internally it’s called `name`.
 This gives variables a sensible name inside the function, but means calling the function reads naturally:
 */
sayHello(to: "Taylor")
/*:
 ## Omitting parameter labels
 
 You might have noticed that we don’t actually send any parameter names when we call `print()`
 – we say `print("Hello")` rather than `print(message: "Hello")`.
 
 You can get this same behavior in your own functions by using an underscore, `_`, for your external parameter name, like this:
 */
func greet(_ person: String) {
    print("Hello, \(person)!")
}
//: You can now call `greet()` without having to use the `person` parameter name:
greet("Taylor")
/*:
 This can make some code more natural to read, but generally it’s better to give your parameters external names to avoid confusion.
 For example, if I say `setAlarm(5)` it’s hard to tell what that means – does it set an alarm for five o’clock,
 set an alarm for five hours from now, or activate pre-configured alarm number 5?
 */
/*:
 ## Default parameters
 
 The `print()` function prints something to the screen, but always adds a new line to the end of whatever you printed,
 so that multiple calls to `print()` don’t all appear on the same line.
 
 You can change that behavior if you want, so you could use spaces rather than line breaks.
 Most of the time, though, folks want new lines, so `print()` has a terminator parameter that uses new line as its default value.
 
 You can give your own parameters a default value just by writing an `=` after its type followed by the default you want to give it.
 So, we could write a `niceGreet()` function that can optionally print nice greetings:
 */
func niceGreet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}
//: That can be called in two ways:
niceGreet("Taylor")
niceGreet("Taylor", nicely: false)
/*:
 ## Variadic functions
 
 Some functions are variadic, which is a fancy way of saying they accept any number of parameters of the same type.
 The `print()` function is actually variadic: if you pass lots of parameters, they are all printed on one line with spaces between them:
 */
print("Haters", "gonna", "hate")
/*:
 You can make any parameter variadic by writing `...` after its type.
 So, an `Int` parameter is a single integer, whereas `Int...` is zero or more integers – potentially hundreds.
 
 Inside the function, Swift converts the values that were passed in to an array of integers, so you can loop over them as needed.
 
 To try this out, let’s write a `square()` function that can square many numbers:
 */
func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
//: Now we can run that with lots of numbers just by passing them in separated by commas:
square(numbers: 1, 2, 3, 4, 5)
/*:
 ## Writing throwing functions
 
 Sometimes functions fail because they have bad input, or because something went wrong internally.
 Swift lets us *throw* errors from functions by marking them as `throws` before their return type,
 then using the `throw` keyword when something goes wrong.
 
 First we need to define an `enum` that describes the errors we can throw.
 These must always be based on Swift’s existing `Error` type.
 We’re going to write a function that checks whether a password is good, so we’ll throw an error if the user tries an obvious password:
 */
enum PasswordError: Error {
    case obvious
}
/*:
 Now we’ll write a `checkPassword()` function that will *throw* that error if something goes wrong.
 This means using the `throws` keyword before the function’s return value,
 then using `throw PasswordError.obvious` if their password is “password”.
 
 Here’s that in Swift:
 */
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}
/*:
 ## Running throwing functions
 
 Swift doesn’t like errors to happen when your program runs, which means it won’t let you run an error-throwing function by accident.
 
 Instead, you need to call these functions using three new keywords:
 `do` starts a section of code that might cause problems,
 `try` is used before every function that might throw an error, and
 `catch` lets you handle errors gracefully.
 
 If any errors are thrown inside the `do` block, execution immediately jumps to the `catch` block.
 Let’s try calling `checkPassword()` with a parameter that throws an error:
 */
do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
/*:
 When that code runs, “You can’t use that password” is printed,
 but “That password is good” won’t be – that code will never be reached, because the error is thrown.
 
 ## inout parameters
 
 All parameters passed into a Swift function are constants, so you can’t change them.
 If you want, you can pass in one or more parameters as `inout`, which means they can be changed inside your function,
 and those changes reflect in the original value outside the function.
 
 For example, if you want to double a number in place – i.e., change the value directly rather than returning a new one –
 you might write a function like this:
 */
func doubleInPlace(number: inout Int) {
    number *= 2
}
/*:
 To use that, you first need to make a variable integer – you can’t use constant integers with `inout`, because they might be changed.
 You also need to pass the parameter to `doubleInPlace` using an ampersand, `&`, before its name,
 which is an explicit recognition that you’re aware it is being used as `inout`.

In code, you’d write this:
 */
var myNum = 10
doubleInPlace(number: &myNum)
/*:
 ## Summary
 
 You’ve made it to the end of the fifth part of this series, so let’s summarize:
 
 1. Functions let us re-use code without repeating ourselves.
 1. Functions can accept parameters – just tell Swift the type of each parameter.
 1. Functions can `return` values, and again you just specify what type will be sent back.
    Use tuples if you want to return several things.
 1. You can use different names for parameters externally and internally, or omit the external name entirely.
 1. Parameters can have *default* values, which helps you write less code when specific values are common.
 1. Variadic functions accept zero or more of a specific parameter, and Swift converts the input to an array.
 1. Functions can `throw` errors, but you must call them using `try` and handle errors using `catch`.
 1. You can use `inout` to change variables inside a function, but it’s usually better to return a new value.
 */
