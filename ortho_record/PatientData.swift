//
//  PatientData.swift
//  ortho_record
//
//  Created by 今村俊博 on 2020/02/17.
//  Copyright © 2020 toshihiro.imamura. All rights reserved.
//


import RealmSwift

class PatientData: Object {
    //管理用ID primaryKey
    @objc dynamic var id = 0

    @objc dynamic var clinic = ""
    //クリニックでのID
    @objc dynamic var clinicID = ""
    
    @objc dynamic var familyName = ""
    @objc dynamic var firstName = ""
    @objc dynamic var familyNameFurigana = ""
    @objc dynamic var firstNameFurigana = ""
    
    @objc dynamic var birthday = Date()
    @objc dynamic var age = ""
    @objc dynamic var sex = ""
    
    @objc dynamic var firstConsultationDate = Date()
    @objc dynamic var treatmentStartDate = Date()
    @objc dynamic var retentionStartDate = Date()
    
    @objc dynamic var SNA = 0
    @objc dynamic var SNB = 0
    @objc dynamic var ANB = 0
    @objc dynamic var FMA = 0
    @objc dynamic var U1toFH = 0
    @objc dynamic var L1toFH = 0
    @objc dynamic var FMIA = 0
    @objc dynamic var ELine = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
