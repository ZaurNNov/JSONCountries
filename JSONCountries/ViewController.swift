//
//  ViewController.swift
//  JSONCountries
//
//  Created by Zaur Giyasov on 07/02/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        parseData()
    }
    
    func parseData()
    {
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
            
            if (error != nil) {
                print(error.debugDescription)
            } else {
                
                do {
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
                    print(fetchedData.description)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    



}

