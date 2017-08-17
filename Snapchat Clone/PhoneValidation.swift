//
//  PhoneValidation.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/16/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit

func isValidNumber(number: String) -> Bool {
    print("the number is:\(number)")
    let phoneFormat = "^\\d{3}-\\d{3}-\\d{4}$"
    let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneFormat)
    return phonePredicate.evaluate(with: number)
}
func formatNumber(_ phonumbneNumber: String) -> String {
    var number = phonumbneNumber
    number = number.replacingOccurrences(of: "(", with: "")
    number = number.replacingOccurrences(of: ")", with: "")
    number = number.replacingOccurrences(of: " ", with: "")
    number = number.replacingOccurrences(of: "-", with: "")
    number = number.replacingOccurrences(of: "+", with: "")
    let numberLength = Int(number.characters.count)
    if numberLength > 15 {
        let index = number.index(number.startIndex, offsetBy: 15)
        number = number.substring(to: index)
    }
    return number
}
func getLength(number: String) -> Int {
    var number = number
    number = number.replacingOccurrences(of: "(", with: "")
    number = number.replacingOccurrences(of: ")", with: "")
    number = number.replacingOccurrences(of: " ", with: "")
    number = number.replacingOccurrences(of: "-", with: "")
    number = number.replacingOccurrences(of: "+", with: "")
    let numberLength = Int(number.characters.count)
    return numberLength
}
func checkNumber(phoneNumber: String) -> String {
    var number = phoneNumber
    number = number.replacingOccurrences(of: "(", with: "")
    number = number.replacingOccurrences(of: ") ", with: "-")
    return number
}
