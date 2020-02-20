//
//  FirstResponderHostingController.swift
//  Freecell
//
//  Created by Jason Ji on 12/31/19.
//  Copyright © 2019 Jason Ji. All rights reserved.
//

import SwiftUI
import UIKit

/// UIHostingController subclass which can become first responder.
/// Necessary in order to be able to respond to undo gestures.
/// See: https://stackoverflow.com/questions/57931860/swiftui-and-the-three-finger-undo-gesture
class FirstResponderHostingController<Content: View>: UIHostingController<Content> {
    override var canBecomeFirstResponder: Bool { true }
}
