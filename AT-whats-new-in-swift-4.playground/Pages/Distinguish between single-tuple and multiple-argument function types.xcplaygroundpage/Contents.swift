//: [Previous](@previous)

import Foundation

let fn1 : ((Int, Int)) -> Void = { x in
    // The type of x is the tuple (Int, Int).
    // ...
}

let fn2 : (Int, Int) -> Void = { x, y in
    // The type of x is Int, the type of y is Int.
    // ...
}

typealias Name = (firstName: String, lastName: String)
let names: [Name] = [("Linh", "Vo")]

/*
// Swift 3
names.forEach({ first, last in
    print(first, last)                      // "Linh Vo"
})

// Swift 4
names.forEach({ first, last in
    print(first, last)                      // error: closure tuple parameter '(firstName: String, lastName: String)' does not support destructuring
})
 */

// A: Expand by providing the tuple key
names.forEach({ name in
    print(name.firstName, name.lastName)    // "Linh Vo"
})

// B: Expand by providing the amount of tuple elements in a variable
names.forEach({ name in
    let (first, last) = name
    print(first, last)                      // "Linh Vo"
})

// C: Change to a for loop
for (first, last) in names {
    print(first, last)                      // "Linh Vo"
}

//: [Next](@next)
