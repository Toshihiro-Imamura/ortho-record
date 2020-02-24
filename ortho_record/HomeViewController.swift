//
//  HomeViewController.swift
//  ortho_record
//
//  Created by 今村俊博 on 2020/02/14.
//  Copyright © 2020 toshihiro.imamura. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func backBotton(_ sender: Any) {
        let patientSelectViewContorller = self.storyboard?.instantiateViewController(withIdentifier: "PatientSelectViewController") as! PatientSelectViewController
        self.present(patientSelectViewContorller, animated: true, completion: nil)
    }
    
    var patientData: PatientData!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
