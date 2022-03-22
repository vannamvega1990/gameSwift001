//
//  FTBaseTableView.swift
//  FinTech
//
//  Created by Tu Dao on 5/7/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class BaseTableView: UIView {
    
    @IBOutlet weak var tbv: UITableView!
    var numberRow:Int?
    var numberOfSections:Int?
    var heightForHeaderInSection:CGFloat?
    var heightOfCell:CGFloat = 0
    var heightForFooter:CGFloat?
    
    var heightForCellClorsure:((UITableView,IndexPath)->CGFloat)?
    var CreateCellClorsure:((UITableView,IndexPath)->UITableViewCell)?
    var didSelectedRowClosure:((UITableView,IndexPath) -> Void)?
    var hideSpactorCellVarible: Bool = false {
        didSet{
            tbv.separatorStyle = hideSpactorCellVarible ? .none : .singleLine
        }
    }
    
    var showHorizontalIndicator: Bool = true {
        didSet{
            tbv.showsHorizontalScrollIndicator = showHorizontalIndicator
        }
    }
    @IBInspectable
    var showVerticalIndicator: Bool = true {
        didSet{
            tbv.showsVerticalScrollIndicator = showHorizontalIndicator
        }
    }

    // register cell ---------------------------
    func registerCellWithNib(nib:UINib, idCell:String){
        tbv.register(nib, forCellReuseIdentifier: idCell)
    }
    // delegate datasure -------------------
    func setupDelegateDatasoucre(){
        tbv.delegate = self
        tbv.dataSource = self
    }
    // hide spactor cell -----------------------
    func hideSpactorCell(){
        tbv.separatorStyle = .none
    }
    // change background when click ------------------
    func setColorForCellWhenClick(_ tableView: UITableView, indexPath: IndexPath, color: UIColor){
        if let cell = tableView.cellForRow(at: indexPath) {
            //cell.contentView.backgroundColor = UIColor(white: 1, alpha: 0)
//            UIView.animate(withDuration: 0.3, animations: {
//                cell.contentView.backgroundColor = UIColor.darkGray
//            })
        }
    }
    // init ---------------------------
    override init(frame:CGRect){
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    var oldColorCell: UIColor?
    override func layoutSubviews() {
        super.layoutSubviews()
        //tbv.showsHorizontalScrollIndicator = showHorizontalIndicator
        tbv.showsHorizontalScrollIndicator = false
        tbv.showsVerticalScrollIndicator = false
    }
    
    private func config(){
        guard let view = self.FTloadViewFromNib(nibName: "BaseTableView") else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
        //configs()
        tbv.showsHorizontalScrollIndicator = false
        tbv.showsVerticalScrollIndicator = false
    }
    
}

extension BaseTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberRow ?? 1
    }
    
    func cellForRow(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = CreateCellClorsure?(tableView, indexPath)
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell{
           oldColorCell = cell.backgroundColor
        }
        
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellForRow(tableView, cellForRowAt: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectedRowClosure?(tableView,indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return heightOfCell
        return heightForCellClorsure?(tableView, indexPath) ?? heightOfCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return heightForFooter ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.white
        //cell.viewSelected.isHidden = false
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.layer.transform=CATransform3DMakeScale(0.1, 0.1, 1.0)
//        UIView.animate(withDuration: 0.5, animations: {
//            cell.layer.transform=CATransform3DMakeScale(1.0, 1.0, 1.0)
//        }, completion: nil)
        cell.layer.transform = CATransform3DMakeTranslation(0.1, 0.1, 1)
            //CGAffineTransform(translationX: 56, y: 0)
    }
    
    
}




