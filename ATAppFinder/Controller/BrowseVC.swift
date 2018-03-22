//
//  FirstViewController.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 2/20/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import UIKit
import Firebase

var apps = [App]()

class BrowseVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var browseCollection: UICollectionView!
    
    var ref: DatabaseReference! // define reference to Firebase Database
    var appData: NSDictionary!
    
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
            
//            self.filterByCategory()

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
    
}

