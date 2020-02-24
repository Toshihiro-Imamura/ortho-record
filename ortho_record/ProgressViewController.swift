//
//  ProgressViewController.swift
//  ortho_record
//
//  Created by 今村俊博 on 2020/02/14.
//  Copyright © 2020 toshihiro.imamura. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var dateTableView: UITableView!
    @IBOutlet weak var toothTableView: UITableView!
    @IBOutlet weak var commentTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateTableView.delegate = self
        self.toothTableView.delegate = self
        self.commentTableView.delegate = self
        self.dateTableView.dataSource = self
        self.toothTableView.dataSource = self
        self.commentTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateCell = dateTableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
        return dateCell
        
        let toothCell = toothTableView.dequeueReusableCell(withIdentifier: "toothCell", for: indexPath)
        return toothCell
        
        let commentCell = commentTableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        return commentCell
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
