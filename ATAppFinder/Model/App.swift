//
//  App.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 2/20/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

let imageCache = AutoPurgingImageCache()
let downloader = ImageDownloader()

class App {
    private var _name: String!
    private var _appID: String!
    private var _description: String!
    private var _appIconUrl: String = ""
    private var _iTunesUrl: String!
    private var _moreInfo: String!
    private var _categories: String!
//    private var _appIcon: Data!

    var name: String {
        return _name!
    }
    
    var appID: String {
        return _appID!
    }
    
    var moreInfo: String {
        return _moreInfo!
    }
    
    var categories: String {
        return _categories!
    }
    
    var description: String {
        return _description!
    }
    
    var appIconUrl: String {
        return _appIconUrl
    }
    
    var iTunesUrl: String {
        return _iTunesUrl!
    }
    
    init(name: String, appID: String, moreInfo: String, categories: String, itunesURL: String) {
        self._name = name
        self._appID = appID
        self._moreInfo = moreInfo
        self._categories = categories
        self._iTunesUrl = itunesURL

        // download app details
        let url = URL(string: "\(LOOKUP_URL_BASE)\(self._appID!)")!
//        print(url)

        Alamofire.request(url, method: .get) .responseJSON { response in
            let result = response.result
            print(self._name)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if dict["resultCount"] as! Int != 0 {
                    print("resultsCount = \(dict["resultCount"])")
                    if let appInfo = ((dict["results"] as? NSArray)?[0] as? NSDictionary) {
                        
                        if let description = appInfo["description"] {
                            self._description = description as? String
                        }
                        if let iconURL = appInfo["artworkUrl100"] {
                            self._appIconUrl = (iconURL as? String)!                        }
                    }
                }  else {
                        print("1.unable to download info for \(self._name)")
                        self._appIconUrl = ""
                        self._description = "This app is currently unavailable"
                        self._iTunesUrl = ""
                        self._categories = ""
                        self._moreInfo = ""
                }
            }
            self.downloadAppIcon()
        }
    }
    
    func downloadAppIcon() {
        if _appIconUrl != "" {
            if imageCache.image(withIdentifier: self.name) == nil {
                // Download app Icon:
                let urlRequest = URLRequest(url: URL(string: self.appIconUrl)!)
                
                downloader.download(urlRequest) { response in
                    print(response.request)
                    print(response.response)
                    debugPrint(response.result)
                    
                    // Download image.
                    if let image = response.result.value {
                        // Add to Cache.
                        imageCache.add(image, for: urlRequest, withIdentifier: "\(self.name)")
                        print(image)
                    }
                }
            }
        }
    }
}
