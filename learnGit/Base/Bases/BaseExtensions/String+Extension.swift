//
//  StringExtension.swift
//  VegaFintech
//
//  Created by Tu Dao on 5/31/21.
//  Copyright © 2021 Vega. All rights reserved.
//



import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
//let test1 = "the rain in Spain. noi dung"
//print(test1.capitalizedFirstLetter)

extension String {
    var capitalizedFirstLetter:String {
          let string = self
          return string.replacingCharacters(in: startIndex...startIndex, with: String(self[startIndex]).capitalized)
    }
}

public extension String {
    
    public func toInt() -> Int {
        return Int(self) ?? -99
    }
    
//    public func toNotifyObject() -> NotifyData? {
//        do {
//            let data = self.data(using: .utf8, allowLossyConversion: false)
//            let responseData = try JSONDecoder().decode(NotifyData.self, from: data!)
//            return responseData
//        } catch let jsonErr {
//            print("Error decoding Json", jsonErr)
//        }
//        return nil
//    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }

    /**
     It's like substringFromIndex(index: String.Index), but it requires an Int as index
     - parameter from: From index
     - returns: Returns the substring from index
     */
    func subString(from: Int) -> String {
        let indexEndOfText = self.index(self.startIndex, offsetBy: -from)
        return String(self[..<indexEndOfText]);
    }
    
    /**
     It's like substringToIndex(index: String.Index), but it requires an Int as index
     - parameter to: To index
     - returns: Returns the substring to index
     */
    func subString(toIndex: Int) -> String {
        let indexStartOfText = self.index(self.startIndex, offsetBy: toIndex)
        return String(self[indexStartOfText...])
    }
    
    /// Check If string is empty
    ///
    /// - Returns: true if string is empty.
    public func isEmpty() -> Bool {
        if self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        return false
    }
    
    /**
     Creates a substring from the given character
     - parameter character: The character
     - returns: Returns the substring from character
     */
    public func substring(fromCharacter character: Character) -> String? {
        let index: Int = indexOfCharacter(character)
        return subString(from: index)
    }
    
    /**
     Creates a substring to the given character
     - parameter character: The character
     - returns: Returns the substring to character
     */
    public func substring(toCharacter character: Character) -> String? {
        let index: Int = indexOfCharacter(character)
        return subString(toIndex: index)
    }
    
    /**
     Returns the index of the given character
     - parameter char: The character to search
     - returns: Returns the index of the given character, -1 if not found
     */
    
    public func indexOfCharacter(_ character: Character) -> Int {
        if let index = self.firstIndex(of: character) {
            return self.distance(from: startIndex, to: index)
        }
        return -1
    }
    
    /**
     Check if self has the given substring in case-sensitive
     - parameter string:        The substring to be searched
     - parameter caseSensitive: If the search has to be case-sensitive or not
     - returns: Returns true if founded, false if not
     */
    public func hasString(_ string: String, caseSensitive: Bool = true) -> Bool {
        if caseSensitive {
            return self.range(of: string) != nil
        } else {
            return self.lowercased().range(of: string.lowercased()) != nil
        }
    }
    
    var length: Int {
        return self.count
    }
    
    var isLetters: Bool {
        return range(of: "^[a-zA-Z_]", options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var isPhoneNums: Bool {
        return range(of: "^\\d{10,11}$", options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    // trim đểu ----------------------
    func trimming() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func toDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
            return date
        }
        
        return Date()
    }
    
    func isNilOrEmpty() -> Bool {
        return Commons.stringIsNilOrEmpty(str: self)
    }
    
    // MARK: Check validate
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: self)
    }
    
    func containsWhiteSpace() -> Bool {
        
        // check if there's a range for a whitespace
        let range = self.rangeOfCharacter(from: .whitespacesAndNewlines)

        
        // returns false when there's no range for whitespace
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
    func isValidPassword() -> Bool {
        let passwordRex = ".{6,20}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRex)
        return passwordTest.evaluate(with: self)
    }
    
    func isValidFirstNameLastName() -> Bool {
        let passwordRex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{1,16}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", passwordRex)
        
        return emailTest.evaluate(with: self)
    }
    
    func isValidFirstNameLastNameEditFile() -> Bool {
        let specialCharacterRegEx = ".*[!&^%$#@()/]+.*"
        let stringFormat = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        
        return stringFormat.evaluate(with: self)
    }
    
    func isFirstLastNameValidRange() -> Bool {
        let rangeCharacterRegEx = "^.{1,20}$"
        let stringFormat = NSPredicate(format:"SELF MATCHES %@", rangeCharacterRegEx)
        
        return stringFormat.evaluate(with: self)
    }
    
}

