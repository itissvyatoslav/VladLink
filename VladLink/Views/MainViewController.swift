//
//  MainViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 22.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController{
    let person = PersonModel.sharedData
    let bill = BillModel.sharedData
    
    @IBOutlet weak var billList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        self.billList.register(UINib(nibName: "PhoneCell", bundle: nil), forCellWithReuseIdentifier: "PhoneCell")
        
        self.billList.delegate = self
        self.billList.dataSource = self
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bill.bills.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneCell", for: indexPath) as! PhoneCell
        cell.setUp(phoneNumber: person.formatedPhoneNumber)
        cell.delegate = self
        return cell
    }
}

extension MainViewController: PhoneCellDelegate{
    func changePhone() {
        print("Change Phone")
    }
    
    
}
