//
//  CategoriesVC.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 2/20/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class CategoriesVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var topicUDLSegmentedControl: UISegmentedControl!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var categoryPV: UIPickerView!
    @IBOutlet weak var UDLPV: UIPickerView!
    @IBOutlet weak var UDLSubPV: UIPickerView!
    @IBOutlet weak var categoriesCV: UICollectionView!
    
    var udlCat = 0
    var udlSub = 0
    var currentCategory = "0"
    var selectedApps: [App] = []
    var appDetails: DetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterByCategory()
        
        categoryPV.dataSource = self
        categoryPV.delegate = self
        UDLPV.dataSource = self
        UDLPV.delegate = self
        UDLSubPV.dataSource = self
        UDLSubPV.delegate = self
        categoriesCV.dataSource = self
        categoriesCV.delegate = self
        
        categoriesCV.reloadData()
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPV {
            return categoryPVData.count
        } else if pickerView == UDLPV {
            return udlPVData.count
        } else {
            return udlSubPVData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPV {
            return categoryPVData[row]
        } else if pickerView == UDLPV {
            return udlPVData[row]
        } else {
            return udlSubPVData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPV {
            // Category Search
            selectedApps = []
            currentCategory = "\(row)"
            filterByCategory()
            categoriesCV.reloadData()
        } else if pickerView == UDLPV {
            selectedApps = []
            udlCat = row
            currentCategory = getUDLCategoryCode()
            filterByCategory()
            categoriesCV.reloadData()
        } else {
            // UDL (Sub) Search
            selectedApps = []
            udlSub = row
            currentCategory = getUDLCategoryCode()
            filterByCategory()
            categoriesCV.reloadData()
        }        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesAppCell", for: indexPath) as? AppCVCell {
            let app = selectedApps[indexPath.row]
            cell.configureCell(app)
            return cell
        } else {
            print("Using default CollectionViewCell")
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedApps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app: App = selectedApps[indexPath.row]
        createDetailsFromNib()
        appDetails.configureApp(app: app)
    }
    
    func filterByCategory() {
        for app in apps {
            var appCat = app.categories
            var catSort = ""
            
            print("\(app.name) - \(appCat)")
            
            if appCat.count == 1 {
                catSort = appCat
                
                if catSort == currentCategory {
                    selectedApps.append(app)
                }
            } else {
                // sort through categories
                for i in 1...appCat.count-1 {
                    let charOne = appCat[appCat.index(appCat.startIndex, offsetBy: i-1)]
                    let charTwo = appCat[appCat.index(appCat.startIndex, offsetBy: i)]
                    
                    if charOne == "," || charOne == " " {
                        if appCat[appCat.index(appCat.startIndex, offsetBy: i)] == appCat[appCat.index(before: appCat.endIndex)] {
                            print("Category: \(charTwo)")
                            // assign to category from charTwo
                            catSort = String(charTwo)
                            
                            if catSort == currentCategory {
                                selectedApps.append(app)
                            }
                        } else {
                            // ignore character and continue
                            print("ignoring this character")
                        }
                    } else if charTwo == "," || charTwo == " " {
                        print("category: \(charOne)")
                        // assign to category from charOne
                        catSort = String(charOne)
                        
                        if catSort == currentCategory {
                            selectedApps.append(app)
                        }
                    }
                    else {
                        print("category: \(charOne)\(charTwo)")
                        // concatenate charOne and charTwo to assign to category
                        catSort = String("\(charOne)\(charTwo)")
                        
                        if catSort == currentCategory {
                            selectedApps.append(app)
                        }
                        //replace character at charTwo to prevent miscategorizing
                        appCat.remove(at: appCat.index(appCat.startIndex, offsetBy: i))
                        appCat.insert(",", at: appCat.index(appCat.startIndex, offsetBy: i))
                    }
                }
            }
        }
    }
    
    func getUDLCategoryCode() -> String {
        var udl: Int!
        
        switch(udlCat) {
        case 1:
            udl = udlSub + 8
        case 2:
            udl = udlSub + 16
        default:
            udl = udlSub
        }
        
        switch(udl) {
        case 0:     //  "Multiple Means of Representation of Information"
            return "a"
        case 1:     //  "Access - Reading"
            return "b"
        case 2:     //  "Access - Written Output"
            return "c"
        case 3:     //  "Access - Executive Functioning"
            return "d"
        case 4:     //  "Access - Physical Disabilities"
            return "e"
        case 5:     //  "Access - Vision"
            return "f"
        case 6:     //  "Access - Hearing"
            return "g"
        case 7:     //  "Access - Early Learning, Cognitive Delays, Communication"
            return "h"
        case 8:     //  "Multiple Means of Expression"
            return "i"
        case 9:     //  "Expression - Reading"
            return "j"
        case 10:    //  "Expression - Written Output"
            return "k"
        case 11:    //  "Expression - Executive Functioning"
            return "l"
        case 12:    //  "Expression - Physical Disabilities"
            return "m"
        case 13:    //  "Expression - Vision"
            return "n"
        case 14:    //  "Expression - Hearing"
            return "o"
        case 15:    //  "Expression - Early Learning, Cognitive Delays, Communication"
            return "p"
        case 16:    //  "Multiple Means of Engagement"
            return "q"
        case 17:    //  "Engagement - Reading"
            return "r"
        case 18:    //  "Engagement - Written Output"
            return "s"
        case 19:    //  "Engagement - Executive Functioning"
            return "t"
        case 20:    //  "Engagement - Physical Disabilities"
            return "u"
        case 21:    //  "Engagement - Vision"
            return "v"
        case 22:    //  "Engagement - Hearing"
            return "w"
        case 23:    //  "Engagement - Early Learning, Cognitive Delays, Communication"
            return "x"
        default:
            return "No Categories Found"
        }
    }
    
    @IBAction func topicUDLSegmentedControlPressed(_ sender: Any) {
        switch topicUDLSegmentedControl.selectedSegmentIndex
        {
        // topics view selected
        case 0:
            categoryLbl.isHidden = false
            categoryPV.isHidden = false
            UDLPV.isHidden = true
            UDLSubPV.isHidden = true
            categoriesCV.reloadData()
        // UDL view selected
        case 1:
            UDLPV.isHidden = false
            UDLSubPV.isHidden = false
            categoryLbl.isHidden = true
            categoryPV.isHidden = true
            categoriesCV.reloadData()
        default:
            break
        }
    }
    
    @IBAction func transparencyBtnPressed(sender: UIButton) {
        appDetails.removeFromSuperview()
        sender.removeFromSuperview()
    }
}
