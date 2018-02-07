//
//  ViewController.swift
//  JSONCountries
//
//  Created by Zaur Giyasov on 07/02/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var fetchedCountry = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.parseData()
    }
    
    func parseData()
    {
        fetchedCountry = []
        
        let urlString = "https://restcountries.eu/rest/v1/all"
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
                
                print(self.fetchedCountry)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    



}

