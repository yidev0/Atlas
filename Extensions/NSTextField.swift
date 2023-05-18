//
//  NSTextField.swift
//  Atlas
//
//  Created by Yuto on 2023/05/13.
//

import Foundation
import AppKit.NSTextField

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
