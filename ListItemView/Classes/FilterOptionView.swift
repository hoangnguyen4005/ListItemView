//
//  FilterOptionView.swift
//  FilterOptionView
//
//  Created by Chi Hoang on 12/10/20.
//  Copyright © 2020 Hoang Nguyen Chi. All rights reserved.
//

import UIKit

enum ThemeColor {
    static let darkBlue = #colorLiteral(red: 0, green: 0.4588235294, blue: 0.6901960784, alpha: 1)
    static let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

public protocol FilterOptionViewDelegate: class {
    func didSelected(_ filterOptionView: FilterOptionView)
}


public class FilterOptionView: UIView {
    static let font: UIFont = UIFont.systemFont(ofSize: 14.0)
    public weak var delegate: FilterOptionViewDelegate?
    @IBOutlet weak var label: UILabel!

    public var title: String? {
        get {
            return self.label.text
        }
        set(value) {
            self.label.text = value
        }
    }
    public var isSelected: Bool = false {
        didSet {
            if isSelected {
                self.backgroundColor = ThemeColor.darkBlue
                self.label.textColor = ThemeColor.white
            } else {
                self.backgroundColor = ThemeColor.white
                self.label.textColor = ThemeColor.darkBlue
            }
        }
    }
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    /// :nodoc:
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// :nodoc:
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        _ = fromNib(nibName: String(describing: FilterOptionView.self), isInherited: true)
        self.layer.cornerRadius = 8.00
        self.layer.borderWidth = 1.0
        self.layer.borderColor = ThemeColor.darkBlue.cgColor
        self.label.font = FilterOptionView.font
        self.isSelected = false
    }

    @IBAction func eventClickItem(_ sender: Any) {
        self.delegate?.didSelected(self)
    }
}
