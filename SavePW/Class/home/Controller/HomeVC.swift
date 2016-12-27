//
//  HomeVC.swift
//  SavePW
//
//  Created by zhoucan on 2016/12/26.
//  Copyright © 2016年 verfing. All rights reserved.

import UIKit

class HomeVC: UIViewController {
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var isSelectAll:Bool = false
    
    @IBOutlet weak var deleteBarButtonItem: UIBarButtonItem!
    @IBOutlet var noDataLabel: UILabel!
    @IBOutlet var toolView: UIToolbar!
    
    //当前进入的值
    //是否点击TableView还是“+”
    var currentModel:SPAccountModel?
    var isADD:Bool = false
    
    var dataSources = [SPAccountModel]()
    //选中
    var selectSources = [SPAccountModel](){
     
        didSet{
        
            if selectSources.count == 0 {
              
                deleteBarButtonItem.isEnabled = false
                
            }else{
             
                deleteBarButtonItem.isEnabled = true
            
            }
        
        }
      
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.tableFooterView = UIView()
        
        //检测键盘 notice
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        self.searchBar.delegate = self
        //load 本地缓存
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(HomeVC.loadTotalCache), for: .valueChanged)
        self.tableView.addSubview(refresh)
        refresh.tag = 1000
        refresh.beginRefreshing()
        self.loadTotalCache()
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func keyboardWillShow()  {
        
        self.searchBar.showsCancelButton = true
        
    }
    
    
    func keyboardWillHide()  {
        
         self.searchBar.showsCancelButton = false
        
    }
    
    func keyboardDidHide() {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    func hideKeyBoard(){
        self.view.endEditing(true)
        
    }
    
    @IBAction func goNextVC(_ sender: UIBarButtonItem) {
        
        isADD = true
        
        let alertController = UIAlertController.init(title: "hello", message: "添加类型账号类型", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (_) in
            
        }
        
        let type1 = UIAlertAction.init(title: "网络账号等", style: .default) { (_) in
            
            //动态segue跳转
            self.performSegue(withIdentifier: "SPAddVC", sender: nil)
        }
        let type2 = UIAlertAction.init(title: "银行卡", style: .default) { (_) in
            //动态segue跳转
            self.performSegue(withIdentifier: "SPAddYHKVC", sender: nil)
            
        }
        let type3 = UIAlertAction.init(title: "图片", style: .default) { (_) in
            
            //动态segue跳转
            self.performSegue(withIdentifier: "SPAddCameraVC", sender: nil)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(type1)
        alertController.addAction(type2)
        alertController.addAction(type3)
        
        present(alertController, animated: true, completion: nil)

        
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //跳转传值走下面
        if segue.identifier == "SPAddYHKVC" {
          
             let addVC = segue.destination as! SPAddYHKVC
             addVC.hidesBottomBarWhenPushed = true
            if isADD{
                addVC.isDisable = false
                addVC.callBackRefresh = { hasRefresh in
                    
                    self.loadTotalCache()
                    
                }
            }else{
                addVC.isDisable = true
                addVC.isDisableBool = true
                addVC.model = currentModel
            }
            
        }else if segue.identifier == "SPAddCameraVC" {
            
            let addVC = segue.destination as! SPAddCameraVC
            addVC.hidesBottomBarWhenPushed = true
            if isADD{
                addVC.isDisable = false
                addVC.callBackRefresh = { hasRefresh in
                    
                    self.loadTotalCache()
                    
                }
            }else{
                addVC.isDisable = true
                 addVC.isDisableBool = true
                addVC.model = currentModel
            }
            
        }else if segue.identifier == "SPAddVC" {
            
            let addVC = segue.destination as! SPAddVC
            addVC.hidesBottomBarWhenPushed = true
            if isADD{
                addVC.isDisable = false
                addVC.callBackRefresh = { hasRefresh in
                    
                    self.loadTotalCache()
                    
                }
            }else{
                addVC.isDisable = true
                 addVC.isDisableBool = true
                addVC.model = currentModel
            }
            
        }

        
    }
    
   
    
    
    
   

}

// MARK: - Action
extension HomeVC{
    @IBAction func editorAction(_ sender: Any) {
        
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.tableView.isEditing = !self.tableView.isEditing
        
        if self.tableView.isEditing {
            
            
            self.view.addSubview(self.toolView)
            
            self.toolView.frame = CGRect.init(x: 0, y: UIConstant.SCREEN_HEIGHT, width: UIConstant.SCREEN_WIDTH, height: 44)
            UIView.animate(withDuration: 0.5, animations: {
                self.toolView.frame.origin.y =  self.toolView.frame.origin.y - 44
                self.navigationController?.tabBarController?.tabBar.frame.origin.y =  (self.navigationController?.tabBarController?.tabBar.frame.origin.y)! + 64
            })
            
            
        }else{
         
          
            UIView.animate(withDuration: 0.5, animations: {
                self.toolView.frame.origin.y =  self.toolView.frame.origin.y + 44
                self.navigationController?.tabBarController?.tabBar.frame.origin.y =  (self.navigationController?.tabBarController?.tabBar.frame.origin.y)! - 64
            })
            self.toolView.removeFromSuperview()
            
        }
        
        
        
    }
    
    //全选
    @IBAction func allSelectAction(_ sender: Any) {
        
        if  isSelectAll == false {
         
            self.tableView.isEditing = false
            
            UIView.animate(withDuration: 0.5, animations: {
                self.toolView.frame.origin.y =  self.toolView.frame.origin.y + 44
                self.navigationController?.tabBarController?.tabBar.frame.origin.y =  (self.navigationController?.tabBarController?.tabBar.frame.origin.y)! - 64
            })
            self.toolView.removeFromSuperview()
            
        }
        
        
        
    }
    
    //选中删除
    @IBAction func deleteSelected(_ sender: Any) {
        
       let data = Array.init(self.dataSources)
        
         self.dataSources.removeAll()
         self.dataSources = data.filter { (model) -> Bool in
            
            if selectSources.contains(model){
               return false
            }
            
            return true
            
        }
        
        for item in self.selectSources{
        
            try! realm.write {
                realm.delete(item)
            }
            
        }
        
        self.selectSources.removeAll()
        self.tableView.reloadData()
        
        
    }
    
    


}
// MARK: - 数据处理
extension HomeVC{
 
    func loadTotalCache(){
        
        let realmData = realm.objects(SPAccountModel.self)
        self.dataSources.removeAll()
        self.dataSources.append(contentsOf: realmData)
        self.tableView.reloadData()
        
        let refresh = self.tableView.viewWithTag(1000) as! UIRefreshControl
        
        refresh.endRefreshing()
        
    
    }
    
    func loadCache(by condition:String){
        
//        let predicate = NSPredicate(format: "color = %@ AND name BEGINSWITH %@", "棕黄色", "大")
//        tanDogs = realm.objects(Dog).filter(predicate)
        let predicate = NSPredicate(format:"nickName CONTAINS %@",condition)
         let realmData = realm.objects(SPAccountModel.self).filter(predicate)
        self.dataSources.removeAll()
        self.dataSources.append(contentsOf: realmData)
        self.tableView.reloadData()
        
        
    }

}

// MARK: - UISearchBarDelegate
extension HomeVC:UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideKeyBoard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        if !searchText.isEmpty{
        
          self.loadCache(by: searchText)
        }
        
        
    }
    
    
}

// MARK: - UITableViewDataSource,UITableViewDelegate
extension HomeVC:UITableViewDataSource,UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if dataSources.count == 0 {
            
           self.view.insertSubview(noDataLabel, aboveSubview: self.tableView)
            noDataLabel.center = self.tableView.center
        }else{
        
         self.view.insertSubview(noDataLabel, belowSubview: self.tableView)
            noDataLabel.center = self.tableView.center

        }
        
        
        
        
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifer = "home-cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifer)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identifer)
        }
        
        cell?.textLabel?.text = dataSources[indexPath.row].nickName
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let model = dataSources[indexPath.row]
        
        if !tableView.isEditing{
           tableView.deselectRow(at: indexPath, animated: true)
            isADD = false
            currentModel = model
            
            if currentModel?.accoutType == 0 {
                 self.performSegue(withIdentifier: "SPAddVC", sender: nil)
            }else if currentModel?.accoutType == 1 {
            
                self.performSegue(withIdentifier: "SPAddYHKVC", sender: nil)

            }else if currentModel?.accoutType == 2 {
                self.performSegue(withIdentifier: "SPAddCameraVC", sender: nil)
                
            }
            
            
            
            
            
        }else{
            
            if !selectSources.contains(model) {
              selectSources.append(model)
            }
          
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if !tableView.isEditing{
            return
        }else{
         
            let model = dataSources[indexPath.row]
            
            if selectSources.contains(model) {
                let index = selectSources.index(of: model)
                selectSources.remove(at: index!)
            }

            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete {
        
            //删除缓存里的
            try! realm.write {
                 realm.delete(self.dataSources[indexPath.row])
            }
         
          //删除数据源的
          self.dataSources.remove(at: indexPath.row)
          
            //刷新表
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        
        
    }
    
    

}

