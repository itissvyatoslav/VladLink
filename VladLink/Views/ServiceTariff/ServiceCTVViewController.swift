//
//  ServiceCTVViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 07.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class ServiceCTVViewController: UIViewController{
    let tariff = TariffModel.sharedData
    let bill = BillModel.sharedData
    let service = ServiceList()
    @IBOutlet weak var ctvList: UICollectionView!
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        self.ctvList.register(UINib(nibName: "PhoneLabelCell", bundle: nil), forCellWithReuseIdentifier: "PhoneLabelCell")
        self.ctvList.register(UINib(nibName: "itvCell", bundle: nil), forCellWithReuseIdentifier: "itvCell")
        ctvList.delegate = self
        ctvList.dataSource = self
    }
}

extension ServiceCTVViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tariff.productsCTV.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneLabelCell", for: indexPath) as! PhoneLabelCell
            cell.setUpCell(number: bill.bills[number].id)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itvCell", for: indexPath) as! itvCell
            tariff.products = tariff.productsCTV
            cell.delegate = self
            cell.setUpCell(indexPath.item - 1)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = UIScreen.main.bounds.size.width - 20
        if indexPath.item == 0{
            return CGSize(width: width, height: 40)
        } else {
            return CGSize(width: width, height: 80)
        }
    }
}

extension ServiceCTVViewController: itvCellDelegate{
    func deactiveService(cell: itvCell) {
        let alertController = UIAlertController(
            title: "Изменение услуг",
            message: "Вы уверены, что хотите изменить услуги?",
            preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Да", style: .default, handler: { _ in
            self.service.changeProductCTVService(OP: "demount-ctv", number: self.number)
            print("demount CTV")
        })
        let noButton = UIAlertAction(title: "Нет", style: .default, handler: { _ in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(yesButton)
        alertController.addAction(noButton)
        present(alertController, animated: true, completion: nil)
    }
    
    func activeService(cell: itvCell) {
        let alertController = UIAlertController(
            title: "Изменение услуг",
            message: "Вы уверены, что хотите изменить услуги?",
            preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Да", style: .default, handler: { _ in
            self.service.changeProductCTVService(OP: "add-ctv", number: self.number)
            print("add CTV")
        })
        let noButton = UIAlertAction(title: "Нет", style: .default, handler: { _ in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(yesButton)
        alertController.addAction(noButton)
        present(alertController, animated: true, completion: nil)
    }
}
