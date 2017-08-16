//
//  PhoneValidation.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/16/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

func isValidNumber(number: String) -> Bool {
    let phoneFormat = "^\\d{3}-\\d{3}-\\d{4}$"
    let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneFormat)
    return phonePredicate.evaluate(with: number)
}
