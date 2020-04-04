//
//  TariffControllViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 31.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class TariffControllViewController: UIViewController{
    let bill = BillModel.sharedData
    let tariff = TariffModel.sharedData
    
    @IBOutlet weak var tariffList: UICollectionView!
    
    var number = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        self.tariffList.register(UINib(nibName: "TariffsCell", bundle: nil), forCellWithReuseIdentifier: "TariffsCell")
        self.tariffList.register(UINib(nibName: "PhoneLabelCell", bundle: nil), forCellWithReuseIdentifier: "PhoneLabelCell")
        tariffList.delegate = self
        tariffList.dataSource = self
    }
}

extension TariffControllViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tariff.tariffs.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item  == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneLabelCell", for: indexPath) as! PhoneLabelCell
            cell.setUpCell(number: bill.bills[number].id)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TariffsCell", for: indexPath) as! TariffsCell
            cell.setUpCell(number: indexPath.item - 1)
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width - 40
        if indexPath.item == 0 {
            return CGSize(width: width, height: 40)
        } else {
            return CGSize(width: width, height: 180)
        }
    }
}

extension TariffControllViewController: TariffsCellDelegate{
    func goToChangeTariff(cell: TariffsCell) {
        guard let indexPath = self.tariffList.indexPath(for: cell)?.row else {
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChangeTariffVC") as! ChangeTariffViewController
        vc.newNumber = indexPath - 1
        vc.number = number
        self.present(vc, animated: true)
        print("\(indexPath) go to service")
    }
}

