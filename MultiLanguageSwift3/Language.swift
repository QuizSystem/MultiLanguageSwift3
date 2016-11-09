//
//  Language.swift
//  MultiLanguageSwift3
//
//  Created by Nguyen Van Thieu B on 11/9/16.
//  Copyright © 2016 Thieu Mao. All rights reserved.
//

import UIKit


class Language: NSObject {
    
    static var bundle: Bundle? = nil
    
    override class func initialize() {
        var current = self.getCurrentLanguage()
        self.setLanguage(current)
    }
    
    class func setLanguage(_ language: String) {
        UserDefaults.standard.set(language, forKey: "curren_language")
        UserDefaults.standard.synchronize()
        var filePath = "\(self.appDocumentDirectory())/\(language).lproj"
        var exists = FileManager.default.fileExists(atPath: filePath)
        if !exists {
            filePath = Bundle.main.path(forResource: language, ofType: "lproj")!
        }
        bundle = Bundle(path: filePath)
    }
    
    class func getCurrentLanguage() -> String {
        var defs = UserDefaults.standard
        var lang = defs.object(forKey: "curren_language") as! String?
        if lang?.characters.count == 0 {
            return lang!
        }
        else {
            return "vi"
        }
    }
    
    class func get(_ key: String) -> String {
        var result = bundle!.localizedString(forKey: key, value: nil, table: nil)
        if result == "" {
            result = key
        }
        return result
    }
    
    class func appDocumentDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    class func getLanguageCode(_ language: String) -> String {
        if (language == "Indonesia") {
            return "id"
        }
        else if (language == "English") {
            return "en"
        }
        else if (language == "Japanese") {
            return "ja"
        }
        else if (language == "Thái Lan") {
            return "th"
        }
        return "vi"
    }
    
}
