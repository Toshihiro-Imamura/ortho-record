//
//  HomeViewController.swift
//  ortho_record
//
//  Created by 今村俊博 on 2020/02/14.
//  Copyright © 2020 toshihiro.imamura. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var clinicTextField: UITextField!
    @IBOutlet weak var clinicIdTextField: UITextField!
    @IBOutlet weak var familyNameFuriganaTextField: UITextField!
    @IBOutlet weak var firstNameFuriganaTextField: UITextField!
    @IBOutlet weak var familyNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var firstConsultDateTextField: UITextField!
    @IBOutlet weak var treatmentStartDateTextField: UITextField!
    @IBOutlet weak var retentionStartDateTextField: UITextField!
    
    @IBOutlet weak var facialPhotoImageView: UIImageView!
    
    @IBAction func imageViewButton(_ sender: Any) {
    }
    
    @IBAction func backBotton(_ sender: Any) {
        let patientSelectViewContorller = self.storyboard?.instantiateViewController(withIdentifier: "PatientSelectViewController") as! PatientSelectViewController
        self.present(patientSelectViewContorller, animated: true, completion: nil)
    }
    
    var id:Int = 0
    var patientData: PatientData = PatientData()
    var homePatientData = try! Realm().objects(PatientData.self)
    
    var patienteditable: Bool = false
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //値渡しされたidから患者データを表示
        homePatientData = try! Realm().objects(PatientData.self).filter("id == \(self.id)")
        
        self.clinicTextField.text! = homePatientData.first!.clinic
        self.clinicIdTextField.text! = homePatientData.first!.clinicID
        self.familyNameFuriganaTextField.text! = homePatientData.first!.familyNameFurigana
        self.firstNameFuriganaTextField.text! = homePatientData.first!.firstNameFurigana
        self.familyNameTextField.text! = homePatientData.first!.familyName
        self.firstNameTextField.text! = homePatientData.first!.firstName
        let formatter = DateFormatter()
        formatter.dateFormat =  "yyyy年MM月dd日"
        self.birthdayTextField.text = "\(formatter.string(from: homePatientData.first!.birthday))"
        let calendar = Calendar(identifier: .gregorian)
        let age = calendar.dateComponents([.year], from: homePatientData.first!.birthday)
        self.ageTextField.text! = "\(age.year!)"
        self.sexTextField.text! = homePatientData.first!.sex
        
        //datepicker設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        let datePickerToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        let datePickerSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace , target: self, action: nil)
        let datePickerDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDone))
        datePickerToolBar.setItems([datePickerSpaceItem,datePickerDoneItem], animated: true)
        firstConsultDateTextField.inputView = datePicker
        firstConsultDateTextField.inputAccessoryView = datePickerToolBar
        firstConsultDateTextField.inputAssistantItem.leadingBarButtonGroups.removeAll()
        firstConsultDateTextField.inputAssistantItem.trailingBarButtonGroups.removeAll()
        treatmentStartDateTextField.inputView = datePicker
        treatmentStartDateTextField.inputAccessoryView = datePickerToolBar
        treatmentStartDateTextField.inputAssistantItem.leadingBarButtonGroups.removeAll()
        treatmentStartDateTextField.inputAssistantItem.trailingBarButtonGroups.removeAll()
        retentionStartDateTextField.inputView = datePicker
        retentionStartDateTextField.inputAccessoryView = datePickerToolBar
        retentionStartDateTextField.inputAssistantItem.leadingBarButtonGroups.removeAll()
        retentionStartDateTextField.inputAssistantItem.trailingBarButtonGroups.removeAll()
        
        //TextFieldの入力禁止
        self.clinicTextField.isEnabled = patienteditable
        self.clinicIdTextField.isEnabled = patienteditable
        self.familyNameFuriganaTextField.isEnabled = patienteditable
        self.firstNameFuriganaTextField.isEnabled = patienteditable
        self.familyNameTextField.isEnabled = patienteditable
        self.firstNameTextField.isEnabled = patienteditable
        self.birthdayTextField.isEnabled = patienteditable
        self.ageTextField.isEnabled = patienteditable
        self.sexTextField.isEnabled = patienteditable
        self.firstConsultDateTextField.isEnabled = patienteditable
        self.treatmentStartDateTextField.isEnabled = patienteditable
        self.retentionStartDateTextField.isEnabled = patienteditable
        
        print(id)
        print(homePatientData)
        
    }
    
    @objc func datePickerDone (){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        
        if firstConsultDateTextField.isEditing == true {
            firstConsultDateTextField.text! = "\(formatter.string(from: datePicker.date))"
        }else if  treatmentStartDateTextField.isEditing == true {
            treatmentStartDateTextField.text! = "\(formatter.string(from: datePicker.date))"
        }else {
            retentionStartDateTextField.text! = "\(formatter.string(from: datePicker.date))"
        }
        self.view.endEditing(true)
    }
    
    @IBAction func firstConsulteingDate () {
        self.firstConsultDateTextField.endEditing(true)
    }
    
    @IBAction func treatmentStartDate () {
        self.treatmentStartDateTextField.endEditing(true)
    }
    
    @IBAction func retentionStartDate () {
        self.retentionStartDateTextField.endEditing(true)
    }
    
    //画面が閉じるときにテキストフィールドを空欄に
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        patienteditable = true
        
        
        self.clinicTextField.text! = ""
        self.clinicIdTextField.text! = ""
        self.familyNameFuriganaTextField.text! = ""
        self.firstNameFuriganaTextField.text! = ""
        self.familyNameTextField.text! = ""
        self.firstNameTextField.text! = ""
        self.birthdayTextField.text = ""
        self.ageTextField.text! = ""
        self.sexTextField.text! = ""
        self.facialPhotoImageView.image = nil
        
    }
    
    //編集、保存、削除ボタン
    @IBAction func editPatient(_ sender: Any) {
        patienteditable = true
        loadView()
        viewDidLoad()
    }
    @IBAction func savePatient(_ sender: Any) {
        patienteditable = false
        self.clinicTextField.isEnabled = patienteditable
        self.clinicIdTextField.isEnabled = patienteditable
        self.familyNameFuriganaTextField.isEnabled = patienteditable
        self.firstNameFuriganaTextField.isEnabled = patienteditable
        self.familyNameTextField.isEnabled = patienteditable
        self.firstNameTextField.isEnabled = patienteditable
        self.birthdayTextField.isEnabled = patienteditable
        self.ageTextField.isEnabled = patienteditable
        self.sexTextField.isEnabled = patienteditable
        self.firstConsultDateTextField.isEnabled = patienteditable
        self.treatmentStartDateTextField.isEnabled = patienteditable
        self.retentionStartDateTextField.isEnabled = patienteditable
    }
    @IBAction func deletePatient(_ sender: Any) {
        try! Realm().write {
            try! Realm().delete(homePatientData)
        }
        navigationController?.popViewController(animated: true)
    }
    
    //画像変更
    @IBAction func imageChangeButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] != nil {
            let image = info[.originalImage] as! UIImage
            facialPhotoImageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
