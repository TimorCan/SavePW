//
//  LockFaildViewController.swift
//  SavePW
//
//  Created by zhoucan on 2016/12/29.
//  Copyright © 2016年 verfing. All rights reserved.
//

import UIKit
import LocalAuthentication
import SnapKit

class LockFaildViewController: UIViewController {

    
    var isBecomeActive:Bool = false
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if HMUserDefaults.isOpenfigSwitch == false && HMUserDefaults.isOpenNumSwitch == false {
            
            //没有设置密码
            DispatchQueue.main.async {
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: SPWNotificationName.GoHome.rawValue), object: nil)
            }
            
        }else{
            
            if HMUserDefaults.isOpenfigSwitch && HMUserDefaults.isOpenfigSwitch {
                
                
                 fingerprintUnlock()
                
                 return
            }else if HMUserDefaults.isOpenNumSwitch{
            
             
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: SPWNotificationName.GoNumber.rawValue), object: nil)
                }
            
            
            }else{
            
                showAlert()
            }
            
        
        }
        
        
        
      

        
    }
    
    
    func showAlert() {
        
        DispatchQueue.main.async {
            let label = UILabel.init()
            label.textColor = UIColor.orange
            label.font = UIFont.systemFont(ofSize: 20)
            label.textAlignment = .center
            label.text = "解锁失败！请稍后再试"
            self.view.addSubview(label)
            
            label.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 320, height: 40))
                make.center.equalTo(self.view.snp.center)
            } 
        }
        
        
    }
    
    
    //指纹解锁
    func fingerprintUnlock() {
        
        // 1.判断是否支持touchID
        
        let context =  LAContext.init()
        
        let valid = context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil)
        
        HMUserDefaults.isEnableTouchID = valid
        
        if valid {
            //支持TouchID
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "通过Home键验证指纹", reply: { (success, error) in
                
                if success{
                    //不做操作
                    
                    
                    DispatchQueue.main.async {
                        
                        
                        if self.isBecomeActive {
                        
                            if HMUserDefaults.isOpenNumSwitch{
                                
                                self.dismiss(animated: true, completion: nil)

                            
                            }
                            
                            return
                        
                        }
                        
                        
                        
                        self.title = "成功解锁"
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SPWNotificationName.GoHome.rawValue), object: nil)
                    }
                    
                    
                    
                    
                }else{
                    
                    
                    
                    if HMUserDefaults.isOpenNumSwitch{
                    
                        if self.isBecomeActive{
                        
                          HMUserDefaults.isOpenfail = true
                            self.dismiss(animated: true, completion: nil)
                            return

                        }
                        
                        
                        
                   
                     DispatchQueue.main.async {
                         self.title = "解锁失败"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: SPWNotificationName.GoNumber.rawValue), object: nil)
                    }
                    }
                    else{
                    
                         self.showAlert()
                    
                    }
                    
                    let err = error as! NSError
                    
                    if err.code == Int(kLAErrorUserFallback){
                        
                        
                    }else if err.code == Int(kLAErrorUserCancel){
                        
                        
                    }else{
                        
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
                
                
                
            })
            
            
            
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
