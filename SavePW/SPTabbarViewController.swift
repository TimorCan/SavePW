//
//  SPTabbarViewController.swift
//  SavePW
//
//  Created by zhoucan on 2016/12/29.
//  Copyright © 2016年 verfing. All rights reserved.
//

import UIKit

class SPTabbarViewController: UITabBarController {

    let mainColor = UIColor.orange
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = mainColor
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : mainColor], for: UIControlState.normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : mainColor], for: UIControlState.highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.lightGray], for: UIControlState.disabled)
        
        UINavigationBar.appearance().tintColor = mainColor
        
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
