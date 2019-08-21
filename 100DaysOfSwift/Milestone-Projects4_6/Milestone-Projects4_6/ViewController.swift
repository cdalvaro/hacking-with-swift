//
//  ViewController.swift
//  Milestone-Projects4_6
//
//  Created by Carlos David on 17/08/2019.
//  Copyright © 2019 cdalvaro. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private var shoppingList = [String]()
    private let shoppingListFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("ShoppingList.plist")
    private let shoppingCellIdentifier = "ShoppingCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addNewShoppingItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                                           target: self,
                                                           action: #selector(eraseList))
        
        // Load previous items from preferences
        loadShoppingList()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shoppingCellIdentifier, for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    private func loadShoppingList() {
        if FileManager.default.fileExists(atPath: shoppingListFile.path) {
            if let data = try? Data(contentsOf: shoppingListFile) {
                let decoder = PropertyListDecoder()
                do {
                    shoppingList = try decoder.decode([String].self, from: data)
                } catch {
                    print("Error decoding shopping list from file. Error: \(error)")
                }
            }
        }
    }
    
    private func saveShoppingList() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(shoppingList)
            try data.write(to: shoppingListFile)
        } catch {
            print("Error encoding shopping list into file. Error: \(error)")
        }
    }
    
    @objc private func addNewShoppingItem() {
        let ac = UIAlertController(title: "Add new shopping item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addItemAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] _ in
            if let item = ac?.textFields?[0].text {
                self?.addItem(item)
            }
        }
        
        ac.addAction(addItemAction)
        present(ac, animated: true)
    }
    
    private func addItem(_ item: String) {
        // Save item into preferences
        shoppingList.insert(item, at: 0)
        saveShoppingList()
        
        // This is an optimization in order to not reload the whole tableview
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .fade)
    }
    
    @objc private func eraseList() {
        let ac = UIAlertController(title: "Remove all items",
                                   message: "Are you sure you want to remove all items in the list?",
                                   preferredStyle: .alert)
        
        let removeAction = UIAlertAction(title: "Yes, remove them", style: .destructive) {
            [weak self] _ in
            self?.deleteAllItems()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(removeAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
    
    private func deleteAllItems() {
        shoppingList.removeAll()
        saveShoppingList()
        tableView.reloadData()
    }
}
