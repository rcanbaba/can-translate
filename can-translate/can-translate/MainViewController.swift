//
//  MainViewController.swift
//  can-translate
//
//  Created by Can Babaoğlu on 6.07.2023.
//

import Cocoa
import AppKit
import SnapKit

class MainViewController: NSViewController {
    
    private lazy var selectedView: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.red.cgColor
        view.layer?.borderColor = NSColor.yellow.cgColor
        view.layer?.borderWidth = 1.0
        view.layer?.cornerRadius = 25.0
        return view
    }()
    
    override func loadView() {
        view = NSView(frame: NSMakeRect(0.0, 0.0, 800.0, 600.0))
        let label = NSTextField(labelWithString: "Another Controller")
        view.addSubview(label)
        
        view.addSubview(selectedView)
        selectedView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.blue.cgColor
    }

}
