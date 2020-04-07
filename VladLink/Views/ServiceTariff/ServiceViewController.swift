//
//  ServiceViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 31.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import  UIKit

class ServiceViewController: UIViewController{
    let bill = BillModel.sharedData
    let service = ServiceList()
    let tariff = TariffModel.sharedData
    
    @IBOutlet weak var serviceList: UICollectionView!
    @IBOutlet weak var infoServiceLabel: UILabel!
    
    var number = 0
    
    
    override func viewDidLoad() {
        print("Ima bich ima boss")
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        self.serviceList.register(UINib(nibName: "ServiceCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCell")
        self.serviceList.delegate = self
        self.serviceList.dataSource = self
        
        infoServiceLabel.text = "Лицевой счёт: \(bill.bills[number].id)"
    }
}

extension ServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        cell.setupCell(number: indexPath.item)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width - 40
        return CGSize(width: width, height: 80)
    }
}

extension ServiceViewController: ServiceCellDelegate{
    func goControll(cell: ServiceCell) {
        let cellIndex = serviceList.indexPath(for: cell)!.row
        if cellIndex == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TariffControllVC") as! TariffControllViewController
            vc.number = number
            service.getAllTariffs(number: number)
            self.present(vc, animated: true)
        }
        if cellIndex == 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ServiceITVVC") as! ServiceITVViewController
            vc.number = number
            if tariff.products1.isEmpty || tariff.products2.isEmpty || tariff.productsCTV.isEmpty{
                service.getProductServices(number: number)
            }
                service.getProductITV(number: number)
            self.present(vc, animated: true)
        }
        if cellIndex == 2 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ServiceCTVVC") as! ServiceCTVViewController
            vc.number = number
            if tariff.products1.isEmpty || tariff.products2.isEmpty || tariff.productsCTV.isEmpty{
                service.getProductServices(number: number)
            }
            service.statusCTV(number: number)
            self.present(vc, animated: true)
        }
        if cellIndex == 3 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ServiceMoreTariffVC") as! ServiceMoreTariffViewController
            vc.number = number
            if tariff.products1.isEmpty || tariff.products2.isEmpty || tariff.productsCTV.isEmpty{
                service.getProductServices(number: number)
            }
            self.present(vc, animated: true)
        }
        if cellIndex == 4 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ServiceDeviceVC") as! ServiceDeviceViewController
            vc.number = number
            if !tariff.devices.isEmpty{
                service.getDevices()
            }
            self.present(vc, animated: true)
        }
    }
}
