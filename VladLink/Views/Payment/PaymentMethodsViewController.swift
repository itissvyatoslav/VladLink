//
//  PaymentMethodsViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 08.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class PaymentMethodsViewController: UIViewController{
    let bill = BillModel.sharedData
    let pay = PayModel.sharedData
    
    var number = 0
    
    @IBOutlet weak var paymentList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        self.paymentList.register(UINib(nibName: "PhoneLabelCell", bundle: nil), forCellWithReuseIdentifier: "PhoneLabelCell")
        self.paymentList.register(UINib(nibName: "PaymentMethodCell", bundle: nil), forCellWithReuseIdentifier: "PaymentMethodCell")
        paymentList.delegate = self
        paymentList.dataSource = self
    }
}

extension PaymentMethodsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(pay.paymentMethods.count + 1)
        return pay.paymentMethods.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneLabelCell", for: indexPath) as! PhoneLabelCell
            cell.setUpCell(number: bill.bills[number].id)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodCell
            cell.setCell(indexPath.item - 1)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = UIScreen.main.bounds.size.width - 20
        if indexPath.item == 0{
            return CGSize(width: width, height: 40)
        } else {
            return CGSize(width: 10, height: 80)
        }
    }
}
