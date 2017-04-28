//
//  Country+CoreDataProperties.swift
//  Coutries and Cities
//
//  Created by Igor Zhukov on 4/27/17.
//  Copyright © 2017 Igor Zhukov. All rights reserved.
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func countryFetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var countryName: String
    @NSManaged public var listOfCities: String

}
