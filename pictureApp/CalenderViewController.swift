//
//  CalenderViewController.swift
//  pictureApp
//
//  Created by 蒲生廣人 on 2018/04/21.
//  Copyright © 2018年 蒲生廣人. All rights reserved.
//

import UIKit
import FSCalendar
import RealmSwift


class CalenderViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var memoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Text Fieldのdelegate通知先を設定
        memoTextField.delegate = self
        let today :Date =  Date()
        print(today)
        //カレンダーが縦にスクロールできるように
        calenderView.scrollDirection = .vertical

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        dateLabel.text = "\(year)/\(month)/\(day)"
        print(type(of: year))
        getMemoByDate(date: dateLabel.text!)
    }
    
    func textFieldShouldReturn(_ memoTextField: UITextField) -> Bool {
        memoTextField.resignFirstResponder()
        
        if let newMemo = memoTextField.text {
            addMemo(date: dateLabel.text ?? "2018/06/05", title: newMemo, content: newMemo)
            print(newMemo)
            print(dateLabel.text ?? "hoge")
            memoLabel.text = newMemo
        }
        return true
    }

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


