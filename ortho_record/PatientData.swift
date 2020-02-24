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
    @objc dynamic var familyNameFurigata = ""
    @objc dynamic var firstNameFurigana = ""
    
    @objc dynamic var birthday = Date()
    
    @objc dynamic var sex = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
