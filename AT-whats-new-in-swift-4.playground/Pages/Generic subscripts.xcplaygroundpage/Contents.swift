//: [Previous](@previous)

import Foundation

struct JSON {
    var storage: [String: Any]

    init(dictionary: [String: Any]) {
        self.storage = dictionary
    }

    subscript<T>(key: String) -> T? {
        return storage[key] as? T
    }
}

let json = JSON(dictionary: [
    "name": "Linh",
    "country": "VN",
    "money": 6_900_000
    ])

// No need to use as? Int
let money: Int? = json["money"]

/*:
 Another example: a subscript on `Collection` that takes a generic sequence of indices and returns an array of the values at these indices:
 */
extension Collection {
    subscript<Indices: Sequence>(indices indices: Indices) -> [Element] where Indices.Element == Index {
        var result: [Element] = []
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}

let words = "We don't talk anymore".split(separator: " ")
words[indices: [1, 2]]


//: [Next](@next)
