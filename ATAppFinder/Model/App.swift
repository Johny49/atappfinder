//
//  App.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 2/20/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import Foundation
import UIKit

class App {
    private var _name: String!
    private var _appID: String!
    private var _iTunesLookupUrl: String!
    private var _description: String!
    private var _appIconUrl: String!
    private var _iTunesUrl: String!
    private var _moreInfo: String!
    private var _categories: String!
    private var _appIcon: Data!

    var name: String {
        return _name
    }
    
    var appID: String {
        return _appID
    }
    
    var moreInfo: String {
        return _moreInfo
    }
    
    var categories: String {
        return _categories
    }
    
    var description: String {
        return _description
    }
    
    var appIconUrl: String {
        return _appIconUrl
    }
    
    var iTunesUrl: String {
        return _iTunesUrl
    }
    
    var appIcon: Data {
        return _appIcon
    }
    
    init(name: String, appID: String, moreInfo: String, categories: String, itunesURL: String) {
        self._name = name
        self._appID = appID
        self._moreInfo = moreInfo
        self._categories = categories
        self._iTunesUrl = itunesURL
//        self._iTunesLookupUrl = "\(LOOKUP_URL_BASE)\(_appID!)"
//        print(self._iTunesLookupUrl!)
        
        // download app details
//        let url = URL(string: "https://itunes.apple.com/lookup?id=842788895")!
//        let url = URL(string: "\(self._iTunesLookupUrl)")!
//        print(url)
 /*
        let request = NSMutableURLRequest(url: url)
//        let request = NSMutableURLRequest(url: URL(string: "https://itunes.apple.com/lookup?id=919097064")!)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
            } else {
                if let urlContent = data {
                    
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let appInfo = ((jsonResult["results"] as? NSArray)?[0] as? NSDictionary) {
                            self._description = appInfo["description"] as? String
                            print("description: \(String(describing: self._description!))")

                            self._iTunesUrl = appInfo["trackViewUrl"] as? String
                            print("URL: \(String(describing: self._iTunesUrl!))")
                            
                            self._appIconUrl = appInfo["artworkUrl100"] as? String
                            print("appIcon:\(String(describing: self._appIconUrl))")
                            
                            self._appIcon = NSData(contentsOf: URL(string: self.appIconUrl)!)! as Data
                            
                            DispatchQueue.main.sync(execute: {
                                
                            })
                        }
                        
                    } catch {
                        print("JSON Processing Failed")
                    }
                }
            }
        }
        task.resume()
 */
        
    }
}
