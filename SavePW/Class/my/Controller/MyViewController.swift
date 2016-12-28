//
//  MyViewController.swift
//  SavePW
//
//  Created by zhoucan on 2016/12/27.
//  Copyright © 2016年 verfing. All rights reserved.
//

import UIKit
import Eureka

class MyViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        form +++ Section("设置")
            
            
            <<< ButtonRow("密码设置") {
                $0.title = $0.tag
                $0.presentationMode = .segueName(segueName: "passwsug", onDismiss: nil)
            }
            
            +++ Section("说明")

            <<< ButtonRow("使用须知") {
                $0.title = $0.tag
                $0.presentationMode = .segueName(segueName: "NeedKnow", onDismiss: nil)
        }

        

        
        
        

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
