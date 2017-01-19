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
import AVFoundation

enum AddType : Int {
    case nomarl = 0
    case card = 1
    case camera = 2
}


class EurekaLogoView: UIView {
    
    var imageView:UIImageView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(image: UIImage(named: "jiqimao.jpg"))
        imageView?.frame = CGRect(x: 0, y: 0, width: 320, height: 180)
        imageView?.autoresizingMask = .flexibleWidth
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
        imageView?.contentMode = .scaleAspectFit
        self.addSubview(imageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}


// MARK: - 扩展父类
extension FormViewController
{
    


}
//拍照存储
class SPAddCameraVC: FormViewController {
    
    var contentImages:Array = [UIImage]()
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
       
        
        
        if self.isDisableBool ==  false{
           
            
            self.navigationItem.rightBarButtonItem = nil
            let bar = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action:#selector(editorClick))
        
         self.navigationItem.rightBarButtonItem = bar
        }
        
        
        
        
        
        
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
        
            +++ Section(){
                $0.tag = "EurekaLogoView"
                
                var footer = HeaderFooterView<EurekaLogoView>(.class)
                
                footer.onSetupView = { logo,_ in
                 
                    if self.isDisableBool && self.model?.imageData != nil{
                        
                        
                        
                     logo.imageView?.image = UIImage.init(data: (self.model?.imageData)!)
                    }
                    
                 
                }
                
                $0.footer = footer
                
                
            }

            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "添加照片"
                
               
                }
                .onCellSelection { [weak self] (cell, row) in
                    self?.getAuth()
        }

        
        
    }
    
    
    func getAuth()  {
        
        
        let alertController = UIAlertController.init(title: "存储相片", message: "", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (_) in
            
        }
        
        let confirmAction = UIAlertAction.init(title: "拍照", style: .default) { [weak self](_) in
            
            if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) == AVAuthorizationStatus.denied{
              
//                SVProgressHUD.showError(withStatus: "获取相机权限失败")
                 self?.showAlertWithCameraAuth()
                
                return
            
            }
            
             self?.AddPhotoClick(sourceType: .camera)
            
        }
        let confirmAction1 = UIAlertAction.init(title: "相册", style: .default) {[weak self] (_) in
           self?.AddPhotoClick(sourceType: .photoLibrary)
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
         alertController.addAction(confirmAction1)
        present(alertController, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    func showAlertWithCameraAuth()  {
        let alertController = UIAlertController.init(title: "无法拍摄", message: "拍照功能被限制,\n请到设置-相机打开", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction.init(title: "以后再设置", style: .cancel) { (_) in
            
        }
        
        let confirmAction = UIAlertAction.init(title: "去设置", style: .default) { (_) in
            
            //跳转到设置界面
            UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
            
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)

    }
    
    
    //FIXME: 点击添加图片按钮
    fileprivate func AddPhotoClick(sourceType:UIImagePickerControllerSourceType){
        //1.判断照片控制器是否可用 ,不可用返回
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        //2.创建照片控制器
        let picVc = UIImagePickerController()
        //3.设置控制器类型
        picVc.sourceType = sourceType
        //4.设置是否可以管理已经存在的图片或者视频
        picVc.allowsEditing = true
        //5.设置代理
        picVc.delegate = self
        //6.弹出控制器
        present(picVc, animated: true, completion: nil)
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
        let _ =  self.navigationController?.popToRootViewController(animated: true)    }
    
    
    
    @objc fileprivate func editorClick(){
    
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SPAddCameraVC")
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    
    }
    

}


extension SPAddCameraVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //这里获取xiang
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        contentImages.removeAll()
        
        contentImages.append(image)
        
        let section:Section =  form.sectionBy(tag: "EurekaLogoView")!
        var footer = HeaderFooterView<EurekaLogoView>(.class)
        
        footer.onSetupView = { logo,_ in
            
           logo.imageView?.image = self.contentImages.first
          
           self.model?.imageData = UIImagePNGRepresentation(self.contentImages.first!)
            
        }
        
        section.footer = footer
        
        section.reload()
        
        
        picker.dismiss(animated: true, completion: nil)
        
        
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
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

