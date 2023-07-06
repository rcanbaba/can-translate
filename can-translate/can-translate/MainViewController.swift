//
//  MainViewController.swift
//  can-translate
//
//  Created by Can Babaoğlu on 6.07.2023.
//

import Cocoa
import AppKit

class MainViewController: NSViewController {
    
    override func loadView() {
        view = NSView(frame: NSMakeRect(0.0, 0.0, 800.0, 600.0))
        let label = NSTextField(labelWithString: "Another Controller")
        view.addSubview(label)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.blue.cgColor
    }

}
