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
    
    private lazy var inputTextField: EditableTextField = {
        let textField = EditableTextField()
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
        
        let firstInfoLabel = NSTextField(labelWithString: "1. Set .json files directory using Open Button.")
        let secondInfoLabel = NSTextField(labelWithString: "2. Copy translation row from language file.")
        let thirdInfoLabel = NSTextField(labelWithString: "3. Use Check Button to check translation is missing.")
        let fourthInfoLabel = NSTextField(labelWithString: "4. Use Submit Button to write key-values to .json files.")
        let fifthInfoLabel = NSTextField(labelWithString: "5. Do not forget to push changes in translation .json files.")
        let sixthInfoLabel = NSTextField(labelWithString: "6. Do not forget to upload translation files to isolated environment.")
        
        stackView.addArrangedSubview(firstInfoLabel)
        stackView.addArrangedSubview(secondInfoLabel)
        stackView.addArrangedSubview(thirdInfoLabel)
        stackView.addArrangedSubview(fourthInfoLabel)
        stackView.addArrangedSubview(fifthInfoLabel)
        stackView.addArrangedSubview(sixthInfoLabel)
        
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
    
    private lazy var environmentURLTextField: NSTextField = {
        let textField = NSTextField()
        textField.isEditable = true
        textField.isBordered = true
        textField.backgroundColor = NSColor.Custom.white
        textField.focusRingType = .exterior
        textField.textColor = NSColor.Custom.black
        let placeholder = "https://api-..."
        textField.placeholderAttributedString = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: NSColor.lightGray])
        return textField
    }()
    
    private var inputStrings: [String] = []
    
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
        
        selectedView.addSubview(inputTextField)
        inputTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(48)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(100)
        }
        
        selectedView.addSubview(environmentURLTextField)
        environmentURLTextField.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(196)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(20)
        }
        
        selectedView.addSubview(pathTextField)
        pathTextField.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.trailing.equalToSuperview().inset(24)
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
        inputTextField.becomeFirstResponder()
        clearTextField()
    }
    
    private func clearTextField(){
        inputTextField.stringValue = ""
    }
    
    private func clearFilePathTextField() {
        pathTextField.stringValue = ""
    }
    
    
    
    /* test string:
     
     family_invitation_accept_popup_contribution_deleted    the contribution points you have provided to your current family will be deleted    mevcut ailene sağladığın katkı puanları silinecek    poin kontribusi yang telah Anda berikan kepada keluarga Anda saat ini akan dihapus    سيتم حذف نقاط المساهمة التي قدمتها لعائلتك الحالية        los puntos de contribución que has proporcionado a tu familia actual serán eliminados    i punti contributo che hai fornito alla tua attuale famiglia verranno cancellati    les points de contribution que vous avez fournis à votre famille actuelle seront supprimés    Die Beitragspunkte, die Sie Ihrer aktuellen Familie zur Verfügung gestellt haben, werden gelöscht    баллы вклада, которые вы предоставили своей текущей семье, будут удалены                family_invitation_accept_popup_contribution_deleted
     
     
     
     family_inivation_accept_pop_up_cancel    Cancel    Vazgeç    Membatalkan    الغاء    Cancelar    Cancelar    Annulla    Annuler    Abbrechen    Отмена                family_inivation_accept_pop_up_cancel
     
     
     Platinum    Platinum    Platinum        Platinum    Platina    Platino    Platino    Platinum     Platin    Платиновый                Platinum
     */
}

// MARK: - Input Parsing
extension MainViewController {
    
    private func parseInputString(text: String) {
        let parts = text.components(separatedBy: "\t")
        
        let isError = checkInputArrayError(parts: parts)
        
        if isError != "" {
            presentAlert(title: "Error: input", description: isError + "translations are missing")
        } else {
            let emptyPartsEliminated = parts.filter({!$0.isEmpty})
            
            guard checkInputFormatIsOk(emptyPartsEliminated) else {
                presentAlert(title: "Error", description: "The input text could not be parsed correctly. Please make sure it's in the correct format.")
                clearTextField()
                return
            }
            
            inputStrings = emptyPartsEliminated
        }
        
    }
    
    private func checkInputArrayError(parts: [String]) -> String {
        var errorMessage: String = ""
        for i in Constants.languagesFileOrdered.indices {
            if parts[i].isEmpty {
                errorMessage.append(Constants.languagesFileOrdered[i] + "\n")
            }
        }
        return errorMessage
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
                
                self.setURLPathString(url.path)
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
                presentAlert(title: "Error: path", description: "Error retrieving resource values for file at \(fileURL): \(error)")
                clearFilePathTextField()
                return
            }
        }
        checkJsonFilesIsProperThenRead(fileURLs: jsonFiles)
    }
    
    private func checkJsonFilesIsProperThenRead(fileURLs: [URL]) {
        if fileURLs.isEmpty {
            presentAlert(title: "Error: json files", description: "There is no json file in the given path")
            clearFilePathTextField()
            return
        }
        
        let fileURLPath = fileURLs.compactMap({$0.lastPathComponent})
        
        var errorMessage: String = ""
        Constants.supportedJsonFiles.forEach { item in
            if !fileURLPath.contains(item) {
                errorMessage.append("\(item) \n")
            }
        }
        
        if errorMessage != "" {
            presentAlert(title: "Error: json files", description: errorMessage + "\n are missing in the given path.")
            clearFilePathTextField()
        } else {
            readJsonFiles4(fileURLs)
        }
    }
    
    
    private func readJsonFiles3(_ jsonFiles: [URL]) {
        for jsonFile in jsonFiles {
            do {
                let data = try Data(contentsOf: jsonFile)
                if var json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Append your new values here
                    json["newKey"] = "newValue"

                    // Convert the dictionary back to JSON
                    let newData = try JSONSerialization.data(withJSONObject: json, options: [])
                    
                    DispatchQueue.main.async {
                        // Ask the user where to save the modified file
                        let savePanel = NSSavePanel()
                        savePanel.nameFieldStringValue = jsonFile.lastPathComponent
                        savePanel.begin { (result) in
                            if result == .OK, let targetURL = savePanel.url {
                                do {
                                    try newData.write(to: targetURL)
                                } catch {
                                    self.presentAlert(title: "Error: json", description: "Error writing json file at \(targetURL): \(error)")
                                    self.clearFilePathTextField()
                                }
                            }
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.presentAlert(title: "Error: json", description: "Error reading json file at \(jsonFile): \(error)")
                    self.clearFilePathTextField()
                }
            }
        }
    }
    
    private func readJsonFiles4(_ jsonFiles: [URL]) {
        for jsonFile in jsonFiles {
            do {
                let data = try Data(contentsOf: jsonFile)
                if var json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    
                    let fileName = jsonFile.lastPathComponent
                    
                    /*
                     "localization_ar.json",
                     "localization_de.json",
                     "localization_es.json",
                     "localization_en.json",
                     "localization_fr.json",
                     "localization_id.json",
                     "localization_it.json",
                     "localization_pt.json",
                     "localization_ru.json",
                     "localization_tr.json"
                     
                     "English", 1
                     "Turkish", 2
                     "Indonesian", 3
                     "Arabic", 4
                     "Portuguese", 5
                     "Spanish", 6
                     "Italian", 7
                     "French", 8
                     "German", 9
                     "Russian" 10
                     */
                    
                    switch fileName {
                    case Constants.supportedJsonFiles[0]: // ar
                        json[inputStrings[0]] = inputStrings[4]
                        
                    case Constants.supportedJsonFiles[1]: // de
                        json[inputStrings[0]] = inputStrings[9]
                        
                    case Constants.supportedJsonFiles[2]: // es
                        json[inputStrings[0]] = inputStrings[6]
                        
                    case Constants.supportedJsonFiles[3]: // en
                        json[inputStrings[0]] = inputStrings[1]
                        
                    case Constants.supportedJsonFiles[4]: // fr
                        json[inputStrings[0]] = inputStrings[8]
                        
                    case Constants.supportedJsonFiles[5]: // id
                        json[inputStrings[0]] = inputStrings[3]
                        
                    case Constants.supportedJsonFiles[6]: // it
                        json[inputStrings[0]] = inputStrings[7]
                        
                    case Constants.supportedJsonFiles[7]: // pt
                        json[inputStrings[0]] = inputStrings[5]
                        
                    case Constants.supportedJsonFiles[8]: // ru
                        json[inputStrings[0]] = inputStrings[10]
                        
                    case Constants.supportedJsonFiles[9]: // tr
                        json[inputStrings[0]] = inputStrings[2]
                        
                    default:
                        // Handle any other case
                        // Add your code here
                        print("Handling other cases Error")
                    }

                    // Convert the dictionary back to JSON
                    let newData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    
                    // Write the new data back to the file
                    try newData.write(to: jsonFile)
                }
            } catch {
                presentAlert(title: "Error: json", description: "Error reading or writing json file at \(jsonFile): \(error)")
                clearFilePathTextField()
            }
        }
    }
    
}


// MARK: - Actions
extension MainViewController {
    @objc private func submitButtonPressed() {

    }
    
    @objc private func pathButtonPressed() {
        openPanel()
    }
    
    @objc private func checkButtonPressed() {
        let inputText = inputTextField.stringValue
        print(inputText)
        parseInputString(text: inputText)
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
