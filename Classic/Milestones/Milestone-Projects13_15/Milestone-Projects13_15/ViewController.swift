//
//  ViewController.swift
//  Milestone-Projects13_15
//
//  Created by Carlos David on 16/08/2020.
//

import UIKit

class ViewController: UITableViewController {
    
    var year = 2018
    var countries = [Country]()
    
    let formatter = NumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        formatter.numberStyle = .decimal
        
        title = "World Population in \(year)"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Rights",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(showDataSource))
        
        if let countries = fetchData(year: year) {
            self.countries = countries
            tableView.reloadData()
        } else {
            showError()
        }
    }

    func fetchData(country: String? = nil, year: Int? = nil) -> [Country]? {
        
        let urlAPI = "https://data.opendatasoft.com/api/records/1.0/search/?dataset=world-population%40kapsarc"
        let apiGeneralOptions = "lang=EN&timezone=UTC&facet=year&facet=country_name&rows=300"
        var urlString = [urlAPI, apiGeneralOptions].joined(separator: "&")
        
        var filters = [String]()
        if let country = country?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            filters.append("refine.country_name=\(country)")
        }
        
        if let year = year {
            filters.append("refine.year=\(year)")
        }
        
        if !filters.isEmpty {
            urlString.append("&\(filters.joined(separator: "&"))")
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                return parse(json: data)
            }
        }
        
        return nil
    }
    
    func parse(json: Data) -> [Country]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let jsonData = try? decoder.decode(Records.self, from: json) {
            return jsonData.records.map({ $0.fields })
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.countryName
        cell.detailTextLabel?.text = formatter.string(for: country.value)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row].countryName
        let vc = DetailViewController()
        vc.country = country
        vc.populations = fetchData(country: country)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showDataSource() {
        let ac = UIAlertController(title: "Data source",
                                   message: "Data is recovered from data.opendatasoft.com API",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error",
                                   message: "There was a problem loading the feed; please check your connection and try again.",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

