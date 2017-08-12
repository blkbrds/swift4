/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 ## String
 ### Multi-Line String Literals
 
 [SE-0168][SE-0168]: This proposal introduces multi-line string literals to Swift source code. This has been discussed a few times on swift-evolution most recently putting forward a number of different syntaxes that could achieve this goal each of which has their own use case and constituency for discussion.

 [SE-0168]: https://github.com/apple/swift-evolution/blob/master/proposals/0168-multi-line-string-literals.md "Swift Evolution Proposal SE-0168: Class and Subtype existentials"
 */
import Foundation

let pleaseDontBeSilent = """
Người đừng lặng im đến thế
Vì lặng im sẽ giết chết con tim!
Dù yêu thương chẳng còn…anh vẫn xin em nói một lời…
Ngoài kia bao la thế giới
"""
let multiLineStringLiteral = """
This is one of the best feature add in Swift 4
\n It let’s you write “Double Quotes” without any escaping
and new lines without need of “\n”
"""
print(multiLineStringLiteral)

print(pleaseDontBeSilent)
/*:
 ### String will be treated as collection
 [SE-0163][SE-0163]: Just like it was in Swift version 1.x Strings can be treated as collection. You no longer need to write string.characters.xxx to perform string manipulation.
 
 [SE-0163]: https://github.com/apple/swift-evolution/blob/master/proposals/0163-string-revision-1.md "Swift Evolution Proposal SE-0163: String Revision: Collection Conformance, C Interop, Transcoding"

 */

let message = "Message!"
message.count // no need of message.characters.count
for character in message {  // no need of message.characters
    print(character)
}
/*:
 ### `Substring` is the new type for string slices
 
 String slices are now instances of type `Substring`. Both `String` and `Substring` conform to `StringProtocol`. Almost the entire string API will live in `StringProtocol` so that `String` and `Substring` behave largely the same.
 */
let galaxy = "Milky Way 🐮"
let endIndex = galaxy.index(galaxy.startIndex, offsetBy: 3)
var milkSubstring = galaxy[galaxy.startIndex...endIndex]   // "Milk"
type(of: milkSubstring)   // Substring.Type

// Concatenate a String onto a Substring
milkSubstring += "🥛"     // "Milk🥛"

// Create a String from a Substring
let milkString = String(milkSubstring) // "Milk🥛"
