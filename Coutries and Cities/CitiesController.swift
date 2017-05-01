//
//  ViewController.swift
//  Coutries and Cities
//
//  Created by Igor Zhukov on 4/26/17.
//  Copyright © 2017 Igor Zhukov. All rights reserved.
//

import UIKit


class CitiesController: UITableViewController {
    
    
    var countryCities = ""
    private var arrayOfCities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCitiesListForTableView(fromString: countryCities)
    }
    
    
    private func createCitiesListForTableView(fromString: String) {
        // remove first character "["
        countryCities.remove(at: countryCities.startIndex)
        
        // remove last character "]"
        countryCities = String(countryCities.characters.dropLast())

        // create and sort array
        arrayOfCities = countryCities.components(separatedBy: ", ")
        arrayOfCities.sort()
        
    }
    
       
   
    
    
    
    // MARK: - TableView configuring
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath)
        cell.textLabel?.text = arrayOfCities[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CityInfoController()
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
        let currentCell = tableView.cellForRow(at: indexPath!)!
        vc.selectedCityName =  currentCell.textLabel!.text!
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



