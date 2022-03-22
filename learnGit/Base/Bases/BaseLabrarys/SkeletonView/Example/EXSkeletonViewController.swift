//
//  EXSkeletonViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/9/21.
//  Copyright © 2021 Vega. All rights reserved.
//


import UIKit


class EXSkeletonViewController: BaseViewControllers {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let viewSke = BaseSkeletonView()
        viewSke.frame = CGRect(x: 98, y: 98, width: 189, height: 98)
        viewSke.backgroundColor  = .red
        let lb = UILabel()
        lb.backgroundColor = .green
        lb.frame = viewSke.bounds.resizeAtCenter(offsetX: 16, offsetY: 16)
        viewSke.addSubview(lb)
        viewSke.setLoading(true)
        view.addSubview(viewSke)
    }
}

