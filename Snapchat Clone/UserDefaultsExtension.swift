//
//  UserDefaultsExtension.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 9/1/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
        case isFirstLaunch
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    func setIsFirstLaunch(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isFirstLaunch.rawValue)
    }
    func isFirstLaunch() -> Bool {
        return bool(forKey: UserDefaultsKeys.isFirstLaunch.rawValue)
    }
}
