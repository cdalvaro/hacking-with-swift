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
    private let shoppingCellIdentifier = "ShoppingCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addNewShoppingItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                           target: self,
                                                           action: #selector(eraseList))
        
        // TODO: Load previous items from preferences
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shoppingCellIdentifier, for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
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
        shoppingList.insert(item, at: 0)
        
        // TODO: Save item into preferences
        
        // This is an optimization in order to not reload the whole tableview
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc private func eraseList() {
        let ac = UIAlertController(title: "Remove all items",
                                   message: "Are you sure you want to remove all items in the list?",
                                   preferredStyle: .alert)
        
        let removeAction = UIAlertAction(title: "Yes, remove them", style: .destructive) {
            [weak self] _ in
            self?.shoppingList.removeAll()
            self?.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(removeAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
}
