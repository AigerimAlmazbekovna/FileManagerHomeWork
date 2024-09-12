//
//  TextPicker.swift
//  fileManager
//
//  Created by Айгерим on 12.09.2024.
//

import Foundation
import UIKit

final class TextPicker {
    
    
    
    static func showMessage(in viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertOkAction)
        viewController.present(alert, animated: true)
    }
    
    static func showAddFolder(in viewController: UIViewController, completion: @escaping ((_ text: String) -> Void)) {
        let alert = UIAlertController(title: "You create folder", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter title"
        }
        let alertOkAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let text = alert.textFields?[0].text {
                completion(text)
            }
        }
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(alertOkAction)
        alert.addAction(alertCancelAction)
        viewController.present(alert, animated: true)
    }
    
    static func showCreateItem(in viewController: UIViewController, completion: @escaping ((_ file: (String, String)) -> Void)) {
        let alert = UIAlertController(title: "You create Item", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter title"
        }
        alert.addTextField { textField in
            textField.placeholder = "Enter content"
        }
        let alertOkAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let name = alert.textFields?[0].text,
               let content = alert.textFields?[1].text {
                completion((name, content))
            }
        }
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .default)

        alert.addAction(alertOkAction)
        alert.addAction(alertCancelAction)
        viewController.present(alert, animated: true)
    }
    
}
