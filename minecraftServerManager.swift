#!/usr/bin/swift

import Foundation

/// Nastavování důležitých proměnných
let fileManager = FileManager.default
let currentFolder = fileManager.currentDirectoryPath

let workingDirectory_name = "Assets"
var workingDirectory_path = currentFolder.appendingFormat("/" + workingDirectory_name)

let instancesDirectory_name = "Instances"
let instancesDirectory_path = workingDirectory_path.appendingFormat("/" + instancesDirectory_name)

let sharedConfigDirectory_name = "Shared Server Configuration"
let sharedConfigDirectory_path = workingDirectory_path.appendingFormat("/" + sharedConfigDirectory_name)
// KONEC

/// Enumy, třídy apod.
enum IndentationOptions {
    case mini
    case normal
    case messageNewline
    case extra
}
enum TextDecoration: String {
    case header     = ">>>"
    case helper     = "<?>"
    case success    = "<✔>"
    case error      = "<X>"
    case warning    = "<!>"
    case systemInfo = "-->"
}

// KONEC

/// Důležité funkce
func writeToConsole(format: TextDecoration, message: String) {
    print("\(format.rawValue) \(message)")
}
func indentLine(indentSize: IndentationOptions) -> String {
    var iterator: Int = 0
    
    let loopConstant: Int
    var outputSpaces: String = ""
    
    switch indentSize {
    case .mini:
        loopConstant = 2
    case .messageNewline:
        loopConstant = 3
    case .normal:
        loopConstant = 4
    case .extra:
        loopConstant = 6
    }
    
    while iterator <= loopConstant {
        outputSpaces.append(" ")
        iterator += 1
    }
    
    return outputSpaces
}
func newLine() -> String {
    return "\n\(indentLine(indentSize: .messageNewline))"
}

func folderExists(at subfolder: String) -> Bool {
    if fileManager.fileExists(atPath: workingDirectory_path.appendingFormat("/" + subfolder)) {
        return true
    } else {
        return false
    }
}
func assetsFolderExists() -> Bool {
    if fileManager.fileExists(atPath: workingDirectory_path) {
        return true
    } else {
        return false
    }
}

func createSubfolder(of folder: String, name: String) {
    do {
        try fileManager.createDirectory(atPath: workingDirectory_path.appendingFormat("/" + name), withIntermediateDirectories: true, attributes: nil)
        writeToConsole(format: .success, message: "Folder Created!\(newLine())At: \(workingDirectory_path.appendingFormat("/" + name))")
    } catch let error as NSError {
        writeToConsole(format: .error, message: "Unable to create this folder!\nError Message: \(error.debugDescription)")
    }
}
func createAssetsFolder() {
    do {
        try fileManager.createDirectory(atPath: workingDirectory_path, withIntermediateDirectories: false, attributes: nil)
        writeToConsole(format: .success, message: "Assets folder created!")
    } catch let error as NSError {
        writeToConsole(format: .error, message: "Unable to create the Assets folder!\nError Message: \(error.debugDescription)")
    }
}
func setFoldersUp() {
    createAssetsFolder()
    createSubfolder(of: workingDirectory_path, name: instancesDirectory_name)
    createSubfolder(of: workingDirectory_path, name: sharedConfigDirectory_name)
}
// KONEC

/// Vlastní kód
if assetsFolderExists() {
    writeToConsole(format: .systemInfo, message: "Existuje")
} else {
    writeToConsole(format: .systemInfo, message: "Neexistuje")
    setFoldersUp()
}
// KONEC
