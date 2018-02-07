//
//  DataStruct.swift
//  JSONCountries
//
//  Created by Zaur Giyasov on 07/02/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

import Foundation

class Country {
    var country: String
    var capital: String
    
    init(country: String, capital: String) {
        self.country = country
        self.capital = capital
    }
}
