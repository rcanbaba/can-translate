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
        view.layer?.backgroundColor = NSColor.Custom.blue.cgColor
        view.layer?.borderColor = NSColor.Custom.white.cgColor
        view.layer?.borderWidth = 1.0
        view.layer?.cornerRadius = 25.0
        return view
    }()
    
    private lazy var textField: NSTextField = {
        let textField = NSTextField()
        textField.isEditable = true
        textField.isBordered = true
        textField.backgroundColor = NSColor.Custom.white
        textField.focusRingType = .exterior
        textField.textColor = NSColor.Custom.black
        let placeholder = "Put translations here!"
        textField.placeholderAttributedString = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: NSColor.lightGray])
    // TODO: UI ı düzeltince bunu da düşün
     //   textField.maximumNumberOfLines = 20
        return textField
    }()
    
    private lazy var backImageView: NSImageView = {
        let imageView = NSImageView()
        imageView.imageScaling = .scaleAxesIndependently
        imageView.image = NSImage(named: NSImage.Name("background-image"))
        return imageView
    }()
    
    private lazy var logoImageView: NSImageView = {
        let imageView = NSImageView()
        imageView.imageScaling = .scaleAxesIndependently
        imageView.image = NSImage(named: NSImage.Name("superlive_header_icon_white"))
        return imageView
    }()
    
    private lazy var submitButton: NSButton = {
        let button = NSButton(title: "Submit", target: self, action: #selector(submitButtonPressed))
        return button
    }()
    
    private lazy var pathButton: NSButton = {
        let button = NSButton(title: "Open", target: self, action: #selector(pathButtonPressed))
        return button
    }()
    
    private lazy var checkButton: NSButton = {
        let button = NSButton(title: "Check", target: self, action: #selector(checkButtonPressed))
        return button
    }()
    
    private lazy var infoStackView: NSStackView = {
        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.distribution = .fillEqually

        let firstInfoLabel = NSTextField(labelWithString: "1. Set .json files directory using Path Button.")
        let secondInfoLabel = NSTextField(labelWithString: "2. Copy translation row from language file.")
        let thirdInfoLabel = NSTextField(labelWithString: "3. Use check button for check translation is missing.")
        let fourthInfoLabel = NSTextField(labelWithString: "4. Use submit button to write key-values to .json files.")
        
        stackView.addArrangedSubview(firstInfoLabel)
        stackView.addArrangedSubview(secondInfoLabel)
        stackView.addArrangedSubview(thirdInfoLabel)
        stackView.addArrangedSubview(fourthInfoLabel)
        
        return stackView
    }()
    
    private lazy var buttonStackView: NSStackView = {
        let stackView = NSStackView()
        stackView.orientation = .horizontal
        stackView.alignment = .top
        stackView.spacing = 40
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(pathButton)
        stackView.addArrangedSubview(checkButton)
        stackView.addArrangedSubview(submitButton)
        
        return stackView
    }()
    
    private lazy var pathTextField: NSTextField = {
        let textField = NSTextField()
        textField.isEditable = false
        textField.isBordered = true
        textField.backgroundColor = NSColor.Custom.white
        textField.focusRingType = .exterior
        textField.textColor = NSColor.Custom.black
        let placeholder = "~/...path"
        textField.placeholderAttributedString = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: NSColor.lightGray])
        return textField
    }()
    
    override func loadView() {
        view = NSView(frame: NSMakeRect(0.0, 0.0, 800.0, 600.0))
        let label = NSTextField(labelWithString: "Powered by a KPI lover")
        
        view.addSubview(backImageView)
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(label)
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(24)
        }
        
        
        view.addSubview(selectedView)
        selectedView.snp.makeConstraints { make in
            make.width.equalTo(400)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(120)
        }
        
        selectedView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(48)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(100)
        }
        
        selectedView.addSubview(pathTextField)
        pathTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(20)
            make.leading.equalToSuperview().inset(48)
            make.bottom.equalToSuperview().inset(96)
        }
        
        selectedView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }

        view.addSubview(infoStackView)
        infoStackView.snp.makeConstraints { make in
            make.leading.equalTo(selectedView.snp.trailing).offset(24)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(selectedView.snp.top).inset(12)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.wantsLayer = true
        textField.becomeFirstResponder()
        clearTextField()
    }
    
    private func clearTextField(){
        textField.stringValue = ""
    }

    
    
    /* test string:
     
     family_invitation_accept_popup_contribution_deleted    the contribution points you have provided to your current family will be deleted    mevcut ailene sağladığın katkı puanları silinecek    poin kontribusi yang telah Anda berikan kepada keluarga Anda saat ini akan dihapus    سيتم حذف نقاط المساهمة التي قدمتها لعائلتك الحالية        los puntos de contribución que has proporcionado a tu familia actual serán eliminados    i punti contributo che hai fornito alla tua attuale famiglia verranno cancellati    les points de contribution que vous avez fournis à votre famille actuelle seront supprimés    Die Beitragspunkte, die Sie Ihrer aktuellen Familie zur Verfügung gestellt haben, werden gelöscht    баллы вклада, которые вы предоставили своей текущей семье, будут удалены                family_invitation_accept_popup_contribution_deleted
     
     
     
     family_inivation_accept_pop_up_cancel    Cancel    Vazgeç    Membatalkan    الغاء    Cancelar    Cancelar    Annulla    Annuler    Abbrechen    Отмена                family_inivation_accept_pop_up_cancel
     */
}

// MARK: - Input Parsing
extension MainViewController {
    
    private func parseInputString(text: String) {
        let parts = text.components(separatedBy: "\t")
        let emptyPartsEliminated = parts.filter({!$0.isEmpty})
        
        //TODO: burda hangi indexin empty geldiğine göre şu dilin çevirisi eksik diye alert basalım
        guard checkInputFormatIsOk(emptyPartsEliminated) else {
            presentAlert(title: "Error", description: "The input text could not be parsed correctly. Please make sure it's in the correct format.")
            clearTextField()
            return
        }
        
    }
    
    private func checkInputFormatIsOk(_ inputArray: [String]) -> Bool {
        inputArray.count == Constants.expectedColumnCount
    }
    
}

// MARK: - File Operations
extension MainViewController {
    
    private func openPanel() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false

        panel.begin { (result) -> Void in
            if result == .OK {
                guard let url = panel.urls.first else { return }
                
                self.setURLPathString( url.path)
                self.getFilesInURL(url)
            }
        }
    }
    
    private func setURLPathString(_ path: String) {
        pathTextField.stringValue = path
    }
    
    private func getFilesInURL(_ url: URL) {
        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])

        //TODO: burda tutulan .json ların bizimkilerle aynı isimde mi bi kontrol ekleyelim 10 tane mi vs
        var jsonFiles: [URL] = []
        while let fileURL = enumerator?.nextObject() as? URL {
            do {
                let resourceValues = try fileURL.resourceValues(forKeys: [.isRegularFileKey])
                if resourceValues.isRegularFile == true, fileURL.pathExtension == "json" {
                    jsonFiles.append(fileURL)
                }
            } catch {
                print("Error retrieving resource values for file at \(fileURL): \(error)")
            }
        }
        
        readJsonFiles(jsonFiles)
    }
    
    private func readJsonFiles(_ jsonFiles: [URL]) {
        // Now jsonFiles contains URLs for all json files in the selected directory
        for jsonFile in jsonFiles {
            do {
                let data = try Data(contentsOf: jsonFile)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print("Error reading json file at \(jsonFile): \(error)")
            }
        }
    }
    
}


// MARK: - Actions
extension MainViewController {
    @objc private func submitButtonPressed() {
        let inputText = textField.stringValue
        print(inputText)
        parseInputString(text: inputText)
        clearTextField()
    }
    
    @objc private func pathButtonPressed() {
        openPanel()
    }
    
    @objc private func checkButtonPressed() {
        //TODO:
    }
    
}

// MARK: - Alerts
extension MainViewController {
    private func presentAlert(title: String, description: String) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = description
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
}
