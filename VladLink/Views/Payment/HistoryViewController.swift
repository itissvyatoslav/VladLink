//
//  HistoryViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 08.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController{
    let pay = BillService()
    
    @IBOutlet weak var payHistoryList: UICollectionView!
    @IBOutlet weak var periodTextField: UITextField!
    private var dataPicker: UIPickerView?
    
    var number = 0
    let periods = ["Текущая неделя", "Текущий месяц", "Прошлая неделя", "Прошлый месяц"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        dataPicker = UIPickerView()
        periodTextField.inputView = dataPicker
        dataPicker?.delegate = self
        dataPicker?.dataSource = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HistoryViewController.viewTupped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTupped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func gettingDates(index: Int){
        let date = NSDate()
        let calendar = NSCalendar.current
        if index == 0 {
            let day = calendar.component(.day, from:  Date.today().previous(.monday))
            let month = calendar.component(.month, from:  Date.today().previous(.monday))
            let year = calendar.component(.year, from:  Date.today().previous(.monday))
            //let nextWeek = calendar.date(byAdding: .weekOfMonth, value: -2, to: date as Date)
            let yearNow = calendar.component(.year, from: Date.today())
            let monthNow = calendar.component(.month, from: Date.today())
            let dayNow = calendar.component(.day, from: Date.today())
            pay.getHistory(number: number, date_from: "\(year)-\(month)-\(day)", date_to: "\(yearNow)-\(monthNow)-\(dayNow)")
            
        }
        if index == 1 {
            let yearNow = calendar.component(.year, from: Date.today())
            let monthNow = calendar.component(.month, from: Date.today())
            let dayNow = calendar.component(.day, from: Date.today())
            pay.getHistory(number: number, date_from: "\(yearNow)-\(monthNow)-\(01)", date_to: "\(yearNow)-\(monthNow)-\(dayNow)")
        }
        if index == 2 {
            let daySunday = calendar.component(.day, from:  Date.today().previous(.sunday))
            let monthSunday = calendar.component(.month, from:  Date.today().previous(.sunday))
            let yearSunday = calendar.component(.year, from:  Date.today().previous(.sunday))
            let Week = calendar.date(byAdding: .weekOfMonth, value: -1, to: Date.today().previous(.sunday))!
            let prevWeek = calendar.date(byAdding: .day, value: 1, to: Week)
            let yearMonday = calendar.component(.year, from: prevWeek!)
            let monthMonday = calendar.component(.month, from: prevWeek!)
            let dayMonday = calendar.component(.day, from: prevWeek!)
            pay.getHistory(number: number, date_from: "\(yearMonday)-\(monthMonday)-\(dayMonday)", date_to: "\(yearSunday)-\(monthSunday)-\(daySunday)")
        }
        if index == 3 {
            
        }
    }
}

extension HistoryViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return periods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return periods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        periodTextField.text = periods[row]
        gettingDates(index: row)
    }
    
}

extension Date {

  static func today() -> Date {
      return Date()
  }

  func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.Next,
               weekday,
               considerToday: considerToday)
  }

  func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.Previous,
               weekday,
               considerToday: considerToday)
  }

  func get(_ direction: SearchDirection,
           _ weekDay: Weekday,
           considerToday consider: Bool = false) -> Date {

    let dayName = weekDay.rawValue

    let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

    assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

    let searchWeekdayIndex = weekdaysName.index(of: dayName)! + 1

    let calendar = Calendar(identifier: .gregorian)

    if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
      return self
    }

    var nextDateComponent = DateComponents()
    nextDateComponent.weekday = searchWeekdayIndex


    let date = calendar.nextDate(after: self,
                                 matching: nextDateComponent,
                                 matchingPolicy: .nextTime,
                                 direction: direction.calendarSearchDirection)

    return date!
  }

}

extension Date {
  func getWeekDaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    return calendar.weekdaySymbols
  }

  enum Weekday: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
  }

  enum SearchDirection {
    case Next
    case Previous

    var calendarSearchDirection: Calendar.SearchDirection {
      switch self {
      case .Next:
        return .forward
      case .Previous:
        return .backward
      }
    }
  }
}
