//
//  ViewController.swift
//  Coutries and Cities
//
//  Created by Igor Zhukov on 4/26/17.
//  Copyright © 2017 Igor Zhukov. All rights reserved.
//

import UIKit
import CoreData

class CitiesController: UITableViewController {
    
    
    var countryName = ""
    var countryCities = ""
    private var arrayOfCities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(countryName)
        print(countryCities)
        createCitiesListForTableView(fromString: countryCities)
        // TODO:
        
        

    }
    
    private func createCitiesListForTableView(fromString: String) {
        // MARK: - remove first characters "["
        countryCities.remove(at: countryCities.startIndex)
        print(countryCities)
        
        
        // MARK: - remove last characters "]"
        countryCities = String(countryCities.characters.dropLast())
        print(countryCities)
        
        
        // MARK: - create array
        arrayOfCities = countryCities.components(separatedBy: ", ")
        for city in arrayOfCities {
            print(city)
        }
    }
    
       
   
    
    
    
    // MARK: - TableView configuring
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath)
        
      
        
        return cell
    }
    
}



