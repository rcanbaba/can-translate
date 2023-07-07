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
        textField.isBordered = true
        textField.backgroundColor = NSColor.white
        textField.focusRingType = .none
        textField.textColor = NSColor.black
        return textField
    }()
    
    private lazy var button: NSButton = {
        let button = NSButton(title: "Submit", target: self, action: #selector(buttonPressed))
        return button
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
        
        selectedView.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.Custom.buttonBlue.cgColor
        textField.becomeFirstResponder()
        clearTextField()
    }
    
    private func clearTextField(){
        textField.stringValue = ""
    }
    
    private func parseInputString(text: String) {
        
    }
    

    
    @objc private func buttonPressed() {
        let inputText = textField.stringValue
        print(inputText)
        parseInputString(text: inputText)
        clearTextField()
    }
    
    
    
    
    /* test string:
     
     family_invitation_accept_popup_contribution_deleted    the contribution points you have provided to your current family will be deleted    mevcut ailene sağladığın katkı puanları silinecek    poin kontribusi yang telah Anda berikan kepada keluarga Anda saat ini akan dihapus    سيتم حذف نقاط المساهمة التي قدمتها لعائلتك الحالية        los puntos de contribución que has proporcionado a tu familia actual serán eliminados    i punti contributo che hai fornito alla tua attuale famiglia verranno cancellati    les points de contribution que vous avez fournis à votre famille actuelle seront supprimés    Die Beitragspunkte, die Sie Ihrer aktuellen Familie zur Verfügung gestellt haben, werden gelöscht    баллы вклада, которые вы предоставили своей текущей семье, будут удалены                family_invitation_accept_popup_contribution_deleted
     
     */
}
