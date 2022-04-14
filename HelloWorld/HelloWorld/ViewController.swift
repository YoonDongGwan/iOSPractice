//
//  ViewController.swift
//  HelloWorld
//
//  Created by 윤동관 on 2022/04/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblHello: UILabel!
    
    @IBOutlet var txtName: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnSend(_ sender: UIButton) {
        lblHello.text = "Hello, " + txtName.text!
    }
    
}

