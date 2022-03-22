//
//  FTBaseTableView.swift
//  FinTech
//
//  Created by Tu Dao on 5/7/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class FTBaseTableView: BaseView {
    
    @IBOutlet weak var tbv: UITableView!
    var numberRow:Int?
    var numberOfSections:Int?
    var heightForHeaderInSection:CGFloat?
    var heightOfCell:CGFloat = 0
    var heightForHeaderInSectionClorsure:((UITableView,Int)->CGFloat)?
    var heightForFooter:CGFloat? = nil
    
    var viewForHeaderInSection:Int=0
    
    var CreateCellClorsure:((UITableView,IndexPath)->UITableViewCell)?
    var didSelectedRowClosure:((UITableView,IndexPath) -> Void)?
    var hideSpactorCellVarible: Bool = false {
        didSet{
            tbv.separatorStyle = hideSpactorCellVarible ? .none : .singleLine
        }
    }
    
    func registerCellWithNib(nib:UINib, idCell:String){
        tbv.register(nib, forCellReuseIdentifier: idCell)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func registerCell(){
        tbv.register(UINib(nibName: "infoPersionTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func hideSpactorCell(){
        tbv.separatorStyle = .none
    }
    func setBackgroundColor(color: UIColor){
        backgroundColor = color
    }
    override init(frame:CGRect){
        super.init(frame: frame)
        cauhinh()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        cauhinh()
    }
    var rootView = UIView()
    private func cauhinh(){
        guard let view = self.FTloadViewFromNib(nibName: "FTBaseTableView") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        self.addSubview(rootView)
        //configs()
        tbv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        if #available(iOS 15.0, *){
            tbv.sectionHeaderTopPadding = 0.0
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        
    }
    func resizeHeightTableview(){
        tbv.estimatedRowHeight=64
        tbv.rowHeight=UITableView.automaticDimension
        tbv.reloadData()
        heightConstraint?.constant = tbv.contentSize.height
        layoutIfNeeded()
    }
    func reload(){
        tbv.reloadData()
    }
    func delegateDatasource(completion: @escaping () -> Void){
        tbv.delegate = self
        tbv.dataSource = self
        completion()
    }
    
  
}

extension FTBaseTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections ?? 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberRow ?? 1
    }
    
    func cellForRow(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = CreateCellClorsure?(tableView, indexPath)
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellForRow(tableView, cellForRowAt: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectedRowClosure?(tableView,indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightOfCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderInSectionClorsure?(tableView, section) ?? 0
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
        //        let v = UIView()
        //        switch viewForHeaderInSection {
        //        case 1:
        //            v.backgroundColor = .black
        //            break
        //        case 2:
        //            v.backgroundColor = .white
        //            break
        //        case 3:
        //            v.backgroundColor = .clear
        //            break
        //        default:
        //            break
        //        }
        //        return v
        
//        let headerView = UITableViewHeaderFooterView()
//        let contentView = headerView.contentView
    
        let v = UIView()
        let height = heightForHeaderInSectionClorsure?(tableView, section) ?? 0
        //v.frame = CGRect(origin: .zero, size: CGSize(width: windowFix.bounds.width, height: 0.01))
        v.frame = CGRect(origin: .zero, size: CGSize(width: windowFix.bounds.width, height: CGFloat.leastNormalMagnitude))
        //contentView.addSubview(v)
        //v.frame = contentView.bounds
        switch viewForHeaderInSection {
        case 1:
            v.backgroundColor = .black
            break
        case 2:
            v.backgroundColor = .white
            break
        case 3:
            v.backgroundColor = .clear
            break
        default:
            v.backgroundColor = .white
            break
        }
        return v
    }
    
}


