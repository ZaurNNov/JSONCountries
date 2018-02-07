//
//  ViewController.swift
//  JSONCountries
//
//  Created by Zaur Giyasov on 07/02/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var fetchedCountry = [Country]()
    let cellIdentifier = "cell"

    @IBOutlet weak var countryTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryTableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        parseData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = fetchedCountry[indexPath.row].country
        cell.detailTextLabel?.text = fetchedCountry[indexPath.row].capital
        
        return cell
    }
    
    func parseData()
    {
        self.fetchedCountry = []
        
        let urlString = "https://restcountries.eu/rest/v2/all"
        guard let url = URL(string: urlString) else {
            print("*** Can't create URL!")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            do {
                let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
                
                for eachCountrys in fetchedData {
                    let eachCountry = eachCountrys as! [String: Any]
                    let country = eachCountry["name"] as! String
                    let capital = eachCountry["capital"] as! String
                    
                    self.fetchedCountry.append(Country(country: country, capital: capital))
                }
                
                print(self.fetchedCountry.debugDescription)
                self.countryTableView.reloadData()
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    



}

