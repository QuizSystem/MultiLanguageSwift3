//
//  ViewController.swift
//  MultiLanguageSwift3
//
//  Created by Nguyen Van Thieu B on 11/9/16.
//  Copyright © 2016 Thieu Mao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let notificationName = Notification.Name("Did selected language")
    var language = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        language = ["English", "Japanese", "Thái Lan", "Indonesia", "Việt Nam"]
    }

    @IBAction func changeLanguage(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Language", message: "Select language", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: {() -> Void in })
        }))
        for item in language {
            actionSheet.addAction(UIAlertAction(title: item, style: .default, handler: {(_ action: UIAlertAction) -> Void in
                let langCode = Language.getLanguageCode(item)
                Language.setLanguage(langCode)
                NotificationCenter.default.post(name: self.notificationName, object: nil)
                self.dismiss(animated: true, completion: {() -> Void in })
            }))
        }
        self.present(actionSheet, animated: true, completion: { _ in })
    }
    
}

