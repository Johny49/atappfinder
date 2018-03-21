//
//  CategoriesVC.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 2/20/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var topicUDLSegmentedControl: UISegmentedControl!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var categoryPV: UIPickerView!
    @IBOutlet weak var UDLPV: UIPickerView!
    @IBOutlet weak var UDLSubPV: UIPickerView!
    
    var filteredApps: [App] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryPV.dataSource = self
        self.categoryPV.delegate = self
        self.UDLPV.dataSource = self
        self.UDLPV.delegate = self
        self.UDLSubPV.dataSource = self
        self.UDLSubPV.delegate = self
        
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
            return categoryPVData[row]
        } else if pickerView == UDLPV {
            return udlPVData[row]
        } else {
            return udlSubPVData[row]
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
    
    func filterByCategory() {
        
        
        // sort
        //        let filterCat = ""
        //        filteredApps = app.filter({$0.name.range(of: filterCat) != nil})

    }
}
