//
//  HMUserDefaults.swift
//  iHiho
//
//  Created by zhoucan on 2016/10/11.
//  Copyright © 2016年 Ruiju. All rights reserved.
//

import Foundation


class HMUserDefaults {
    
    /// 是否开启touchID密码
    class var isEnableTouchID: Bool {
        get { return getPropertyForKey(key: "isEnableTouchID", withDefaultValue: true) }
        set { savePropertyForKey(key: "isEnableTouchID", withValue: newValue as AnyObject?) }
    }
    
    
    
    class var saveNumber: String {
        get { return getPropertyForKey(key: "saveNumber", withDefaultValue: "") }
        set { savePropertyForKey(key: "saveNumber", withValue: newValue as AnyObject?) }
    }
    
    
    /// 是否开启数字密码
    class var isOpenNumSwitch: Bool {
        get { return getPropertyForKey(key: "isOpenNumSwitch", withDefaultValue: false) }
        set { savePropertyForKey(key: "isOpenNumSwitch", withValue: newValue as AnyObject?) }
    }
    
    /// 是否开启指纹密码
    class var isOpenfigSwitch: Bool {
        get { return getPropertyForKey(key: "isOpenfigSwitch", withDefaultValue: false) }
        set { savePropertyForKey(key: "isOpenfigSwitch", withValue: newValue as AnyObject?) }
    }
    
    
    /// 是否开启指纹密码
    class var isOpenfail: Bool {
        get { return getPropertyForKey(key: "isOpenfail", withDefaultValue: false) }
        set { savePropertyForKey(key: "isOpenfail", withValue: newValue as AnyObject?) }
    }
    

    
    
    /// 是否第一次登陆SPADDVC
    class var isFirstGoSPAddVC: Bool {
        get { return getPropertyForKey(key: "SPADDVC", withDefaultValue: true) }
        set { savePropertyForKey(key: "SPADDVC", withValue: newValue as AnyObject?) }
    }
    
    
    
    /// 是否第一次登陆SPAddCameraVC
    class var isFirstGoSPAddCameraVC: Bool {
        get { return getPropertyForKey(key: "SPAddCameraVC", withDefaultValue: true) }
        set { savePropertyForKey(key: "SPAddCameraVC", withValue: newValue as AnyObject?) }
    }
    
    
    
    /// 是否第一次登陆SPAddYHKVC
    class var isFirstGoSPAddYHKVC: Bool {
        get { return getPropertyForKey(key: "SPAddYHKVC", withDefaultValue: true) }
        set { savePropertyForKey(key: "SPAddYHKVC", withValue: newValue as AnyObject?) }
    }
    
    
    /// Convenient Property
    private static var defaults = UserDefaults.standard
    
    /// 获取用户设置的属性
    private class func getPropertyForKey<T>(key: String, withDefaultValue value: T) -> T {
        guard let savedValue = UserDefaults.standard.value(forKey: key) else {
            print("【用户配置】数据不存在！")
            savePropertyForKey(key: key, withValue: value as AnyObject?)
            print("【用户配置】读取到的 \(key) 数据为：\(value)")
            return value
        }
        print("【用户配置】读取到的 \(key) 数据为：\(savedValue)")
        return savedValue as! T
    }
    
    /// 设置用户属性
    private class func savePropertyForKey(key: String, withValue value: AnyObject?) {
        let previousValue = defaults.value(forKey: key)
        defaults.setValue(value, forKey: key)
        defaults.synchronize()
        print("【用户配置】向 \(key) 中写入数据：\(value)，此前的数据为：\(previousValue)")
    }

    
    
}
