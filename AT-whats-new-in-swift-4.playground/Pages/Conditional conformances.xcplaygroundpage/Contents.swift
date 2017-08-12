//: [Previous](@previous)

import Foundation

/*:
 1. Proposed solution
 
 Swift 3:
 
     func f<T: Equatable>(_: T) {}
     struct NotEquatable {}
     func test(a1: [Int], a2: [NotEquatable]) {
         f(a1)//Argument type '[Int]' does not conform to expected type 'Equatable'
         f(a2)/Argument type '[NotEquatable]' does not conform to expected type 'Equatable'
      }
 
     protocol P {
         func doSomething()
     }
 
	struct S: P {
         func doSomething() {
             print("Swift 3")
         }
     }
 
     extension Array: P where Element: P { //extension of type 'Array' with constraints cannot have an inheritance clause
         func doSomething() {
             for value in self {
                 value.doSomething()
             }
          }
      }
 */
//Swift 4
func f<T: Equatable>(_: T) {
}
struct NotEquatable {}
func test(a: [Int], a2: NotEquatable) {
    f(a) //argument type '[Int]' does not conform to expected type 'Equatable'
    f(a2) //argument type 'NotEquatable' does not conform to expected type 'Equatable'
}

protocol P {
    func doSomething()
}

struct S: P {
    func doSomething() {
        print("Swift 4")
    }
}

extension Array: P where Element: P { //error: extension of type 'Array' with constraints cannot have an inheritance clause
    func doSomething() {
        for value in self {
            value.doSomething()
        }
    }
}

/*:
 2. Detailed design
 
 2.1. Multiple Conformances
 
 Swift 3:
 
     protocol P {}
     struct X: P {}
     extension X: P {}//Redundant conformance of 'X' to protocol 'P'
 
     struct SomeWrapper<Wrapped> {
         let wrapped: Wrapped
     }
 
     protocol HasIdentity {
         static func ==(lhs: Self, rhs: Self) -> Bool
     }

     extension SomeWrapper: Equatable where Wrapped == Int { //Extension of type 'SomeWrapper' with constraints cannot have an inheritance clause
         static func ==(lhs: SomeWrapper<Int>, rhs: SomeWrapper<Int>) -> Bool {
             return lhs.wrapped == rhs.wrapped
         }
     }
 
     extension SomeWrapper: Equatable where Wrapped: HasIdentity { //extension of type 'SomeWrapper' with constraints cannot have an inheritance clause
         static func ==(lhs: SomeWrapper<Wrapped>, rhs: SomeWrapper<Wrapped>) -> Bool {
             return lhs.wrapped == rhs.wrapped
         }
     }
 */
//Swift 4:
protocol P {}
struct X: P {}
extension X: P {} //error: redundant conformance of 'X' to protocol 'P'

struct SomeWrapper<Wrapped> {
    let wrapped: Wrapped
}

protocol HasIdentity {
    static func ==(lhs: Self, rhs: Self) -> Bool
}

extension SomeWrapper: Equatable where Wrapped: Equatable {
    static func ==(lhs: SomeWrapper<Wrapped>, rhs: SomeWrapper<Wrapped>) -> Bool { //error: extension of type 'SomeWrapper' with constraints cannot have an inheritance clause
        return lhs.wrapped == rhs.wrapped
    }
}

extension SomeWrapper: Equatable where Wrapped: HasIdentity { //extension of type 'SomeWrapper' with constraints cannot have an inheritance clause
    static func ==(lhs: SomeWrapper<Wrapped>, rhs: SomeWrapper<Wrapped>) -> Bool {
        return lhs.wrapped == rhs.wrapped
    }
}

/*:
 2.2. Implied conditional conformances
 Swift 3:
     protocol Q: P {}
     protocol R: Q {}
     struct X1<T> {}
     extension X1: Q where T: Q {//extension of type 'X1' with constraints cannot have an inheritance clause
         func f() {}
     }
 
     extension X1: R where T: R { //extension of type 'X1' with constraints cannot have an inheritance clause
         func f() {}
     }
     extension Collection: Equatable where Iterator.Element: Equatable { //error: extension of protocol 'Collection' cannot have an inheritance clause
         static func ==(lhs: Self, rhs: Self) {}
     }

 */
//Swift 4:
protocol P {}
protocol Q {}
protocol R: P {}

struct X<T> {}
extension X: Q where T: Q {} //error: extension of type 'X' with constraints cannot have an inheritance clause
extension X: R where T: R {} //error: extension of type 'X' with constraints cannot have an inheritance clause

extension Collection: Equatable where Iterator.Element: Equatable { //error: extension of protocol 'Collection' cannot have an inheritance clause
    static func ==(lhs: Self, rhs: Self) {}
}

/*:
 3. Overloading across constrained extensions
 
 Swift 3:
 
     protocol P {
         func f()
     }
     
     protocol Q: P {}
     protocol R: Q {}
     
     struct X1<T> {}
     extension X1: Q where T: Q {//extension of type 'X1' with constraints cannot have an inheritance clause
         func f() {
             print("Swift 3")
         }
     }
     
     extension X1: R where T: R { //extension of type 'X1' with constraints cannot have an inheritance clause
         func f() {
             print("Swift 3")
         }
     }
     
     struct X2: R {
         func f() {}
     }
  */
protocol P {
    func f()
}

protocol Q: P {}
protocol R: Q {}

struct X1<T> {}
extension X1: Q where T: Q { //error: extension of type 'X1' with constraints cannot have an inheritance clause
    func f() {
        print("Swift 4")
    }
}

extension X1: R where T: R { //error: extension of type 'X1' with constraints cannot have an inheritance clause
    func f() {
        print("Swift 4")
    }
}

struct X2: R {
    func f() {
        print("Swift 4")
    }
}

X1<X2>().f()

//: [Next](@next)
