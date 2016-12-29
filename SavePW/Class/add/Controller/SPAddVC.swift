//
//  SPAddVC.swift
//  SavePW
//
//  Created by zhoucan on 2016/12/26.
//  Copyright © 2016年 verfing. All rights reserved.
//

import UIKit
import Eureka
import SVProgressHUD

enum AddType : Int {
    case nomarl = 0
    case card = 1
    case camera = 2
}


//拍照存储
class SPAddCameraVC: FormViewController {
    
    
    var isDisable:Condition = false // 编辑
    var isDisableBool:Bool = false // 编辑 布尔值
        {
        didSet{
           
            if isDisableBool{
              self.saveItem.isEnabled = false
            
            }
            
        }
    }
    
    
    var type:AddType = AddType.camera
    var model:SPAccountModel? //模型
    var callBackRefresh:((_ hasRefresh:Bool)->())? //需要刷新
    
    
    @IBOutlet weak var saveItem: UIBarButtonItem!
//    @IBOutlet weak var actionItem: UIBarButtonItem!
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        HMUserDefaults.isFirstGoSPAddCameraVC = false
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        
        if !HMUserDefaults.isFirstGoSPAddCameraVC {
            self.navigationItem.prompt = nil //就第一次显示提示
        }
        
        if model == nil{
            //初始化
            model = SPAccountModel()
        }

        
        form +++ Section("昵称+图片")
            
            
            <<< TextRow() {
                $0.title = "昵称"
                $0.placeholder = "取个名字吧，如qq"
                $0.disabled = self.isDisable
                if self.isDisableBool {
                    $0.value = model?.nickName
                    
                }
                
                }.onChange({[weak self] (cell) in
                    
                    guard let value = cell.value else {return}
                    
                    self?.model?.nickName = value
                })
            
            
            <<< TextAreaRow() {
                $0.placeholder = "备注信息"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 80)
                $0.disabled = self.isDisable
                if self.isDisableBool {
                    
                    $0.value = model?.remarks
                    
                }
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.remarks = value
                })
            
            
            

            <<< DateRow(){
                $0.title = "最后编辑日期"
                if self.isDisableBool {
                    
                    $0.value = model?.lastDate
                    
                }else{
                    $0.value = Date()
                    self.model?.lastDate = Date()
                }

                $0.value = Date()
                let formatter = DateFormatter()
                formatter.locale = .current
                formatter.dateStyle = .short
                $0.dateFormatter = formatter
                $0.disabled = self.isDisable
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.lastDate = value
                })
        
            +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "添加照片"
                
               
                }
                .onCellSelection { [weak self] (cell, row) in
                    print("hello")
        }

        
        
    }
    
    @IBAction func actionAction(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        
        
        if model?.nickName != nil  && (model?.nickName.characters.count)! > 0 {
            
            if model?.account.isEmpty == true {
                model?.account = (model?.nickName)!
            }
            
        }else{
            
            SVProgressHUD.showError(withStatus: "昵称不能为空")
            return
        }
        
        
        try! realm.write {
            
            model?.accoutType = 2
            realm.add(model!)
        }
        
        self.callBackRefresh!(true)
        let _ =  self.navigationController?.popViewController(animated: true)
    }

}

class SPAddYHKVC: FormViewController {

    var type:AddType = AddType.card
    var model:SPAccountModel? //模型
    var callBackRefresh:((_ hasRefresh:Bool)->())? //需要刷新
    
    var isDisable:Condition = false // 编辑
    var isDisableBool:Bool = false // 编辑 布尔值
        {
        didSet{
            
            if isDisableBool{
                
                 self.saveItem.isEnabled = false
                
            }
            
        }
    }
    @IBOutlet weak var saveItem: UIBarButtonItem!
    @IBOutlet weak var actionItem: UIBarButtonItem!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        HMUserDefaults.isFirstGoSPAddYHKVC = false
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !HMUserDefaults.isFirstGoSPAddYHKVC {
            self.navigationItem.prompt = nil
        }

        if model == nil{
            //初始化
            model = SPAccountModel()
        }

            form +++ Section("银行卡+密码")
            
                
            <<< TextRow() {
                $0.title = "昵称"
                $0.placeholder = "取个名字吧，如我的农行卡"
                $0.disabled = self.isDisable
                if self.isDisableBool {
                    
                    $0.value = model?.nickName
                    
                }
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.nickName = value
                })
                
            <<< TextRow() {
            $0.title = "账号"
            $0.placeholder = "请输入账号"
            $0.disabled = self.isDisable
                if self.isDisableBool {
                    
                    $0.value = model?.account
                    
                }
                
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.account = value
                }).cellSetup { cell, _  in
                    cell.textField.keyboardType = .numberPad
                }
            
            <<< TextRow() {
            $0.title = "取款密码"
            $0.placeholder = "请输入取款密码"
            $0.disabled = self.isDisable
                if self.isDisableBool {
                    
                    $0.value = model?.payPass
                    
                }
                
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.payPass = value
                }).cellSetup { cell, _  in
                    cell.textField.keyboardType = .numberPad
                }
           <<< TextRow() {
            $0.title = "查询密码"
            $0.placeholder = "请输入查询密码"
            $0.disabled = self.isDisable
            if self.isDisableBool {
                
                $0.value = model?.otherPass
                
            }
            
            }.onChange({[weak self] (cell) in
                 guard let value = cell.value else {return}
                self?.model?.otherPass = value
            })
                +++ Section("备注")
                
                <<< TextAreaRow() {
                    $0.placeholder = "备注信息"
                    $0.textAreaHeight = .dynamic(initialTextViewHeight: 80)
                    $0.disabled = self.isDisable
                    if self.isDisableBool {
                        
                        $0.value = model?.remarks
                        
                    }
                    
                    }.onChange({[weak self] (cell) in
                         guard let value = cell.value else {return}
                        self?.model?.remarks = value
                    })
                
                <<< DateRow(){
                    $0.title = "最后编辑日期"
                    if self.isDisableBool {
                        
                        $0.value = model?.lastDate
                        
                    }else{
                        $0.value = Date()
                        self.model?.lastDate = Date()
                    }
                    $0.value = Date()
                    let formatter = DateFormatter()
                    formatter.locale = .current
                    formatter.dateStyle = .short
                    $0.dateFormatter = formatter
                    $0.disabled = self.isDisable
                    
                    
                    }.onChange({[weak self] (cell) in
                         guard let value = cell.value else {return}
                        self?.model?.lastDate = value
                    })


    
}
    
    
    @IBAction func actionAction(_ sender: UIBarButtonItem) {
    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        
        
        if model?.account != nil  && (model?.account.characters.count)! > 0 {
            
            if model?.nickName.isEmpty == true {
                model?.nickName = (model?.account)!
            }
            
        }else{
            
            SVProgressHUD.showError(withStatus: "账号不能为空")
            return
        }
        
        
        try! realm.write {
            model?.accoutType = 1
            realm.add(model!)
        }
        
        self.callBackRefresh!(true)
        let _ =  self.navigationController?.popViewController(animated: true)
    }

}




class SPAddVC: FormViewController {
    
    
    var isDisable:Condition = false // 编辑
    var isDisableBool:Bool = false // 编辑 布尔值
        {
        didSet{
            
            if isDisableBool{
                
                self.saveItem.isEnabled = false
            }
            
        }
    }
    var model:SPAccountModel? //模型
    var type:AddType = AddType.nomarl
    var callBackRefresh:((_ hasRefresh:Bool)->())? //需要刷新
    
    @IBOutlet weak var saveItem: UIBarButtonItem!
    @IBOutlet weak var actionItem: UIBarButtonItem!
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        HMUserDefaults.isFirstGoSPAddVC = false
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        if !HMUserDefaults.isFirstGoSPAddVC {
            self.navigationItem.prompt = nil
        }
        
        if model == nil{
         //初始化
          model = SPAccountModel()
        }
        
        
        
         form +++ Section("账号+密码")
 
            <<< TextRow() {
                $0.title = "昵称"
                $0.placeholder = "取个名字吧，如qq"
                $0.disabled = self.isDisable
                
                if self.isDisableBool {
                 
                    $0.value = model?.nickName
                 
                }
                
                
                
            }.onChange({[weak self] (cell) in
                 guard let value = cell.value else {return}
                self?.model?.nickName = value
            })
            
            <<< TextRow() {
                $0.title = "账号"
                $0.placeholder = "请输入账号"
                $0.disabled = self.isDisable
                
                if self.isDisableBool {
                    
                    $0.value = model?.account
                    
                }
                
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.account = value
                })
            
            <<< TextRow() {
                $0.title = "密码"
                $0.placeholder = "请输入密码"
                $0.disabled = self.isDisable
                
                if self.isDisableBool {
                    
                    $0.value = model?.pass
                    
                }
                
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.pass = value
                })
            
          
            
            +++ Section("关联电话以及邮箱")
            <<< PhoneRow() {
                $0.title = "电话"
                $0.placeholder = "📱"
                $0.disabled = self.isDisable
                
                if self.isDisableBool {
                    
                    $0.value = model?.phone
                    
                }
                
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.phone = value
                })
           
            <<< EmailRow() {
                $0.title = "邮箱"
                $0.placeholder = "📮"
                $0.disabled = self.isDisable
                
                if self.isDisableBool {
                    
                    $0.value = model?.mail
                    
                }
                
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.mail = value
                })
            
             +++ Section("密保问题")
            
            <<< TextRow() {
                $0.placeholder = "问题1 + 答案"
                $0.disabled = self.isDisable
                
                if self.isDisableBool {
                    
                    $0.value = model?.queA1
                    
                }
                
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.queA1 = value
                })
            <<< TextRow() {
                $0.placeholder = "问题2 + 答案"
                $0.disabled = self.isDisable
                
                if self.isDisableBool {
                    
                    $0.value = model?.queA2
                    
                }
                
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.queA2 = value
                })
            <<< TextRow() {
                $0.placeholder = "问题3 + 答案"
                $0.disabled = self.isDisable
                
                if self.isDisableBool {
                    
                    $0.value = model?.queA3
                    
                }
                
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.queA3 = value
                })
        
            
            
        +++ Section("备注")
        
            <<< TextAreaRow() {
                $0.placeholder = "备注信息"
                $0.disabled = self.isDisable
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 80)
                
                if self.isDisableBool {
                    
                    $0.value = model?.remarks
                    
                }
                
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.remarks = value
                })
        
            <<< DateRow(){
                $0.title = "最后编辑日期"
                if self.isDisableBool {
                    
                    $0.value = model?.lastDate
                    
                }else{
                $0.value = Date()
               self.model?.lastDate = Date()
                }
                
                
                let formatter = DateFormatter()
                formatter.locale = .current
                formatter.dateStyle = .short
                $0.dateFormatter = formatter
                $0.disabled = self.isDisable
                }.onChange({[weak self] (cell) in
                     guard let value = cell.value else {return}
                    self?.model?.lastDate = value
                })
        
        

    }
    
    
    @IBAction func actionAction(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        
    
        if model?.account != nil  && (model?.account.characters.count)! > 0 {
            
            if model?.nickName.isEmpty == true {
                model?.nickName = (model?.account)!
            }
            
        }else{
            
            SVProgressHUD.showError(withStatus: "账号不能为空")
             return
        }
        
        
        try! realm.write {
            model?.accoutType = 0
            realm.add(model!)
        }
        
        
       self.callBackRefresh!(true)
       let _ =  self.navigationController?.popViewController(animated: true)
        
    }
    
}


extension  FormViewController {

    

}

