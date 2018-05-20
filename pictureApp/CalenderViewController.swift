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
    @IBOutlet weak var memoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar: UIView = UIView()
        toolBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45)
        toolBar.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        
        let barTextField: UITextField = UITextField()
        barTextField.frame = CGRect(x: 5, y: 5, width: self.view.frame.width - 65, height: 35)
        barTextField.placeholder = "コメント..."
        barTextField.borderStyle = UITextBorderStyle.roundedRect
        
        let barButton: UIButton = UIButton(type: UIButtonType.system)
        barButton.frame = CGRect(x: barTextField.frame.width + 10, y: 5, width: 50, height: 35)
        barButton.setTitle("送信", for: UIControlState.normal)
        barButton.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControlEvents.touchUpInside)
        
        toolBar.addSubview(barTextField)
        toolBar.addSubview(barButton)
        
        memoTextField.inputAccessoryView = toolBar
        memoTextField.delegate = self
        
        
        calenderView.scrollDirection = .vertical
        
        let calendar = Calendar.current
        let selectData =  calendar.date(from: DateComponents(year: 2018, month: 5, day: 20))
        calenderView.select(selectData)

        // Do any additional setup after loading the view.
    }
    
    @objc func buttonEvent(_ sender: UIButton) {
        addMemo(date: "05/18", title: "example", content: "hoge")
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


