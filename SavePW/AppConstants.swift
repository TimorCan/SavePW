//
//  AppConstants.swift
//  SavePW
//
//  Created by zhoucan on 2016/12/26.
//  Copyright © 2016年 verfing. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


// 获取默认的 Realm 数据库
let realm = try! Realm()

struct UIConstant {
    // 屏幕宽高
    static let IPHONE6_WIDTH : CGFloat = 375
    static let IPHONE6_HEIGHT : CGFloat = 667
    static let IPHONE5_WIDTH : CGFloat = 320
    static let IPHONE5_HEIGHT : CGFloat = 568
    static let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.width
    static let SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.height
    // 导航栏高度
    static let UI_NAV_HEIGHT : CGFloat = 64
    // tab高度
    static let UI_TAB_HEIGHT : CGFloat = 49
}
