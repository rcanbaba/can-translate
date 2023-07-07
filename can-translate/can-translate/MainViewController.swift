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
    
    private lazy var textField: NSTextField = {
        let textField = NSTextField()
        textField.isEditable = true
        textField.isBordered = false
        textField.backgroundColor = NSColor.black
        textField.focusRingType = .none
        return textField
    }()
    
    override func loadView() {
        view = NSView(frame: NSMakeRect(0.0, 0.0, 800.0, 600.0))
        let label = NSTextField(labelWithString: "Powered by a KPI lover")
        view.addSubview(label)
        
        view.addSubview(selectedView)
        selectedView.snp.makeConstraints { make in
            make.width.equalTo(400)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.center.equalToSuperview()
        }
        
        selectedView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.Custom.buttonBlue.cgColor
        textField.becomeFirstResponder()
    }

}
