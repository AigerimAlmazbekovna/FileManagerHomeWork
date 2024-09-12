//
//  ViewController.swift
//  fileManager
//
//  Created by Айгерим on 12.09.2024.
//

import UIKit

class ViewController: UIViewController {

    var model = Model(path: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = model.title
        tableView.dataSource = self
        tableView.delegate = self
        let createFolderButton = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(didTapCreateFolder))
        let createItemButton = UIBarButtonItem(title: "file", style: .plain, target: self, action: #selector(didTapCreateItem))
        navigationItem.rightBarButtonItems = [createFolderButton, createItemButton]
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        ])
    }
    
    @objc private func didTapCreateFolder() {
        TextPicker.showAddFolder(in: self) { [weak self] text in
            self?.model.addFolder(title: text)
            self?.tableView.reloadData()
        }
      
    }
    
    @objc private func didTapCreateItem() {
        TextPicker.showCreateItem(in: self) { [weak self] file in
            self?.model.addItem(with: file.0, content: file.1)
            self?.tableView.reloadData()
        }
       
    }


}

extension ViewController: UITableViewDataSource {
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        config.text = model.items[indexPath.row]
        cell.contentConfiguration = config
        cell.accessoryType = model.isPathForItemIsFolder(index: indexPath.row) ? .disclosureIndicator : .none
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            model.deleteItem(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if model.isPathForItemIsFolder(index: indexPath.row) {
            let vc = ViewController()
            vc.model = Model(path: model.path + "/" + model.items[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let string = try! NSString(contentsOf: URL(filePath: model.path + "/" + model.items[indexPath.row]), encoding: NSUTF8StringEncoding)
            TextPicker.showMessage(in: self, title: model.items[indexPath.row], message: string as String)
        }
    }
    
}

