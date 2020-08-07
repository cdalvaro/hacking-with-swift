//
//  ViewController.swift
//  Project7
//
//  Created by Carlos David on 20/08/2019.
//  Copyright © 2019 cdalvaro. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allPetitions = [Petition]()
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Rights",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(showDataSource))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                           target: self,
                                                           action: #selector(searchPetitions))
        
        loadPetitions()
    }
    
    func loadPetitions() {
        let urlString: String
        switch navigationController?.tabBarItem.tag {
        case 1:
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        default:
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error",
                                   message: "There was a problem loading the feed; please check your connection and try again.",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            allPetitions = jsonPetitions.results
            petitions = allPetitions
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showDataSource() {
        let ac = UIAlertController(title: "Data source",
                                   message: "Data is recovered from We The People API of the Whitehouse",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func searchPetitions() {
        let ac = UIAlertController(title: "Search petitions", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { [weak self, weak ac] _ in
            if let item = ac?.textFields?[0].text {
                self?.filterPetitionsContaining(item)
            }
        }
        
        ac.addAction(searchAction)
        ac.addAction(UIAlertAction(title: "Clear current search", style: .default) { [weak self] _ in
            self?.petitions = self!.allPetitions
            self?.tableView.reloadData()
        })
        
        ac.preferredAction = searchAction
        present(ac, animated: true)
    }
    
    func filterPetitionsContaining(_ word: String) {
        petitions = allPetitions.filter {
            $0.title.localizedCaseInsensitiveContains(word)
                || $0.body.localizedCaseInsensitiveContains(word)
        }
        tableView.reloadData()
    }
}
