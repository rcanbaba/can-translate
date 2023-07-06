//
//  AppDelegate.swift
//  can-translate
//
//  Created by Can Babaoğlu on 6.07.2023.
//

import Cocoa

//@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var viewController: MainViewController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 270),
            styleMask: [.miniaturizable, .closable, .resizable, .titled],
            backing: .buffered, defer: false)
        
        viewController = MainViewController()
        
        window.contentViewController = viewController
        window.center()
        window.title = "No Storyboard Window"
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

