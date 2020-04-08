//
//  ServiceDeviceViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 07.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class ServiceDeviceViewController: UIViewController{
    let tariff = TariffModel.sharedData
    let bill = BillModel.sharedData
    let service = ServiceList()
    
    var number = 0
    @IBOutlet weak var devicesList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        self.devicesList.register(UINib(nibName: "PhoneLabelCell", bundle: nil), forCellWithReuseIdentifier: "PhoneLabelCell")
        self.devicesList.register(UINib(nibName: "deviceCell", bundle: nil), forCellWithReuseIdentifier: "deviceCell")
        devicesList.delegate = self
        devicesList.dataSource = self
    }
}

extension ServiceDeviceViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tariff.devices.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneLabelCell", for: indexPath) as! PhoneLabelCell
            cell.setUpCell(number: bill.bills[number].id)
            return cell
        } else {
            if tariff.devices[indexPath.item - 1].installment_plan == nil {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deviceCell", for: indexPath) as! deviceCell
                cell.setUpCell(indexPath.item - 1)
                cell.delegate = self
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deviceCell", for: indexPath) as! deviceCell
                cell.setUpCellPost(indexPath.item - 1)
                cell.delegate = self
                return cell
            }
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

extension ServiceDeviceViewController: deviceCellDelegate{
    func getDevicePlan(cell: deviceCell) {
        let cellIndex = self.devicesList.indexPath(for: cell)!.row
        service.sendRequestDevice(number: number, srv_type: 2, descr: tariff.devices[cellIndex - 1].description)
        infoWindow()
    }
    
    func getDevice(cell: deviceCell) {
        let cellIndex = self.devicesList.indexPath(for: cell)!.row
        service.sendRequestDevice(number: number, srv_type: 12, descr: tariff.devices[cellIndex - 1].description)
        infoWindow()
    }
    
    func infoWindow(){
        let alertController = UIAlertController(
            title: "Приобрести оборудование",
            message: "Ваша заявка принята. Ожидайте звонка.",
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(
            title: "Закрыть",
            style: .default,
            handler: { _ in
                alertController.dismiss(animated: true, completion: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
}
