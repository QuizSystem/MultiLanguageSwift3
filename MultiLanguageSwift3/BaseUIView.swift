//
//  BaseUIView.swift
//  MultiLanguageSwift3
//
//  Created by Nguyen Van Thieu B on 11/9/16.
//  Copyright © 2016 Thieu Mao. All rights reserved.
//

import UIKit

class BaseUIView: UIView {
    
    var listLanguageView = [UIView]()
    var listLanguageText = [String]()
    
    // Define identifier
    let notificationName = Notification.Name("Did selected language")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLanguage()
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.observerDidChangeLanguage), name: notificationName, object: nil)
    }
    
    func observerDidChangeLanguage(_ notification: Notification) {
        self.setupLanguage()
    }
    
    deinit {
        // Stop listening notification
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil);
    }
    
    func getLanguageFor(_ parentView: UIView) {
        for view in parentView.subviews {
            if let label = view as? UILabel {
                listLanguageView.append(label)
                listLanguageText.append(label.text ?? "")
            } else if let textField = view as? UITextField {
                listLanguageView.append(textField)
                listLanguageText.append(textField.placeholder ?? "")
            } else if let button = view as? UIButton {
                listLanguageView.append(button)
                listLanguageText.append(button.title(for: .normal) ?? "")
            } else {
                self.getLanguageFor(view)
            }
        }
    }
    
    func setupLanguage() {
        if listLanguageView.isEmpty {
            listLanguageView = [UIView]()
            listLanguageText = [String]()
            self.getLanguageFor(self)
        }
        for i in 0..<listLanguageView.count {
            if let label = listLanguageView[i] as? UILabel {
                label.text = Language.get(listLanguageText[i])
            } else if let textField = listLanguageView[i] as? UITextField {
                textField.placeholder = Language.get(listLanguageText[i])
            } else if let button = listLanguageView[i] as? UIButton {
                button.setTitle(Language.get(listLanguageText[i]), for: .normal)
            }
        }
    }
    
}
