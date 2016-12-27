//
//  SPAccountModel.swift
//  SavePW
//
//  Created by zhoucan on 2016/12/27.
//  Copyright © 2016年 verfing. All rights reserved.
//

import Foundation
import RealmSwift

class SPAccountModel: Object {
    
    
    dynamic var accoutType:Int = 0 // 0-网页 1-card 2-image
    
    dynamic var nickName = "" //昵称
    dynamic var account = ""  //账号
    
    dynamic var pass : String? //密码
    dynamic var phone : String? //电话
    dynamic var mail : String?  //邮箱
    dynamic var queA1 : String?  //问题以及答案1
    dynamic var queA2 : String?  //问题以及答案2
    dynamic var queA3 : String?  //问题以及答案3
    
    dynamic var payPass : String? //取款密码
    dynamic var otherPass : String? //其他密码
    dynamic var remarks : String?  //备注
    
    dynamic var imageData : Data?  //备注
    dynamic var lastDate : Date?  //备注
  
    
}
