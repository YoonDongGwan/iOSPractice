//
//  ViewController.swift
//  Alert
//
//  Created by 윤동관 on 2022/04/17.
//

import UIKit

class DateAlertViewController: UIViewController {
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblSelectedTime: UILabel!
    
    let interval = 1.0
    var count = 0
    var isOK = false
    var currentTime: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let timerSelector: Selector = #selector(DateAlertViewController.updateTime)
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timerSelector, userInfo: nil, repeats: true)
        
    }

    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        var selectedTime = formatter.string(from: datePickerView.date)
        lblSelectedTime.text = "선택시간 : " + selectedTime
    
        if currentTime == selectedTime && isOK == false{
            let alert = UIAlertController(title: "알림", message: "설정된 시간입니다.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "네, 알겠습니다.", style: UIAlertAction.Style.default, handler: {
                ACTION in self.isOK = true
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    @objc func updateTime(){
        let date = NSDate()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        currentTime = formatter.string(from: date as Date)
        lblCurrentTime.text = "현재시간 : " + currentTime!
        if isOK{
            count += 1
            if count == 60{
                isOK = false
                count = 0
            }
        }
        
    }
}
