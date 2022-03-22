//
//  swipeCellVC001.swift
//  test001
//
//  Created by THONG TRAN on 20/03/2022.
//

import Foundation

import UIKit

class name1: UITableViewController {
    
}

class swipeCellVC003: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tbv = UITableView()
    var emails = mockEmails
    var usesTallCells = false
    
    var isSwipeRightEnabled = true
    var defaultOptions = SwipeOptions()
    
    var buttonDisplayMode: ButtonDisplayMode = .titleAndImage
    var buttonStyle: ButtonStyle = .backgroundColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTbv()
    }
    
    func createTbv(){
        tbv.frame = view.bounds
        view.addSubview(tbv)
//        tbv.register(UINib(nibName: "MailCell", bundle: nil), forCellReuseIdentifier: "MailCell")
        tbv.delegate = self
        tbv.dataSource = self
    }
    
    func createSelectedBackgroundView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        return view
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
//        cell.delegate = self
        cell.selectedBackgroundView = createSelectedBackgroundView()
        
//        let email = emails[indexPath.row]
//        cell.fromLabel.text = email.from
//        cell.dateLabel.text = email.relativeDateString
//        cell.subjectLabel.text = email.subject
//        cell.bodyLabel.text = email.body
//        cell.bodyLabel.numberOfLines = usesTallCells ? 0 : 2
//        cell.unread = email.unread
        
        return cell
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

//extension swipeCellVC001: SwipeTableViewCellDelegate
