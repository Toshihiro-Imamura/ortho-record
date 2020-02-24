//
//  MaterialViewController.swift
//  ortho_record
//
//  Created by 今村俊博 on 2020/02/14.
//  Copyright © 2020 toshihiro.imamura. All rights reserved.
//

import UIKit

class MaterialViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let materials:[String] = ["cephalogram", "P-A", "facialphoto"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return materials.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let materialcell = collectionView.dequeueReusableCell(withReuseIdentifier: "materialCell", for: indexPath)
        let imageview = materialcell.contentView as! UIImageView
        let cellImage = UIImage(named: materials[indexPath.row])
        imageview.image = cellImage
        return materialcell
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
