//
//  ServiceITVViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 04.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class ServiceITVViewController: UIViewController{
    let bill = BillModel.sharedData
    let tariff = TariffModel.sharedData
    let service = ServiceList()
    
    var number = 0
    @IBOutlet weak var itvServiceList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        self.itvServiceList.register(UINib(nibName: "PhoneLabelCell", bundle: nil), forCellWithReuseIdentifier: "PhoneLabelCell")
        self.itvServiceList.register(UINib(nibName: "itvCell", bundle: nil), forCellWithReuseIdentifier: "itvCell")
        itvServiceList.delegate = self
        itvServiceList.dataSource = self
    }
}

extension ServiceITVViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tariff.products1.count + tariff.productsITV.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneLabelCell", for: indexPath) as! PhoneLabelCell
            cell.setUpCell(number: bill.bills[number].id)
            return cell
        } else if indexPath.item <= tariff.products1.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itvCell", for: indexPath) as! itvCell
            tariff.products = tariff.products1
            cell.delegate = self
            cell.setUpCell(indexPath.item - 1)
            return cell
        } else if indexPath.item == tariff.products1.count + 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneLabelCell", for: indexPath) as! PhoneLabelCell
            cell.setUpITV()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itvCell", for: indexPath) as! itvCell
            cell.setUpCellITV(indexPath.item - tariff.products1.count - 2)
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = UIScreen.main.bounds.size.width - 20
        if indexPath.item == 0 || indexPath.item == tariff.products1.count + 1{
            return CGSize(width: width, height: 40)
        } else {
            return CGSize(width: width, height: 80)
        }
    }
}

extension ServiceITVViewController: itvCellDelegate{
    func deactiveService(cell: itvCell) {
        let alertController = UIAlertController(
            title: "Изменение услуг",
            message: "Вы уверены, что хотите изменить услуги?",
            preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Да", style: .default, handler: { _ in
            let cellIndex = self.itvServiceList.indexPath(for: cell)!.row
            if cellIndex < self.tariff.products1.count + 2 {
                self.service.changeProductService(OP: "deactive", service_id: self.tariff.products1[cellIndex - 1].id, number: self.number)
                print("deactive service")
            } else {
                self.service.changeProductITVService(OP: "deactive", service_id: self.tariff.productsITV[cellIndex - self.tariff.products1.count - 2].id, number: self.number)
                print("deactive itv")
            }
        })
        let noButton = UIAlertAction(title: " Нет", style: .default, handler: { _ in
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
            let cellIndex = self.itvServiceList.indexPath(for: cell)!.row
            print(cellIndex)
            if cellIndex < self.tariff.products1.count + 2 {
                self.service.changeProductService(OP: "active", service_id: self.tariff.products1[cellIndex - 1].id, number: self.number)
                print("active service")
            } else {
                self.service.changeProductITVService(OP: "active", service_id: self.tariff.productsITV[cellIndex - self.tariff.products1.count - 2].id, number: self.number)
                print("active itv")
            }
        })
        let noButton = UIAlertAction(title: " Нет", style: .default, handler: { _ in alertController.dismiss(animated: true, completion: nil)})
        alertController.addAction(yesButton)
        alertController.addAction(noButton)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
}
