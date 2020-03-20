//
//  FirstEnterViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 19.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class FirstEnterViewController: UIViewController {
    let network = JSONService()
    let person = PersonModel.sharedData
    let bill = BillModel.sharedData
    
    @IBOutlet weak var billList: UICollectionView!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!

    
    override func viewDidLoad() {
        network.getBills(auth_token: person.auth_token)
        super.viewDidLoad()
        print(bill)
        setView()
        
    }
    
    private func setView(){
        phoneNumberLabel.text = person.formatedPhoneNumber
//        labelBill.text = "Лицевой счет: \(bill.bills[0].full_name)"
 //       labelName.text =
        billList.delegate = self
        billList.dataSource = self
    }
}

extension FirstEnterViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bill.bills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "editCell", for: indexPath) as! EditBillCell
        cell.addressLabel.text = bill.bills[indexPath.row].u_address[0].dom_name
        cell.nameLabel.text = bill.bills[indexPath.row].full_name
        return cell
    }
    
    
}
