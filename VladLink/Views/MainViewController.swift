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
    let network = JSONService()
    let person = PersonModel.sharedData
    let bill = BillModel.sharedData
    let data = DataService()
    
    @IBOutlet weak var billList: UICollectionView!
    @IBOutlet weak var navBar: UINavigationBar!
    override func viewDidLoad() {
        network.getBills(auth_token: person.auth_token)
        print(bill.bills)
        super.viewDidLoad()
        setView()
        setNavigationBanner()
        data.updateData()
        print(person.auth_token)
    }
    
    private func setView(){
        self.billList.register(UINib(nibName: "PhoneCell", bundle: nil), forCellWithReuseIdentifier: "PhoneCell")
        self.billList.register(UINib(nibName: "MainBillCell", bundle: nil), forCellWithReuseIdentifier: "MainBillCell")
        self.billList.register(UINib(nibName: "MainButtonCell", bundle: nil), forCellWithReuseIdentifier: "MainButtonCell")
        self.billList.delegate = self
        self.billList.dataSource = self
    }
    
    private func setNavigationBanner(){
        //let navController = navigationController!
        
        let image = #imageLiteral(resourceName: "logo_white") // image VLADLINK
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navBar.frame.size.width
        let bannerHeight = navBar.frame.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bill.bills.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneCell", for: indexPath) as! PhoneCell
            cell.setUp(phoneNumber: person.formatedPhoneNumber)
            cell.delegate = self
            return cell
        } else if indexPath.item == bill.bills.count + 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainButtonCell", for: indexPath) as! MainButtonCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainBillCell", for: indexPath) as! MainBillCell
            cell.setUp(number: indexPath.item - 1)
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        if indexPath.item == 0 {
            return CGSize(width: width, height: 50)
        } else {
            return CGSize(width: width, height: 230)
        }
    }
    
}

extension MainViewController: PhoneCellDelegate{
    func changePhone() {
        let vc = storyboard?.instantiateViewController(identifier: "changePhoneVC") as! ChangePhoneViewController
        self.present(vc, animated: true)
        vc.infoLabel.font = UIFont.systemFont(ofSize: 18)
        vc.infoLabel.text = "Текущий номер телефона:\n\(person.formatedPhoneNumber)\nВведите ваш номер телефона"
        print("Change Phone")
    }
}

extension MainViewController: MainButtonCellDelegate{
    func billControlAction() {
        print("billControl")
    }
    
    func newAdressAction() {
        print("newAdress")
        let vc = storyboard?.instantiateViewController(withIdentifier: "newAdressVC") as! NewAdressViewController
        self.present(vc, animated: true)
    }
}

extension MainViewController: MainBillCellDelegate{
    func goToPay(cell: MainBillCell) {
        guard let indexPath = self.billList.indexPath(for: cell)?.row else {
            return
        }
        
        print("\(indexPath) go to pay")
    }
    
    func goToService(cell: MainBillCell) {
        guard let indexPath = self.billList.indexPath(for: cell)?.row else {
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "ServiceVC") as! ServiceViewController
        vc.number = indexPath - 1
        self.present(vc, animated: true)
        print("\(indexPath) go to service")
    }
    
    func goToChat(cell: MainBillCell) {
        guard let indexPath = self.billList.indexPath(for: cell)?.row else {
            return
        }
        
        print("\(indexPath) go to chat")
    }
    

}
