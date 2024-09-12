//
//  Model.swift
//  fileManager
//
//  Created by Айгерим on 12.09.2024.
//

import Foundation


final class Model {
    
    var path: String
    
    var title: String {
        return NSString(string: path).lastPathComponent
    }
    
    var items: [String] {
        return (try? FileManager.default.contentsOfDirectory(atPath: path)) ?? []
    }
    
    init(path: String) {
        self.path = path
    }
    
    func addItem(with title: String, content: String) {
        let url = URL(filePath: path + "/" + title + ".txt")
        try? content.data(using: .utf8)?.write(to: url)
    }
    
    func addFolder(title: String) {
        try? FileManager.default.createDirectory(atPath: path + "/" + title, withIntermediateDirectories: true)
    }
    
    func deleteItem(index: Int) {
        let pathForDelete = path + "/" + items[index]
        try? FileManager.default.removeItem(atPath: pathForDelete)
    }
    
    func isPathForItemIsFolder(index: Int) -> Bool {
        var objCBool: ObjCBool = .init(false)
        FileManager.default.fileExists(atPath: path + "/" + items[index], isDirectory: &objCBool)
        return objCBool.boolValue
    }
    
}
