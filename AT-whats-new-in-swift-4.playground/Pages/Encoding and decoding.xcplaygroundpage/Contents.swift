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

extension Country {
    
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    //Encode country to a Data representation of JSON like this:
    func toJson() -> String {
        guard let data = toData(), let json = String(data: data, encoding: .utf8) else { return "" }
        return json
    }
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(Country.self, from: data)
    }
}

let country = Country(name: "Viet Nam", cities: [City(name: "Da Nang", district: ["Lien Chieu", "Thanh Khe"])])
print(country.toJson()) //{"name":"Viet Nam","cities":[{"name":"Da Nang","district":["Lien Chieu","Thanh Khe"]}]}

//Decode json back into a new Country instance
if let data = country.toData(), let newCountry = try? Country(data: data)  {
    print(newCountry.name) // Viet Nam
    for city in newCountry.cities {
        print(city.name) // Da Nang
        print(city.district) // ["Lien Chieu", "Thanh Khe"]
    }
}
/*:
 
 The following Foundation Swift types will be adopting Codable, and will encode as their bridged types when encoded through NSKeyedArchiver, as mentioned above:
 
 1. AffineTransform
 1. Calendar
 1. CharacterSet
 1. Date
 1. DateComponents
 1. DateInterval
 1. Decimal
 1. IndexPath
 1. IndexSet
 1. Locale
 1. Measurement
 1. Notification
 1. PersonNameComponents
 1. TimeZone
 1. URL
 1. URLComponents
 1. URLRequest
 1. UUID
 1. Along with these, the Array, Dictionary, and Set types will gain Codable conformance (as part of the Conditional Conformance feature), and encode through NSKeyedArchiver as NSArray, NSDictionary, and NSSet respectively
 */

//: [Next](@next)
