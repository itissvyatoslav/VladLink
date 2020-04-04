//
//  ChangeTariffViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 01.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class ChangeTariffViewController: UIViewController{
    let person = PersonModel.sharedData
    let bill = BillModel.sharedData
    let tariff = TariffModel.sharedData
    let service = ServiceList()
    @IBOutlet weak var tariffChangeList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    var number = 0
    var newNumber = 0
    
    private func setViews(){
        self.tariffChangeList.register(UINib(nibName: "PhoneLabelPlusCell", bundle: nil), forCellWithReuseIdentifier: "PhoneLabelPlusCell")
        self.tariffChangeList.register(UINib(nibName: "TariffsCell", bundle: nil), forCellWithReuseIdentifier: "TariffsCell")
        self.tariffChangeList.register(UINib(nibName: "ButtonsServiceCell", bundle: nil), forCellWithReuseIdentifier: "ButtonsServiceCell")
        self.tariffChangeList.register(UINib(nibName: "infoDateCell", bundle: nil), forCellWithReuseIdentifier: "infoDateCell")
        tariffChangeList.delegate = self
        tariffChangeList.dataSource = self
    }
}

extension ChangeTariffViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneLabelPlusCell", for: indexPath) as! PhoneLabelPlusCell
            cell.setUpCell(number: bill.bills[number].id)
            return cell
        } else if indexPath.item == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonsServiceCell", for: indexPath) as! ButtonsServiceCell
            cell.delegate = self
            return cell
        } else if indexPath.item == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoDateCell", for: indexPath) as! infoDateCell
            cell.date = tariff.tariffs[newNumber].tchange
            cell.setUpCell()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TariffsCell", for: indexPath) as! TariffsCell
            cell.setUpForChanging(number: indexPath.item, newNumber: newNumber)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width - 40
        if indexPath.item == 0 {
            return CGSize(width: width, height: 80)
        } else if indexPath.item == 3 {
            return CGSize(width: width, height: 100)
        } else if indexPath.item == 4 {
            return CGSize(width: width, height: 70)
        } else {
            return CGSize(width: width, height: 180)
        }
    }
}

extension ChangeTariffViewController: ButtonsServiceCellDelegate{
    func newTariff() {
        print("tariff.")
        service.newTariff(account_id: person.publicUids[number], tariff_id: tariff.tariffs[newNumber].tid)
        self.dismiss(animated: true)
    }
    
    func goBackVC() {
        self.dismiss(animated: true)
    }
}
