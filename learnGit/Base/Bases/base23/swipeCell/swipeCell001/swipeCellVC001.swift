//
//  swipeCellVC001.swift
//  test001
//
//  Created by THONG TRAN on 20/03/2022.
//

import Foundation

import UIKit

class swipeCellVC001: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        tbv.register(UINib(nibName: "MailCell", bundle: nil), forCellReuseIdentifier: "MailCell")
        tbv.delegate = self
        tbv.dataSource = self
    }
    
    func createSelectedBackgroundView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MailCell") as! MailCell
        cell.delegate = self
        cell.selectedBackgroundView = createSelectedBackgroundView()
        
        let email = emails[indexPath.row]
        cell.fromLabel.text = email.from
        cell.dateLabel.text = email.relativeDateString
        cell.subjectLabel.text = email.subject
        cell.bodyLabel.text = email.body
        cell.bodyLabel.numberOfLines = usesTallCells ? 0 : 2
        cell.unread = email.unread
        
        return cell
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

extension swipeCellVC001: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let email = emails[indexPath.row]
        
        if orientation == .left {
            guard isSwipeRightEnabled else { return nil }
            
            let read = SwipeAction(style: .default, title: nil) { action, indexPath in
                let updatedStatus = !email.unread
                email.unread = updatedStatus
                
                let cell = tableView.cellForRow(at: indexPath) as! MailCell
                cell.setUnread(updatedStatus, animated: true)
            }
            
            read.hidesWhenSelected = true
            read.accessibilityLabel = email.unread ? "Mark as Read" : "Mark as Unread"
            
            let descriptor: ActionDescriptor = email.unread ? .read : .unread
            configure(action: read, with: descriptor)
            
            return [read]
        } else {
            let flag = SwipeAction(style: .default, title: nil, handler: nil)
            flag.hidesWhenSelected = true
            configure(action: flag, with: .flag)
            
            let delete = SwipeAction(style: .destructive, title: nil) { action, indexPath in
                self.emails.remove(at: indexPath.row)
            }
            configure(action: delete, with: .trash)
            
            let cell = tableView.cellForRow(at: indexPath) as! MailCell
            let closure: (UIAlertAction) -> Void = { _ in cell.hideSwipe(animated: true) }
            let more = SwipeAction(style: .default, title: nil) { action, indexPath in
                let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                controller.addAction(UIAlertAction(title: "Reply", style: .default, handler: closure))
                controller.addAction(UIAlertAction(title: "Forward", style: .default, handler: closure))
                controller.addAction(UIAlertAction(title: "Mark...", style: .default, handler: closure))
                controller.addAction(UIAlertAction(title: "Notify Me...", style: .default, handler: closure))
                controller.addAction(UIAlertAction(title: "Move Message...", style: .default, handler: closure))
                controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: closure))
                self.present(controller, animated: true, completion: nil)
            }
            configure(action: more, with: .more)
            
            return [delete, flag, more]
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = orientation == .left ? .selection : .destructive
        options.transitionStyle = defaultOptions.transitionStyle
        
        switch buttonStyle {
        case .backgroundColor:
            options.buttonSpacing = 4
        case .circular:
            options.buttonSpacing = 4
        #if canImport(Combine)
            if #available(iOS 13.0, *) {
                options.backgroundColor = UIColor.systemGray6
            } else {
                options.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
            }
        #else
            options.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
        #endif
        }
        
        return options
    }
    
    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
        action.title = descriptor.title(forDisplayMode: buttonDisplayMode)
        action.image = descriptor.image(forStyle: buttonStyle, displayMode: buttonDisplayMode)
        
        switch buttonStyle {
        case .backgroundColor:
            action.backgroundColor = descriptor.color(forStyle: buttonStyle)
        case .circular:
            action.backgroundColor = .clear
            action.textColor = descriptor.color(forStyle: buttonStyle)
            action.font = .systemFont(ofSize: 13)
            action.transitionDelegate = ScaleTransition.default
        }
    }
}
