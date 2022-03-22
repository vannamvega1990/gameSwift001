//
//  LinkSocialTableViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class LinkSocialTableViewController: BaseTableViewCanEdit {
    
    var dataArray: [SocialInfo] = [SocialInfo]() {
        didSet{
            //tableView.reloadData()
        }
    }
   
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //hiddenNavigation(isHidden: false)
        
        numberOfSections = dataArray.count
        numberRow = 1
        heightForHeaderInSection = 3
        hideSpactorCell()
        tableView.disableHeighlightCell()
        //enableEditCell = false
        let share = UITableViewRowAction(style: .normal, title: "Delete") {[weak self] action, index in
            print("share button tapped")
            if let self = self {
                //self.deleteSections(self.tableView, editActionsForRowAt: self.editRowAt!)
               
                
                if let access_token = CakeDefaults.shared.access_token {
                    let soscalId = self.dataArray[index.section].SocialId!
                    let socialType = self.dataArray[index.section].SocialType!
                    NetworkManager.shared.requestDisLinkSocial(access_token,soscalId,"\(socialType)",self.cucos)
                }
                
            }
        }
        share.backgroundColor = .orange
        actionEditRowArray = [share]
        registerCellWithNib(nib: UINib(nibName: "SocialTableViewCell", bundle: nil), idCell: "cell")
        CreateCellClorsure = { tbv, indexPath in
        let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SocialTableViewCell
            guard self.dataArray.count > 0 else {
                return cell
            }
            if let socialType = self.dataArray[indexPath.section].SocialType {
                cell.labelSocialType.text = "socialType: " +  "\(socialType)"
            }else{
                cell.labelSocialType.text = "socialType: "
            }
            cell.labelSocialId.text = "SocialId: " + (self.dataArray[indexPath.section].SocialId ?? "")
            cell.labelSocialTypeSub.text = "SocialTypeSub: " +  (self.dataArray[indexPath.section].SocialTypeSub ?? "")
            cell.labelSocialEmailOrMobile.text = "SocialEmailOrMobile: " +  (self.dataArray[indexPath.section].SocialEmailOrMobile ?? "")
            cell.labelSocialName.text = "SocialName: " +  (self.dataArray[indexPath.section].SocialName ?? "")
            return cell
        }
        heightForCellClorsure = { tbv, indexPath in
            return 156
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //hiddenNavigation(isHidden: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //hiddenNavigation(isHidden: true)
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }.
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension LinkSocialTableViewController {
    func cucos(_ data:Data?,_ response:URLResponse?,_ error: Error?)->Void{
        if let error=error{
            Commons.showDialogNetworkError()
            Commons.hideLoading(self.view)
            let mesell=error as NSError
            if -1009==mesell.code{
                DispatchQueue.main.async{
                    //AppDelegate.disconnected(self.view)
                    print("123")
                }
                DispatchQueue.main.asyncAfter(deadline:.now()+1.5){
                    //AppDelegate.reconnect()
                    print("123")
                }
            }
            return
        }
        
        guard let data = data else {
            Commons.hideLoading(self.view)
            Commons.showDialogAlert(title: "THÔNG BÁO", content: "Server không phản hồi", inView: self.view, didFinishDismiss: nil)
            return
        }
        //let shit = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        let shit = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        print(shit)
        
            if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
                Commons.hideLoading(self.view)
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                if code == 0 {
                    //self.numberOfSections! -= 1
                    self.dataArray.remove(at: self.editRowAt!.section)
                    numberOfSections = dataArray.count
                    self.tableView.deleteSectionsCustom(editActionsForRowAt: self.editRowAt!, completion: {
                        
                    })
                }
                
            }

        
    }
}
