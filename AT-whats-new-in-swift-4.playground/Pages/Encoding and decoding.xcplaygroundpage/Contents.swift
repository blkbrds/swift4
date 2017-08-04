//: [Previous](@previous)

import Foundation
/*:
 Swift 4 introduces a new Codable protocol that lets you serialize and deserialize custom data types without writing any special code – and without having to worry about losing your value types. Even better, you can choose how you want the data to be serialized: you can use classic property list format or even JSON.
*/
// Custom data type and some instance of it:
struct Country: Codable {
    var name: String
    var cities: [City]
    init(name: String, cities: [City]) {
        self.name = name
        self.cities = cities
    }
}

struct City: Codable {
    var name: String
    var district: [String] = []
    init(name: String, district: [String]) {
        self.name = name
        self.district = district
    }
}

let country = Country(name: "Viet Nam", cities: [City(name: "Da Nang", district: ["Lien Chieu", "Thanh Khe"])])

//Encode country to a Data representation of JSON like this:
let encoder = JSONEncoder()
guard let encoded = try? encoder.encode(country) else { fatalError() }
if let json = String(data: encoded, encoding: .utf8) {
    print(json) //{"name":"Viet Nam","cities":[{"name":"Da Nang","district":["Lien Chieu","Thanh Khe"]}]}
}
//Decode json back into a new Country instance
let decoder = JSONDecoder()
if let decoded = try? decoder.decode(Country.self, from: encoded) {
    print(decoded.name) // Viet Nam
    for city in decoded.cities {
        print(city.name) // Da Nang
        print(city.district) // ["Lien Chieu", "Thanh Khe"]
    }
}
var people: [String] = ["Hello", "Docbao"]
for _ in 0..<3 {
    print("Hello")
}
for (index, person) in people.enumerated() {
    print(index)
    print(person)
}

//: [Next](@next)
