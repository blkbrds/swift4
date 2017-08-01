//: [Previous](@previous)

import Foundation

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
let encoder = JSONEncoder()
if let encoded = try? encoder.encode(country) {
    if let json = String(data: encoded, encoding: .utf8) {
        print(json) //{"name":"Viet Nam","cities":[{"name":"Da Nang","district":["Lien Chieu","Thanh Khe"]}]}
    }
    let decoder = JSONDecoder()
    if let decoded = try? decoder.decode(Country.self, from: encoded) {
        print(decoded.name) // Viet Nam
        for city in decoded.cities {
            print(city.name) // Da Nang
            print(city.district) // ["Lien Chieu", "Thanh Khe"]
        }
    }
}
//: [Next](@next)
