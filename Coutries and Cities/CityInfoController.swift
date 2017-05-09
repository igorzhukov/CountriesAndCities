//
//  CityInfoController.swift
//  Coutries and Cities
//
//  Created by Igor Zhukov on 4/30/17.
//  Copyright © 2017 Igor Zhukov. All rights reserved.
//

import UIKit
import WebKit

class CityInfoController: UIViewController {
    
    var webView: WKWebView!
    var selectedCityName: String = ""
    
    
    var cityInfo: String?
    var url: URL?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createURL()
        performSelector(inBackground: #selector(fetchCityInfo), with: nil)
        
    }
    
    
    
    func createURL() {
        url = URL(string:"http://api.geonames.org/wikipediaSearchJSON?q=\(selectedCityName)&maxRows=10&username=djangofreeqa")
    }
    
    
    
    func fetchCityInfo() {
        if let data = try? Data(contentsOf: url!) {
            let json = JSON(data: data)
            // convert json to json array
            let jsonArray = json["geonames"].arrayValue
            // assign value to city info depending on array filling
            if !(jsonArray.isEmpty) {
                cityInfo = jsonArray[0]["summary"].stringValue
            } else {
                cityInfo = "Sorry, but we don't find any information about your city, try any another city"
            }
            DispatchQueue.main.async { [unowned self] in
                self.configureHTML()
            }
        }
    }
    
    
    
    func configureHTML() {
        guard cityInfo != nil else { return }
        
        if let body = cityInfo {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
            html += "<style> body { font-size: 180%; } </style>"
            html += "</head>"
            html += "<body>"
            html += body
            html += "</body>"
            html += "</html>"
            webView.loadHTMLString(html, baseURL: nil)
        }
        
    }
    
    
}
