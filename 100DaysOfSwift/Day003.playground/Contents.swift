/*:
 # Hacking with Swift
 
 [Day 3 - Operators and Conditions](https://www.hackingwithswift.com/100/3)
 
 ## Arithmetic Operators
 
 Operators are those little mathematical symbols like + and -, and Swift has a huge range of them.
 */
let firstScore = 12
let secondScore = 4
//: We can add and subtract using `+` and `-`
let total = firstScore + secondScore
let difference = firstScore - secondScore
//: And we can multiply and divide using `*` and `/`
let product = firstScore * secondScore
let divided = firstScore / secondScore
//: Swift has a special operator for calculating remainders after division: `%`
let remainder = 13 % secondScore
/*:
 ## Operator Overloading

 Swift supports operator overloading, which is a fancy way of saying that what an operator does
 depends on the values you use it with.
 
 Swift is a type-safe language, which means it won’t let you mix types.
 
 For example, `+` sums integers like this:
 */
let meaningOfLife = 42
let doubleMeaning = 42 + 42
//: But `+` also joins strings, like this:
let fakers = "Fakers gonna "
let action = fakers + "fake"
//: You can even use `+` to join arrays, like this:
let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf
/*:
 ## Compound assignment operators

 Swift has shorthand operators that combine one operator with an assignment, so you can change a variable in place.
 These look like the existing operators you know `+`, `-`, `*`, and `/`,
 but they have an `=` on the end because they assign the result back to whatever variable you were using.
 */
var score = 95
score -= 5

var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"
/*:
 ## Comparison operators
 
 Swift has several operators that perform comparison, and these work more or less like you would expect in mathematics.

 There are two operators that check for equality: `==` checks two values are the same,
 and `!=` (pronounced _“not equals”_) checks two values are not the same:
 */
firstScore == secondScore
firstScore != secondScore
/*:
 There are four operators for comparing whether one value is greater than, less than, or equal to another.
 These are just like in mathematics:
 */
firstScore < secondScore
firstScore >= secondScore
//: Each of these also work with strings, because strings have a natural alphabetical order:
"Taylor" <= "Swift"
/*:
 ## Conditions

 You give Swift a condition, and if that condition is true it will run code of your choosing.

 To try this out, I want to use a Swift function called `print()`:
 you run it with some text, and it will be printed out.
 
 We can use conditions to check for a winning Blackjack hand:
 */
let firstCard = 11
let secondCard = 10
if firstCard + secondCard == 21 {
    print("Blackjack!")
}
/*:
 The code inside the braces – { _and_ } – will be printed if the condition is `true`.
 If you want you can provide alternative code to run if the condition is `false`, using `else`:
 */
if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}
//: You can also chain conditions together using `else if`:
if firstCard + secondCard == 2 {
    print("Aces – lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}
/*:
 ## Combining conditions

 Swift has two special operators that let us combine conditions together: they are `&&` (pronounced _“and”_)
 and `||` (pronounced _“or”_). For example, we could check that the age of two people are both over a certain value like this:
 */
let age1 = 12
let age2 = 21
if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}
/*:
 That `print()` call will only happen if both ages are over `18`, which they aren’t.
 In fact, Swift won’t even bother checking the value of `age2` because it can see that `age1` already failed the test.

 The alternative to `&&` is `||`, which evaluates as `true` if either item passes the test.
 You can use `&&` and `||` more than once in a single condition.
 
 For example we could print a message if either age is over `18`:
 */
if age1 > 18 || age2 > 18 {
    print("One of them is over 18")
}
/*:
 ## The ternary operator

 Swift has a rarely used operator called the ternary operator.
 It works with three values at once, which is where its name comes from:
 it checks a condition specified in the first value, and if it’s true returns the second value, but if its false returns the third value.

 The ternary operator is a condition plus true or false blocks all in one,
 split up by a question mark and a colon, all of which which makes it rather hard to read.
 
 Here’s an example:
 */
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")
/*:
 That checks whether the two cards are the same,
 then prints “Cards are the same” if the condition is true,
 or “Cards are different” if it’s false.
 
 We could write the same code using a regular condition:
 */
if firstCard == secondCard {
    print("Cards are the same")
} else {
    print("Cards are different")
}
/*:
 ## Switch statements

 If you have several conditions using `if` and `else if`, it’s often clearer to use a different construct known as `switch` case.

 Using this approach you write your condition once, then list all possible outcomes and what should happen for each of them.

 To try this out, here’s a weather constant containing the string sunny:
 */
let weather = "sunny"
//: We can use a switch block to print one of four different messages:
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}
/*:
 The last case – `default` – is required because Swift makes sure you cover all possible cases so that no eventuality is missed off.
 If the weather is anything other than rain, snow, or sun, the default case will be run.

 Swift will only run the code inside each case.
 If you want execution to continue on to the next case, use the `fallthrough` keyword like this:
 */
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}
/*:
 ## Range operators

 Swift gives us two ways of making ranges: the `..<` and `...` operators.
 The half-open range operator, `..<`, creates ranges up to but excluding the final value,
 and the closed range operator, `...`, creates ranges up to and including the final value.
 
 For example, the range `1..<5` contains the numbers _1, 2, 3, and 4_, whereas the range `1...5` contains the numbers _1, 2, 3, 4, and 5_.
 
 Ranges are helpful with `switch` blocks, because you can use them for each of your cases.

 For example, if someone sat an exam we could print different messages depending on their score:
 */
let examScore = 85

switch examScore {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}
/*:
 ## Summary
 
 You’ve made it to the end of the third part of this series, so let’s summarize:
 
 1. Swift has operators for doing arithmetic and for comparison; they mostly work like you already know.
 1. There are compound variants of arithmetic operators that modify their variables in place: +=, -=, and so on.
 1. You can use `if`, `else`, and `else if` to run code based on the result of a condition.
 1. Swift has a ternary operator that combines a check with true and false code blocks. Although you might see it in other code, I wouldn’t recommend using it yourself.
 1. If you have multiple conditions using the same value, it’s often clearer to use `switch` instead.
 1. You can make ranges using `..<` and `...` depending on whether the last number should be excluded or included.
 */
