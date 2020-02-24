//
//  PatientSelectViewController.swift
//  ortho_record
//
//  Created by 今村俊博 on 2020/02/14.
//  Copyright © 2020 toshihiro.imamura. All rights reserved.
//

import UIKit
import RealmSwift

class PatientSelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource ,UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var clinicTextField: UITextField!
    
    @IBOutlet weak var patientSelectTableView: UITableView!
    
    let realm = try! Realm()
    var patientData: PatientData! = PatientData()
    var patientDataResults = try! Realm().objects(PatientData.self).sorted(byKeyPath:"clinicID", ascending:true)
    
    var clinicPickerView: UIPickerView = UIPickerView()
    var clinicList:[String] = ["A,B,C"]
    
    var searchContorller = UISearchController(searchResultsController: nil)
    var searchResults: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        patientSelectTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        print(realm.objects(PatientData.self).count)
        
        if realm.objects(PatientData.self).count == 0 {
            let patientAddViewController = self.storyboard?.instantiateViewController(withIdentifier: "PatientAdd") as! PatientAddViewController
            self.present(patientAddViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(patientData!)
        
        self.patientSelectTableView.delegate = self
        self.patientSelectTableView.dataSource = self
        
        self.clinicPickerView.delegate = self
        self.clinicPickerView.dataSource = self
        self.clinicTextField!.inputView = clinicPickerView
        let pickerToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        let pickerSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        let pickerDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pickerViewDone))
        pickerToolBar.setItems([pickerSpaceItem, pickerDoneItem], animated: true)
        self.clinicTextField.inputAccessoryView = pickerToolBar
        
        
        searchContorller.searchResultsUpdater = self
        
        patientSelectTableView.tableHeaderView = searchContorller.searchBar
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientDataResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = patientSelectTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = "\(patientDataResults[indexPath.row].clinicID)  :  \(patientDataResults[indexPath.row].familyName) \(patientDataResults[indexPath.row].firstName)"
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let predicate = NSPredicate(format: "clinic == %@ && (clinicID OR familyName OR firstName OR familyNameFurigana OR firstNameFurigana == %@", "\(clinicTextField.text!)", "\(searchController.searchBar.text!)")
        patientDataResults = try! Realm().objects(PatientData.self).filter(predicate)
        self.patientSelectTableView.reloadData()
    }
    
    
    
    @IBAction func clinicTextFieldEditting(sender: UITextField) {
    }
    
    @objc func pickerViewDone() {
        clinicTextField.endEditing(true)
        clinicTextField.text! = "\(patientDataResults[clinicPickerView.selectedRow(inComponent: 0)].clinic)"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return patientDataResults.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return patientDataResults[row].clinic
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        clinicTextField.text! = patientDataResults[row].clinic
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
