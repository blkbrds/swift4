/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 ## String
 ### Multi-Line String Literals
 
 [SE-0168][SE-0168]: This proposal introduces multi-line string literals to Swift source code. This has been discussed a few times on swift-evolution most recently putting forward a number of different syntaxes that could achieve this goal each of which has their own use case and constituency for discussion.

 [SE-0168]: https://github.com/apple/swift-evolution/blob/master/proposals/0168-multi-line-string-literals.md "Swift Evolution Proposal SE-0168: Class and Subtype existentials"
 */
import Foundation
let pleaseDontKeepSilent = """
Người đừng lặng im đến thế
Vì lặng im sẽ giết chết con tim!
Dù yêu thương chẳng còn…anh vẫn xin em nói một lời…
Ngoài kia bao la thế giới
"""
print(pleaseDontKeepSilent)

/*:
 ### Strings as Collections
 
 [SE-0163][SE-0163] is the first part of the revised string model for Swift 4. The biggest change is that `String` is a `Collection` again (as it used to be in Swift 1.x), i.e. the functionality of `String.CharacterView` has been folded into the parent type. (The other views, `UnicodeScalarView`, `UTF8View`, and `UTF16View`, still exist.)
 
 [SE-0163]: https://github.com/apple/swift-evolution/blob/master/proposals/0163-string-revision-1.md "Swift Evolution Proposal SE-0163: String Revision: Collection Conformance, C Interop, Transcoding"

 */
let galaxy = "Milky Way 🐮"
galaxy.count
galaxy.reversed()
galaxy.dropLast()
galaxy.dropFirst()
galaxy.dropLast(3)

galaxy.filter { (char) -> Bool in
    return String(char) == "y"
}

for char in galaxy {
    print(char)
}

// Filter out any none ASCII characters
galaxy.filter { char in
    let isASCII = char.unicodeScalars.reduce(true, { $0 && $1.isASCII })
    return isASCII
} // "Milky Way "
/*:
 ### `Substring` is the new type for string slices
 
 String slices are now instances of type `Substring`. Both `String` and `Substring` conform to `StringProtocol`. Almost the entire string API will live in `StringProtocol` so that `String` and `Substring` behave largely the same.
 */

let endIndex = galaxy.index(galaxy.startIndex, offsetBy: 3)
var milkSubstring = galaxy[galaxy.startIndex...endIndex]   // "Milk"
type(of: milkSubstring)   // Substring.Type

// Concatenate a String onto a Substring
milkSubstring += "🥛"     // "Milk🥛"

// Create a String from a Substring
let milkString = String(milkSubstring) // "Milk🥛"

/*:
 ### Unicode 9
 
 Swift 4 supports Unicode 9, fixing [some problems with proper grapheme clustering for modern emoji][Emoji 4.0]. All the character counts below are now correct (they weren’t in Swift 3):
 
 [Emoji 4.0]: https://oleb.net/blog/2016/12/emoji-4-0/
 */
"👧🏽".count // person + skin tone; in Swift 3: 2
"👨‍👩‍👧‍👦".count // family with four members; in Swift 3: 4
"👱🏾\u{200D}👩🏽\u{200D}👧🏿\u{200D}👦🏻".count // family + skin tones; in Swift 3: 8
"👩🏻‍🚒".count // person + skin tone + profession; in Swift 3: 3
"🇨🇺🇬🇫🇱🇨".count // multiple flags; in Swift 3: 1

/*:
 ### `Unicode Scalars for Characters`
 
 You can now access the code points of a `Character` directly without having to convert it to a `String` first ([SE-0178][SE-0178]):
 
 [SE-0178]: https://github.com/apple/swift-evolution/blob/master/proposals/0178-character-unicode-view.md "Swift Evolution Proposal SE-0178: Add `unicodeScalars` property to `Character`"
 */
let c: Character = "🇪🇺"
Array(c.unicodeScalars)
