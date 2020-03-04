//
//  PatientAddViewController.swift
//  ortho_record
//
//  Created by 今村俊博 on 2020/02/16.
//  Copyright © 2020 toshihiro.imamura. All rights reserved.
//

import UIKit
import RealmSwift
import SVProgressHUD

class PatientAddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var clinicPatientAddTextField: UITextField!
    @IBOutlet weak var clinicIdPatientAddTextField: UITextField!
    @IBOutlet weak var familyNameFuriganaPatientAddTextField: UITextField!
    @IBOutlet weak var firstNameFuriganaPatientAddTextField: UITextField!
    @IBOutlet weak var familyNamePatientAddTextField: UITextField!
    @IBOutlet weak var firstNamePatientAddTextField: UITextField!
    @IBOutlet weak var birthdayPatientAddTextField: UITextField!
    @IBOutlet weak var sexPatientAddTextField: UITextField!
    
    
    let realm = try! Realm()
    var patientData: PatientData! = PatientData()
    
    var pickerView: UIPickerView = UIPickerView()
    let pickerViewList: [String] = ["男","女"]
    
    var datePicker: UIDatePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsLargeContentViewer = true
        
        let pickerToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        let pickerSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        let pickerDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pickerViewDone))
        pickerToolBar.setItems([pickerSpaceItem, pickerDoneItem], animated: true)
        self.sexPatientAddTextField.inputView = pickerView
        self.sexPatientAddTextField.inputAccessoryView = pickerToolBar
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        let datePickerToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        let datePickerSpacelItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        let datePickerDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDone))
        datePickerToolBar.setItems([datePickerSpacelItem, datePickerDoneItem], animated: true)
        birthdayPatientAddTextField.inputView = datePicker
        birthdayPatientAddTextField.inputAccessoryView = datePickerToolBar
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.clinicPatientAddTextField.text! = ""
        self.clinicIdPatientAddTextField.text! = ""
        self.familyNameFuriganaPatientAddTextField.text! = ""
        self.firstNameFuriganaPatientAddTextField.text! = ""
        self.familyNamePatientAddTextField.text! = ""
        self.firstNamePatientAddTextField.text! = ""
        self.birthdayPatientAddTextField.text! = ""
        self.sexPatientAddTextField.text! = ""
    }
    
    @objc func datePickerDone() {
        birthdayPatientAddTextField.endEditing(true)
        let formatter = DateFormatter()
        formatter.dateFormat =  "yyyy年MM月dd日"
        birthdayPatientAddTextField.text = "\(formatter.string(from: datePicker.date))"
    }
    
    @IBAction func birthdayTextFieldEditting (sender: UITextField){
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
    }
    
    @IBAction func sexTextFieldEditting (sender: UITextField) {
    }
    
    @objc func pickerViewDone() {
        sexPatientAddTextField.endEditing(true)
        sexPatientAddTextField.text! = "\(pickerViewList[pickerView.selectedRow(inComponent: 0)])"
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexPatientAddTextField.text! = pickerViewList[row]
    }
    
    @IBAction func registerPatientAddButton(_ sender: Any) {
        if self.clinicPatientAddTextField.text!.isEmpty || self.clinicIdPatientAddTextField.text!.isEmpty || self.familyNameFuriganaPatientAddTextField.text!.isEmpty || self.firstNameFuriganaPatientAddTextField.text!.isEmpty || self.familyNamePatientAddTextField.text!.isEmpty || self.firstNamePatientAddTextField.text!.isEmpty || self.sexPatientAddTextField.text!.isEmpty {
            SVProgressHUD.showError(withStatus: "全ての項目を入力してください")
            return
        }
        
        try! realm.write {
            let patientcount = realm.objects(PatientData.self).count
            if  patientcount != 0 {
                patientData.id = realm.objects(PatientData.self).max(ofProperty: "id")! + 1
            }
            self.patientData.clinic = self.clinicPatientAddTextField.text!
            self.patientData.clinicID = self.clinicIdPatientAddTextField.text!
            self.patientData.familyNameFurigana = self.familyNameFuriganaPatientAddTextField.text!
            self.patientData.firstNameFurigana = self.firstNameFuriganaPatientAddTextField.text!
            self.patientData.familyName = self.familyNamePatientAddTextField.text!
            self.patientData.firstName = self.firstNamePatientAddTextField.text!
            self.patientData.birthday = self.datePicker.date
            self.patientData.sex = self.sexPatientAddTextField.text!
            self.realm.add(self.patientData, update: .modified)
        }
        
        SVProgressHUD.showSuccess(withStatus: "患者を登録しました")
        navigationController?.popViewController(animated: true)
        
        
    }
    
    @IBAction func cancelPatientAddButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let patientSelectViewController = segue.destination as! PatientSelectViewController
//        self.patientData.id = patientSelectViewController.id
//        navigationController?.popViewController(animated: true)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
