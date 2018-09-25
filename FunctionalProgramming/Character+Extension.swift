import Foundation

extension Character {
    static func + (_ c: Character, _ s: String) -> String {
        return String(c) + s
    }

    static func + (_ c: Character, _ s: Substring) -> String {
        return String(c) + String(s)
    }
}
