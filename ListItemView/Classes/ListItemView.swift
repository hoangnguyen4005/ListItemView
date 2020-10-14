//
//  ListItemView.swift
//  ListItemView
//
//  Created by Chi Hoang on 12/10/20.
//  Copyright © 2020 Hoang Nguyen Chi. All rights reserved.
//

import UIKit

public protocol ListItemViewDelegate: class {
    func didSelected(_ filterView: ListItemView)
}

public class ListItemView: UIView, FilterOptionViewDelegate {
    private let bottomPadingSection: CGFloat = 8.0
    private let heightPerItem: CGFloat = 40.0
    private var actualHeight: CGFloat = 0.0

    public var maxX: CGFloat = 0.0
    public var leading: CGFloat = 0.0
    public weak var delegate: ListItemViewDelegate?

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: self.frame.width, height: actualHeight)
    }

    public var selectedItems: [String] = [] {
        didSet {
            if selectedItems.isEmpty {
                for view in self.subviews where view .isKind(of: FilterOptionView.self) {
                    guard let filterView =  view as? FilterOptionView else { return }
                    filterView.isSelected = false
                }
            } else {
                for item in self.selectedItems {
                    for view in self.subviews where view .isKind(of: FilterOptionView.self) {
                        guard let filterView =  view as? FilterOptionView,
                            let title = filterView.title  else {return}
                        if item == title {
                            filterView.isSelected = true
                            break
                        }
                    }
                }
            }
        }
    }

    public var items: [String] = [] {
        didSet {
            for view in self.subviews { view.removeFromSuperview() }
            let leftPading: CGFloat = 8.00
            var originX: CGFloat = 0.0
            var originY: CGFloat = 0.0
            for title in items {
                let width = title.width(withConstrainedHeight: heightPerItem,
                                        font: FilterOptionView.font)
                    + 16.00 * 2.0
                let temp = originX + width + leftPading + leading
                if temp > maxX {
                    originX = 0.0
                    originY += (heightPerItem + bottomPadingSection)
                }
                let frame =  CGRect(origin: CGPoint(x: originX,
                                                    y: originY),
                                    size: CGSize(width: width,
                                                 height: heightPerItem))
                let view = FilterOptionView(frame: frame)
                originX += (leftPading + width)
                view.title = title
                view.delegate = self
                self.addSubview(view)
            }
            self.actualHeight = originY + heightPerItem
        }
    }

    /// :nodoc:
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    private func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = false
    }

    public func didSelected(_ filterOptionView: FilterOptionView) {
        filterOptionView.isSelected = !filterOptionView.isSelected
        guard let title = filterOptionView.title else { return }
        let newOption = filterOptionView.isSelected
        if newOption {
            self.selectedItems.append(title)
        } else {
            self.selectedItems.removeAll(where: { $0 == title})
        }
        self.delegate?.didSelected(self)
    }

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews as [UIView] {
            if !subview.isHidden
               && subview.alpha > 0
               && subview.isUserInteractionEnabled
               && subview.point(inside: convert(point, to: subview), with: event) {
                 return true
            }
        }
        return false
    }
}
