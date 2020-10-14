//
//  ViewController.swift
//  Example
//
//  Created by Chi Hoang on 30/4/20.
//  Copyright © 2020 Hoang Nguyen Chi. All rights reserved.
//

import UIKit
import ListItemView

class ViewController: UIViewController, ListItemViewDelegate {
    @IBOutlet weak var filterView: ListItemView!

    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.maxX = self.view.frame.width - 20.0
        filterView.leading = 20.0
        filterView.items = ["ALL", "IN", "US", "JP", "IN"]
        filterView.delegate = self
        createManually()
        print("size filterView: \(filterView.intrinsicContentSize)")
    }

    func createManually() {
        let manuallyView = ListItemView()
        manuallyView.maxX = self.view.frame.width - 20.0
        manuallyView.leading = 20.0
        manuallyView.items = ["ALL", "IRN", "USD", "JPY",
                              "EUR", "SGD", "VND", "DONG", "LAO"]
        manuallyView.selectedItems = ["IRN", "USD"]
        manuallyView.delegate = self
        self.view.addSubview(manuallyView)
        manuallyView.anchor(top: filterView.bottomAnchor,
                            leading: self.view.leadingAnchor,
                            bottom: nil,
                            trailing: self.view.trailingAnchor,
                            padding: UIEdgeInsets(top: 56.0,
                                                  left: 20,
                                                  bottom: 0,
                                                  right: 20),
                            size: .zero)
        print("size manuallyView: \(manuallyView.intrinsicContentSize)")

    }
    func didSelected(_ filterView: ListItemView) {
        if self.filterView == filterView {
            print("filterView: \(filterView.selectedItems)")
        } else {
            print("manuallyView: \(filterView.selectedItems)")
        }
    }
}

