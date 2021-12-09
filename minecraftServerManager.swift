#!/usr/bin/swift

import Foundation

/// Nastavování důležitých proměnných
let fileManager = FileManager.default
let currentFolder = fileManager.currentDirectoryPath

let workingDirectory_name = "Assets"
var workingDirectory_path = currentFolder.appendingFormat("/" + workingDirectory_name)

// KONEC

/// Enumy, třídy apod.
enum IndentationOptions {
    case mini
    case normal
    case extra
}
enum TextDecoration {
    case header
    case helper
    case error
    case warning
    case systemInfo
}

// KONEC

/// Důležité funkce
func indentLine(indentSize: IndentationOptions) -> String {
    var iterator: Int = 0
    
    let loopConstant: Int
    var outputSpaces: String = ""
    
    switch indentSize {
    case .mini:
        loopConstant = 2
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
        print("Folder Created!\nAt: >> \(workingDirectory_path.appendingFormat("/" + name)) <<")
    } catch let error as NSError {
        print("Unable to create this folder!\nError Message: \(error.debugDescription)")
    }
}
func createAssetsFolder() {
    do {
        try fileManager.createDirectory(atPath: workingDirectory_path, withIntermediateDirectories: false, attributes: nil)
        print("Assets folder created!")
    } catch let error as NSError {
        print("Unable to create the Assets folder!\nError Message: \(error.debugDescription)")
    }
}
// KONEC

/// Vlastní kód
if assetsFolderExists() {
    print("Existuje")
} else {
    print("Neexistuje")
    createAssetsFolder()
}
// KONEC
