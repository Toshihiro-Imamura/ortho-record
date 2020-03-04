//
//  TabBarController.swift
//  ortho_record
//
//  Created by 今村俊博 on 2020/02/26.
//  Copyright © 2020 toshihiro.imamura. All rights reserved.
//

import UIKit
import RealmSwift

class TabBarController: UITabBarController {
    
    var patientData: PatientData = PatientData()
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let homeViewController = self.selectedViewController as! HomeViewController
        homeViewController.id = self.id
    }
    
}
