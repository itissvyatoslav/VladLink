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
    
    var number = 0
    
    @IBOutlet weak var paymentList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        self.paymentList.register(UINib(nibName: "PhoneLabelCell", bundle: nil), forCellWithReuseIdentifier: "PhoneLabelCell")
        paymentList.delegate = self
        paymentList.dataSource = self
    }
}

extension PaymentMethodsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //if indexPath.item == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneLabelCell", for: indexPath) as! PhoneLabelCell
      cell.setUpCell(number: bill.bills[number].id)
      return cell
     //   }
    }
    
    
}
