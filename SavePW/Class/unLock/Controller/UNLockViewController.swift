//
//  UNLockViewController.swift
//  SavePW
//
//  Created by zhoucan on 2016/12/29.
//  Copyright © 2016年 verfing. All rights reserved.
//

import UIKit
import Eureka

class UNLockViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    
        
        self.title = "数字🔓"
        
        form +++ Section("数字密码")
            
            <<< TextRow() {
                $0.placeholder = "请输入六位数密码"
            
        }.cellSetup({ (cell, row) in
            cell.textField.keyboardType = .numberPad
            cell.textField.becomeFirstResponder()
        }).onChange({ (cell) in
            
            
            guard let saveNumber = cell.value else {return}
            
            if HMUserDefaults.saveNumber == saveNumber{
             
                self.view.endEditing(true)
                DispatchQueue.main.async {
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: SPWNotificationName.GoHome.rawValue), object: nil)
                }
            
            }
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
