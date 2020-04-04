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
    let dataModel = DataService()
    var labels = [String]()
    
    @IBOutlet weak var billList: UICollectionView!
    
    override func viewDidLoad() {
        network.getBills(auth_token: person.auth_token)
        super.viewDidLoad()
 //       print(bill.bills[0])
        setView()
        dataModel.saveData()
        
    }
    
    private func setNewLabels(){
        for number in 0..<bill.bills.count{
            
        }
    }
    
    private func setView(){
        self.billList.register(UINib(nibName: "BillCell", bundle: nil), forCellWithReuseIdentifier: "BillCell")
        self.billList.register(UINib(nibName: "LabelsCell", bundle: nil), forCellWithReuseIdentifier: "LabelsCell")
        self.billList.register(UINib(nibName: "ButtonsCell", bundle: nil), forCellWithReuseIdentifier: "ButtonsCell")
        self.billList.delegate = self
        self.billList.dataSource = self
    }
}

extension FirstEnterViewController: ButtonsCellDelegate{
    func nextViewController() {
        print(labels)
        let vc = storyboard?.instantiateViewController(identifier: "mainVC") as! MainViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func previousViewController() {
        self.dismiss(animated: true)
    }
    
    
}

extension FirstEnterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bill.bills.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelsCell", for: indexPath) as! LabelsCell
            cell.setUp(phoneNumber: person.formatedPhoneNumber)
            return cell
        } else if indexPath.item == bill.bills.count + 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonsCell", for: indexPath) as! ButtonsCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BillCell", for: indexPath) as! BillCell
            cell.setUp(number: indexPath.item - 1)
            labels.append(cell.commentTextField.text ?? "")
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        if indexPath.item == 0 {
            return CGSize(width: width, height: 140)
        } else {
            return CGSize(width: width, height: 230)
        }
    }
    
}
