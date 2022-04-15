//
//  ViewController.swift
//  DatePicker
//
//  Created by 윤동관 on 2022/04/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTIme: UILabel!
    
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var count = 0
    var alertTime: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm aaa"
        lblPickerTIme.text = "선택시간 : " + formatter.string(from: datePickerView.date)
        
        alertTime = formatter.string(from: datePickerView.date)
       
    }
    
    @objc func updateTime(){
//        lblCurrentTime.text = String(count)
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm aaa"
        lblCurrentTime.text = "현재시간 : " + formatter.string(from: date as Date)
        
        let currentTime = formatter.string(from: date as Date)
        
        if(alertTime == currentTime){
            view.backgroundColor = UIColor.red
        }
        if view.backgroundColor == UIColor.red{
            count += 1
            if(count == 60){
                view.backgroundColor = UIColor.white
                count = 0
            }
        }
        print(count)
    }
    
}

