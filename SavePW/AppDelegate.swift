//
//  AppDelegate.swift
//  SavePW
//
//  Created by zhoucan on 2016/12/26.
//  Copyright © 2016年 verfing. All rights reserved.
//

import UIKit
import LocalAuthentication


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var isFirstOpen:Bool = false
    
    var showPassView:Bool = false
    
    deinit {
         NotificationCenter.default.removeObserver(self)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print(NSHomeDirectory()) //打印地址
        isFirstOpen = true
    
        NotificationCenter.default.addObserver(self, selector: #selector(goHome), name: NSNotification.Name(rawValue: SPWNotificationName.GoHome.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goLockNumber), name: NSNotification.Name(rawValue: SPWNotificationName.GoNumber.rawValue), object: nil)
        
        
        return true
    }
    
    
    
    
    
    //去home界面
    func goHome()  {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let tabbarVC = storyboard.instantiateViewController(withIdentifier: "SPTabbarViewController")
        self.window!.rootViewController =  tabbarVC
        
    }
    
    
    //去数字密码界面
    func goLockNumber()  {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UNLockViewController")
        let nav = UINavigationController.init(rootViewController: vc)
        self.window!.rootViewController =  nav
        
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        
//        
//        if  !isFirstOpen {
//            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LockFaildViewController") as! LockFaildViewController
//            vc.isBecomeActive = true
//            let nav = UINavigationController.init(rootViewController: vc)
//            self.window?.rootViewController?.present(nav, animated: true, completion: nil)
//            
//        }
//        
//        isFirstOpen = false
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
       
            
        showPassView = true
        
        isFirstOpen = false
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        
        if showPassView {
            
            
            if HMUserDefaults.isOpenfail {
            
                if HMUserDefaults.isOpenNumSwitch == true {
                    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UNLockViewController") as! UNLockViewController
                    vc.isBecomeActive = true
                    let nav = UINavigationController.init(rootViewController: vc)
                    self.window?.rootViewController?.present(nav, animated: true, completion: nil)
                    
                }
                
                HMUserDefaults.isOpenfail = false
                
                return
            }
            
            
            if HMUserDefaults.isOpenfigSwitch == true {
             
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LockFaildViewController") as! LockFaildViewController
            vc.isBecomeActive = true
            let nav = UINavigationController.init(rootViewController: vc)
            self.window?.rootViewController?.present(nav, animated: true, completion: nil)
                showPassView = false
                return
            }
            
            
            
            if HMUserDefaults.isOpenNumSwitch == true {
                
                let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UNLockViewController") as! UNLockViewController
                vc.isBecomeActive = true
                let nav = UINavigationController.init(rootViewController: vc)
                self.window?.rootViewController?.present(nav, animated: true, completion: nil)
                
            }
            
            
            
            
        }
        
      
        showPassView = false
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

