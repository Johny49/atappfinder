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

class BrowseVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var browseCollection: UICollectionView!
    
    var ref: DatabaseReference! // define reference to Firebase Database
    var appData: NSDictionary!
    
    var appDetails: DetailsView!
    var filteredApps = [App]()
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Database.database().isPersistenceEnabled = true
        ref = Database.database().reference()
        
        ref.child("Apps").observeSingleEvent(of: .value, with: { (snapshot) in
            self.appData = snapshot.value as? NSDictionary
            // process app data
            self.parseAppData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        browseCollection.dataSource = self
        browseCollection.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        browseCollection.reloadData()
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
            browseCollection.reloadData()
       }
        print(apps.count)
    }
    
    func createDetailsFromNib() {
        appDetails = Bundle.main.loadNibNamed("Details", owner: self, options: nil)![0] as? DetailsView
        appDetails.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        self.view.addSubview(appDetails)
        createNewTransparencyButton()
    }
    
    func createNewTransparencyButton() {
        let transparencyButton = UIButton(frame: super.view.bounds)
        transparencyButton.backgroundColor = UIColor.clear
        view.insertSubview(transparencyButton, belowSubview: appDetails)
        transparencyButton.addTarget(self, action: #selector(transparencyBtnPressed), for: .touchUpInside)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrowseAppCell", for: indexPath) as? AppCVCell {
            let app: App!
            
            if inSearchMode {
                app = filteredApps[indexPath.row]
            } else {
                app = apps[indexPath.row]
            }
            cell.configureCell(app)
            return cell
        } else {
            print("Using default CollectionViewCell")
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredApps.count
        } else {
            return apps.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if inSearchMode {
            let app = filteredApps[indexPath.row]
            view.endEditing(true)
            createDetailsFromNib()
            appDetails.configureApp(app: app)
        } else {
            let app: App = apps[indexPath.row]
            view.endEditing(true)
            createDetailsFromNib()
            appDetails.configureApp(app: app)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            browseCollection.reloadData()
        } else {
            inSearchMode = true
//            let lower = searchBar.text!.lowercased()
            let search = searchBar.text!
            filteredApps = apps.filter({$0.name.range(of: search) != nil})
            
            browseCollection.reloadData()
        }
    }
    
    @IBAction func transparencyBtnPressed(sender: UIButton) {
        appDetails.removeFromSuperview()
        sender.removeFromSuperview()
    }
}

