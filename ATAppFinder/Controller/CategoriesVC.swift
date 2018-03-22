//
//  CategoriesVC.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 2/20/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var topicUDLSegmentedControl: UISegmentedControl!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var categoryPV: UIPickerView!
    @IBOutlet weak var UDLPV: UIPickerView!
    @IBOutlet weak var UDLSubPV: UIPickerView!
    @IBOutlet weak var categoriesCV: UICollectionView!
    
    //Topic Sort Arrays
    var category0: [App] = []
    var category1: [App] = []
    var category2: [App] = []
    var category3: [App] = []
    var category4: [App] = []
    var category5: [App] = []
    var category6: [App] = []
    var category7: [App] = []
    var category8: [App] = []
    var category9: [App] = []
    var category10: [App] = []
    var category11: [App] = []
    var category12: [App] = []
    var category13: [App] = []
    var category14: [App] = []
    var category15: [App] = []
    var category16: [App] = []
    var category17: [App] = []
    var category18: [App] = []
    var category19: [App] = []
    // UDL Sort Arrays
    var categorya: [App] = []
    var categoryb: [App] = []
    var categoryc: [App] = []
    var categoryd: [App] = []
    var categorye: [App] = []
    var categoryf: [App] = []
    var categoryg: [App] = []
    var categoryh: [App] = []
    var categoryi: [App] = []
    var categoryj: [App] = []
    var categoryk: [App] = []
    var categoryl: [App] = []
    var categorym: [App] = []
    var categoryn: [App] = []
    var categoryo: [App] = []
    var categoryp: [App] = []
    var categoryq: [App] = []
    var categoryr: [App] = []
    var categorys: [App] = []
    var categoryt: [App] = []
    var categoryu: [App] = []
    var categoryv: [App] = []
    var categoryw: [App] = []
    var categoryx: [App] = []
    
    var currentCategory = "0"
    var selectedApps: [App] = []
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            currentCategory = categoryPVData[row]
            print(currentCategory)
            return categoryPVData[row]
        } else if pickerView == UDLPV {
            return udlPVData[row]
        } else {
//            currentCategory = udlPVData[row]
//            print(currentCategory)
            return udlSubPVData[row]
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
//                appendToCategory(app: app, category: catSort)
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
//                            appendToCategory(app: app, category: catSort)
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
//                        appendToCategory(app: app, category: catSort)
                    }
                    else {
                        print("category: \(charOne)\(charTwo)")
                        // concatenate charOne and charTwo to assign to category
                        catSort = String("\(charOne)\(charTwo)")
                        
                        if catSort == currentCategory {
                            selectedApps.append(app)
                        }
//                        appendToCategory(app: app, category: catSort)
                        
                        //replace character at charTwo to prevent miscategorizing
                        appCat.remove(at: appCat.index(appCat.startIndex, offsetBy: i))
                        appCat.insert(",", at: appCat.index(appCat.startIndex, offsetBy: i))
                    }
                }
            }
        }
    }
    
    func appendToCategory(app: App, category: String) {
        // append to correct category array
        switch(category) {
        case "0":
            print("Text Recognition/OCR Apps")
            category0.append(app)
        case "1":
            print("Visual Schedule/Planner/Task Management Apps")
            category1.append(app)
        case "2":
            print("Timer Apps")
            category2.append(app)
        case "3":
            print("Communication Apps")
            category3.append(app)
        case "4":
            print("Keyboard Apps")
            category4.append(app)
        case "5":
            print("Writing Apps")
            category5.append(app)
        case "6":
            print("Edutainment Apps")
            category6.append(app)
        case "7":
            print("Reading Apps")
            category7.append(app)
        case "8":
            print("Apps for Creative Expression")
            category8.append(app)
        case "9":
            print("Primary Art Apps")
            category9.append(app)
        case "10":
            print("Mindfulness-Relaxation-Sensory Apps")
            category10.append(app)
        case "11":
            print("Science Apps")
            category11.append(app)
        case "12":
            print("Music Apps")
            category12.append(app)
        case "13":
            print("Social Studies Apps")
            category13.append(app)
        case "14":
            print("Early Learning")
            category14.append(app)
        case "15":
            print("Other Math Apps")
            category15.append(app)
        case "16":
            print("Hearing Apps")
            category16.append(app)
        case "17":
            print("Vision Apps")
            category17.append(app)
        case "18":
            print("ELA Apps")
            category18.append(app)
        case "19":
            print("VASD V-Math Apps")
            category19.append(app)
        case "a":
            print("Multiple Means of Representation of Information")
            categorya.append(app)
        case "b":
            print("Access - Reading")
            categoryb.append(app)
        case "c":
            print("Access - Written Output")
            categoryc.append(app)
        case "d":
            print("Access - Executive Functioning")
            categoryd.append(app)
        case "e":
            print("Access - Physical Disabilities")
            categorye.append(app)
        case "f":
            print("Access - Vision")
            categoryf.append(app)
        case "g":
            print("Access - Hearing")
            categoryg.append(app)
        case "h":
            print("Access - Early Learning, Cognitive Delays, Communication")
            categoryh.append(app)
        case "i":
            print("Multiple Means of Expression")
            categoryi.append(app)
        case "j":
            print("Expression - Reading")
            categoryj.append(app)
        case "k":
            print("Expression - Written Output")
            categoryk.append(app)
        case "l":
            print("Expression - Executive Functioning")
            categoryl.append(app)
        case "m":
            print("Expression - Physical Disabilities")
            categorym.append(app)
        case "n":
            print("Expression - Vision")
            categoryn.append(app)
        case "o":
            print("Expression - Hearing")
            categoryo.append(app)
        case "p":
            print("Expression - Early Learning, Cognitive Delays, Communication")
            categoryp.append(app)
        case "q":
            print("Multiple Means of Engagement")
            categoryq.append(app)
        case "r":
            print("Engagement - Reading")
            categoryr.append(app)
        case "s":
            print("Engagement - Written Output")
            categorys.append(app)
        case "t":
            print("Engagement - Executive Functioning")
            categoryt.append(app)
        case "u":
            print("Engagement - Physical Disabilities")
            categoryu.append(app)
        case "v":
            print("Engagement - Vision")
            categoryv.append(app)
        case "w":
            print("Engagement - Hearing")
            categoryw.append(app)
        case "x":
            print("Engagement - Early Learning, Cognitive Delays, Communication")
            categoryx.append(app)
        default:
            print("No Categories Found")
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
        // UDL view selected
        case 1:
            UDLPV.isHidden = false
            UDLSubPV.isHidden = false
            categoryLbl.isHidden = true
            categoryPV.isHidden = true
        default:
            break
        }
    }
}
