//
//  ViewController.swift
//  Coutries and Cities
//
//  Created by Igor Zhukov on 4/26/17.
//  Copyright © 2017 Igor Zhukov. All rights reserved.
//

import UIKit
import CoreData

class CitiesController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var selectCountryTextField: UITextField!
    var container: NSPersistentContainer!
    let pickerView = UIPickerView()
   
    
    var userDidSelectCountry = false
    var selectedCountry: String?
    
    
    var countries = [Country]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        selectCountryTextField.inputView = pickerView
        
        // MARK: - create persistent container
        container = NSPersistentContainer(name: "CoutriesAndCities")
        container.loadPersistentStores { storeDescription, error in
            // instructs CoreData to allow updates to objects if object update is available
            // self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        
        performSelector(inBackground: #selector(fetchCountries), with: nil)
        loadSavedData()
        

    }
    
    
    
    // MARK: - save changes if a change is available
    // saveContext() should be called whenever changes are made that should be saved to disk
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    func fetchCountries() {
        if let data = try? Data(contentsOf: URL(string: "https://raw.githubusercontent.com/David-Haim/CountriesToCitiesJSON/master/countriesToCities.json")!) {
            let jsonCountries = JSON(data: data)
            // convert json to dictionary
            let jsonCountriesDictionary = jsonCountries.dictionaryValue
            
            // let keysArray = Array(jsonCountriesDictionary.keys)
         
            print("Received \(jsonCountriesDictionary.count) new countries.")
            
            DispatchQueue.main.async { [unowned self] in
                for jsonCountry in jsonCountriesDictionary {
                    let country = Country(context: self.container.viewContext)
                    self.configure(country: country, usingJSON: jsonCountry)
                }
                // saving to CoreData conifgured object of CoreData entity type
                self.saveContext()
                self.loadSavedData()
            }
        }
    }
    
    // MARK: - json parsing and assigning to object of CoreData entity type
    func configure(country: Country, usingJSON json: (key: String, value: JSON)) {
        country.countryName = json.key
        // ??? TODO: - do I need arrayValue ???
        country.listOfCities = String(describing: json.value.arrayValue)
    }
    
  
    func loadSavedData() {
        let request = Country.countryFetchRequest()
        let sort = NSSortDescriptor(key: "countryName", ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            countries = try container.viewContext.fetch(request)
            print("Fetched \(countries.count) countries")
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
   
    
    
    // MARK: - PickerView configuring
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let country = countries[row]
        
        return country.countryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let country = countries[row]
        selectedCountry = country.countryName
        selectCountryTextField.text = selectedCountry
    }

    
    
    
    // MARK: - TableView configuring
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath)
        
        let country = countries[indexPath.row]
        cell.textLabel!.text = country.countryName
        
        return cell
    }
}



