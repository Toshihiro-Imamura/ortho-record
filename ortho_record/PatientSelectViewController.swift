//
//  PatientSelectViewController.swift
//  ortho_record
//
//  Created by 今村俊博 on 2020/02/14.
//  Copyright © 2020 toshihiro.imamura. All rights reserved.
//

import UIKit
import RealmSwift

class PatientSelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource ,UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating  {
    
    @IBOutlet weak var clinicTextField: UITextField!
    
    @IBOutlet weak var patientSelectTableView: UITableView!
    
    let realm = try! Realm()
    var patientData: PatientData! = PatientData()
    var patientDataResults = try! Realm().objects(PatientData.self).sorted(byKeyPath:"clinicID", ascending:true)
    var id: Int = 0
    
    
    var clinicPickerView: UIPickerView = UIPickerView()
    var clinicList: [String] = try! Realm().objects(PatientData.self).value(forKey: "clinic") as! [String]
    var uniqueClinicList: [String] = []
    
    var searchContorller = UISearchController(searchResultsController: nil)
    var searchResults: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        patientSelectTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //患者登録がなければ自動的に患者登録画面に移動
        if realm.objects(PatientData.self).count == 0 {
            let patientAddViewController = self.storyboard?.instantiateViewController(withIdentifier: "PatientAdd") as! PatientAddViewController
            navigationController?.pushViewController(patientAddViewController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.patientSelectTableView.delegate = self
        self.patientSelectTableView.dataSource = self
        
        //病院名PickerViewの設定
        self.clinicPickerView.delegate = self
        self.clinicPickerView.dataSource = self
        self.clinicTextField!.inputView = clinicPickerView
        let pickerToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        let pickerSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        let pickerDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pickerViewDone))
        pickerToolBar.setItems([pickerSpaceItem, pickerDoneItem], animated: true)
        self.clinicTextField.inputAccessoryView = pickerToolBar
        let orderedSet = NSOrderedSet(array: clinicList)
        uniqueClinicList = orderedSet.array as! [String]
        
        //TableViewのSearchBarの設定
        patientSelectTableView.tableHeaderView = searchContorller.searchBar
        searchContorller.searchBar.inputAccessoryView = pickerToolBar
        searchContorller.searchResultsUpdater = self
    }
    
    
    //tableviewの設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientDataResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = patientSelectTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = "\(patientDataResults[indexPath.row].clinicID)  :  \(patientDataResults[indexPath.row].familyName) \(patientDataResults[indexPath.row].firstName)"
        return cell
    }
    
    //検索バーの設定
    func updateSearchResults(for searchController: UISearchController) {
        patientDataResults = realm.objects(PatientData.self).filter("clinic == %@", clinicTextField.text!).filter("clinicID CONTAINS %@", searchController.searchBar.text!).filter("familyNameFurigana CONTAINS %@", searchController.searchBar.text!).filter("firstNameFurigana CONTAINS %@", searchController.searchBar.text!).filter("familyName CONTAINS %@", searchController.searchBar.text!).filter("firstName CONTAINS %@", searchController.searchBar.text!)
        self.patientSelectTableView.reloadData()
    }
    
    
    //病院名をpickerviewで選ぶ
    @IBAction func clinicTextFieldEditting(sender: UITextField) {
    }
    @objc func pickerViewDone() {
        clinicTextField.endEditing(true)
        clinicTextField.text! = "\(uniqueClinicList[clinicPickerView.selectedRow(inComponent: 0)])"
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uniqueClinicList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uniqueClinicList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        clinicTextField.text! = uniqueClinicList[row]
    }
    
    //値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PatientSelect"{
            let tabBarController: TabBarController = segue.destination as! TabBarController
            tabBarController.id = self.patientData.id
        }
    }
}
