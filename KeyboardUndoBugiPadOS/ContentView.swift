//
//  ContentView.swift
//  KeyboardUndoBugiPadOS
//
//  Created by Jason Ji on 2/19/20.
//  Copyright © 2020 Jason Ji. All rights reserved.
//

import SwiftUI

class MyObject: ObservableObject {
    var undoManager: UndoManager?
    var state: Int = 0
    
    init(undoManager: UndoManager? = nil) {
        self.undoManager = undoManager
    }
    
    func registerAction() {
        state += 1
        undoManager?.registerUndo(withTarget: self, selector: #selector(performUndo), object: nil)
        print("registered action - state is \(state)")
    }
    
    @objc func performUndo() {
        state -= 1
        print("performUndo called - state is \(state)")
    }
    
    func undo() {
        print("undo() called")
        undoManager?.undo()
    }
}

struct ContentView: View {
    @ObservedObject var model: MyObject
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading) {
                Text("Instructions").font(.system(.headline))
                Group {
                Text("1. Tap 'Register an Action' twice.")
                Text("2. Observe the console printed that the action was registered twice, and the state is 2.")
                Text("3. Tap 'Manual Undo (Not from Keyboard) once.")
                Text("4. Observe the console printed that undo() was called and performUndo was called, and the state is now 1.")
                Text("5. Tap 'Register an Action' twice more. The state should be 3.")
                Text("6. Using an iPad with a keyboard attached, or iPad simulator with the setting 'Send Keyboard Shortcuts to Device', hit `CMD+Z`.\n")
                Text("On Xcode 11.3.1 and iPadOS 13.3:").italic()
                Text("Observe the console printed that performUndo was called ") + Text("twice").fontWeight(.bold) + Text(", and the state is now 1. But it should only have been called once, and the state should be 2.\n")
                Text("On Xcode 11.4 beta 2 and iPadOS 13.4 beta 2:").italic()
                Text("Observe that the console printed that performUndo was called once, and the state is now 2. But any subsequent presses of CMD+Z do ") + Text("not").fontWeight(.bold) + Text(" call performUndo, and the state remains at 2.")
                }
            }
            .padding([.leading, .trailing], 40)
            .padding(.bottom, 40)
            
            Button(action: {
                self.model.registerAction()
            }) {
                Text("Register an Action")
            }
            Button(action: {
                self.model.undo()
            }) {
                Text("Manual Undo (Not from Keyboard)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: MyObject())
    }
}
