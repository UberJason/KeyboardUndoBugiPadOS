# KeyboardUndoBugiPadOS

This project shows a possible bug in iPadOS with a hardware keyboard. When registering with the system `UndoManager`, hitting `CMD+Z` triggers the undo twice.

## Instructions
Run the app on an iPad with a keyboard attached, or iPad simulator with the setting 'Send Keyboard Shortcuts to Device'.

1. Tap 'Register an Action' twice.
2. Observe the console printed that the action was registered twice, and the state is 2.
3. Tap 'Manual Undo (Not from Keyboard) once.
4. Observe the console printed that undo() was called and performUndo was called, and the state is now 1.
5. Tap 'Register an Action' twice more. The state should be 3.
6. Using an iPad with a keyboard attached, or iPad simulator with the setting 'Send Keyboard Shortcuts to Device', hit `CMD+Z`.
7. Observe the console printed that performUndo was called **twice**, and the state is now 1. But it should only have been called once, and the state should be 2.
