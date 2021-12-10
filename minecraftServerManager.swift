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
    case systemInfo = "..."
    
}

// KONEC

/// Důležité funkce
func writeToConsole(format: TextDecoration, message: String) { // Psaní do konzole
    print("\(format.rawValue) \(message) \(newLine())")
}
func exitProgram(funny: Bool?) { // Vypnutí programu
    let funnyExitMessages: [String] = ["Understandable, have a nice day", "Thank you for your time", "ight lemme head out", "Adios"]
    if funny != nil {
        writeToConsole(format: .success, message: "\(funnyExitMessages[Int.random(in: 0..<funnyExitMessages.count)])\n*dies*")
    }
    exit(-1)
}
func indentLine(indentSize: IndentationOptions) -> String { // Odsazení zpráv
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
func newLine() -> String { // Vlastní implementace nového řádku. Automaticky odsazuje nové řádky
    return "\n\(indentLine(indentSize: .messageNewline))"
}

func folderExists(at subfolder: String) -> Bool { // Zjištění, jestli složka existuje
    if fileManager.fileExists(atPath: workingDirectory_path.appendingFormat("/" + subfolder)) {
        return true
    } else {
        return false
    }
}
func createSubfolder(of folder: String, name: String) { // Vytvoření podsložky ve složce Assets. Aby se to nesralo do souborového systému uživatele
    do {
        try fileManager.createDirectory(atPath: workingDirectory_path.appendingFormat("/" + name), withIntermediateDirectories: true, attributes: nil)
        writeToConsole(format: .success, message: "Folder Created!\(newLine())At: \(workingDirectory_path.appendingFormat("/" + name))")
    } catch let error as NSError {
        writeToConsole(format: .error, message: "Unable to create this folder!\nError Message: \(error.debugDescription)")
    }
}

func assetsFolderExists() -> Bool { // Zjištění, jestli složka Assets existuje. Vlastní funkce, protože tohle je jediná funkce, která funguje jinde, než ve složce Assets
    if fileManager.fileExists(atPath: workingDirectory_path) {
        return true
    } else {
        return false
    }
}
func createAssetsFolder() { // Vytvoření složky Assets
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
writeToConsole(format: .header, message: "MC Server Manager")
writeToConsole(format: .systemInfo, message: "Checking is everything is good")
if assetsFolderExists() {
    writeToConsole(format: .systemInfo, message: "All good! Found the Assets folder")
} else {
    writeToConsole(format: .warning, message: "Couldn't find the Assets folder.\(newLine())Would you like to make a new one from scratch?\(newLine())[y] Re-create all folders and files from scratch\(newLine())[n] Exit")
    
    let setUpAnswer = readLine()
    switch setUpAnswer {
    case "y":
        writeToConsole(format: .success, message: "Alright, let's get everything set up")
        setFoldersUp()
    case "n":
        exitProgram(funny: true)
    default:
        writeToConsole(format: .error, message: "You didn't put in the correct answer")
    }
}
// KONEC
