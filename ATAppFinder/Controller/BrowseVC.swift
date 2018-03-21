//
//  FirstViewController.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 2/20/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import UIKit
import Firebase

class BrowseVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var browseCollection: UICollectionView!
    
    var ref: DatabaseReference! // define reference to Firebase Database
    var appData: NSDictionary!
    var apps = [App]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize database & create reference
        ref = Database.database().reference()
        
        // Get app data
        ref.child("Apps").observeSingleEvent(of: .value, with: { (snapshot) in
            self.appData = snapshot.value as? NSDictionary
            // process app data
            self.parseAppData()
            
            self.browseCollection.reloadData()
            
            self.filterByCategory()

        }) { (error) in
            print(error.localizedDescription)
        }
        
        browseCollection.dataSource = self
        browseCollection.delegate = self
    }
    
    func parseAppData() {
        for key in appData.allKeys {
            let appID = key
            guard let appKeys = appData[key] as? [String: Any],
            let appName = appKeys["App_Name"],
            let categories = appKeys["Categories"],
            let moreInfo = appKeys["Additional_Info"],
            let itunesURL = appKeys["iTunes_URL"] else {
                print("Unable to parse App Data")
                return
            }
            
            let app = App(name: appName as! String, appID: appID as! String, moreInfo: moreInfo as! String, categories: categories as! String, itunesURL: itunesURL as! String)
            
                apps.append(app)
//            else {
//                    print("Append App Unsuccessful")
//                    return
//            }

//            print("Entry: \(appName), \(appID), \(categories), \(moreInfo), \(itunesURL)")
        }
        print(apps.count)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrowseAppCell", for: indexPath) as? AppCVCell {
            let app = apps[indexPath.row]

            cell.configureCell(app)
//            print("Configuring cell for \(app.name)")
            return cell
        } else {
            print("Using default CollectionViewCell")
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = apps[indexPath.row]
        print(app.name)
        // segue to details vc
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Temp(move to CategoriesVC)
    func filterByCategory() {
        for app in apps {
            var appCat = app.categories
            var catSort = ""
            
            print("\(app.name) - \(appCat)")
            
            // sort through categories
            for i in 1...appCat.count-1 {
                let charOne = appCat[appCat.index(appCat.startIndex, offsetBy: i-1)]
                let charTwo = appCat[appCat.index(appCat.startIndex, offsetBy: i)]
                
                if charOne == "," || charOne == " " {
                    if appCat[appCat.index(appCat.startIndex, offsetBy: i)] == appCat[appCat.index(before: appCat.endIndex)] {
                        print("Category: \(charTwo)")
                        // assign to category from charTwo
                        catSort = String(charTwo)
                        appendToCategory(app: app, category: catSort)
                    } else {
                        // ignore character and continue
                        print("ignoring this character")
                    }
                } else if charTwo == "," || charTwo == " " {
                    print("category: \(charOne)")
                    // assign to category from charOne
                    catSort = String(charOne)
                    appendToCategory(app: app, category: catSort)
                }
                else {
                    print("category: \(charOne)\(charTwo)")
                    // concatenate charOne and charTwo to assign to category
                    catSort = String("\(charOne)\(charTwo)")
                    appendToCategory(app: app, category: catSort)
                    
                    //replace character at charTwo to prevent miscategorizing
                    appCat.remove(at: appCat.index(appCat.startIndex, offsetBy: i))
                    appCat.insert(",", at: appCat.index(appCat.startIndex, offsetBy: i))
                }
            }
        }
    }
 
    func appendToCategory(app: App, category: String) {
        // append to correct category array
        switch(category) {
        case "0":
            print("Text Recognition/OCR Apps")
        case "1":
            print("Visual Schedule/Planner/Task Management Apps")
        case "2":
            print("Timer Apps")
        case "3":
            print("Communication Apps")
        case "4":
            print("Keyboard Apps")
        case "5":
            print("Writing Apps")
        case "6":
            print("Edutainment Apps")
        case "7":
            print("Reading Apps")
        case "8":
            print("Apps for Creative Expression")
        case "9":
            print("Primary Art Apps")
        case "10":
            print("Mindfulness-Relaxation-Sensory Apps")
        case "11":
            print("Science Apps")
        case "12":
            print("Music Apps")
        case "13":
            print("Social Studies Apps")
        case "14":
            print("Early Learning")
        case "15":
            print("Other Math Apps")
        case "16":
            print("Hearing Apps")
        case "17":
            print("Vision Apps")
        case "18":
            print("ELA Apps")
        case "19":
            print("VASD V-Math Apps")
        case "a":
            print("Multiple Means of Representation of Information")
        case "b":
            print("Access - Reading")
        case "c":
            print("Access - Written Output")
        case "d":
            print("Access - Executive Functioning")
        case "e":
            print("Access - Physical Disabilities")
        case "f":
            print("Access - Vision")
        case "g":
            print("Access - Hearing")
        case "h":
            print("Access - Early Learning, Cognitive Delays, Communication")
        case "i":
            print("Multiple Means of Expression")
        case "j":
            print("Expression - Reading")
        case "k":
            print("Expression - Written Output")
        case "l":
            print("Expression - Executive Functioning")
        case "m":
            print("Expression - Physical Disabilities")
        case "n":
            print("Expression - Vision")
        case "o":
            print("Expression - Hearing")
        case "p":
            print("Expression - Early Learning, Cognitive Delays, Communication")
        case "q":
            print("Multiple Means of Engagement")
        case "r":
            print("Engagement - Reading")
        case "s":
            print("Engagement - Written Output")
        case "t":
            print("Engagement - Executive Functioning")
        case "u":
            print("Engagement - Physical Disabilities")
        case "v":
            print("Engagement - Vision")
        case "w":
            print("Engagement - Hearing")
        case "x":
            print("Engagement - Early Learning, Cognitive Delays, Communication")
        default:
            print("No Categories Found")
        }
    }
    
    func filterCategories() {
        
    }
}

