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
