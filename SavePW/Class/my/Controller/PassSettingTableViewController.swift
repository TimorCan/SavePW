//
//  PassSettingTableViewController.swift
//  SavePW
//
//  Created by zhoucan on 2016/12/27.
//  Copyright © 2016年 verfing. All rights reserved.
//

import UIKit

class PassSettingTableViewController: UITableViewController {

    
    
    @IBOutlet weak var numSwitch: UISwitch!
    
    @IBOutlet weak var figSwitch: UISwitch!
    
    @IBOutlet weak var closeSwitch: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numSwitch.isOn = HMUserDefaults.isOpenNumSwitch
        figSwitch.isOn = HMUserDefaults.isOpenfigSwitch
        
        if HMUserDefaults.isOpenNumSwitch == false && HMUserDefaults.isOpenfigSwitch == false {
            closeSwitch.isOn = false
        }
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return super.numberOfSections(in: tableView)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return super.tableView(tableView, numberOfRowsInSection: section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    

        return super.tableView(tableView, cellForRowAt: indexPath)
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if  segue.identifier == "szmm" {
            
            let vc = segue.destination as! SZMMTableViewController
            vc.callBackSuccess = { [weak self] success in
              
                if success {
                   self?.closeSwitch.isOn = false
                   self?.numSwitch.isOn = success
                    HMUserDefaults.isOpenNumSwitch = success
                }
                
                
            
            
            }
        }
        
        
    }
 
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        switch sender.tag {
            case 100:
            
            print("数字密码")
            
            if sender.isOn {
                
                //跳转设置
                
                
                sender.isOn = false
                HMUserDefaults.isOpenNumSwitch = sender.isOn
                self.performSegue(withIdentifier: "szmm", sender: nil)
            }
            
            
            
            case 200:
                if sender.isOn {
                    closeSwitch.isOn = false
                }
            print("指纹密码")
            
            HMUserDefaults.isOpenfigSwitch = sender.isOn
            
            case 300:
                if sender.isOn {
                    
                    figSwitch.isOn = false
                    numSwitch.isOn = false
                    
                    HMUserDefaults.isOpenfigSwitch = false
                    HMUserDefaults.isOpenNumSwitch = false
                    HMUserDefaults.saveNumber = ""
                    
                }
            print("关闭密码")
            
        default:
            
            print("error - 密码")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
