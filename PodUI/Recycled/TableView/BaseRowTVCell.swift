//
//  BaseRowTVCell.swift
//  Phoenix
//
//  Created by Etienne Goulet-Lang on 9/23/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

open class BaseRowTVCell: UITableViewCell, BaseRowViewDelegate {
    
    public init(reuseIdentifier: String) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open class func buildReuseIdentifier(id: String, width: CGFloat) -> String {
        return "\(id)_\(width)"
    }
    
    open class func build(id: String, width: CGFloat) -> BaseRowTVCell {
        if LabelRowModel.isLabelRowModel(id: id) {
            return LabelRowTVCell(reuseIdentifier: buildReuseIdentifier(id: id, width: width))
        } else if AsynchronousRowModel.isAsynchronousRowModel(id: id) {
            return AsynchronousRowTVCell(reuseIdentifier: buildReuseIdentifier(id: id, width: width))
        } else if GenericLabelRowModel.isGenericLabelRowModel(id: id) {
            return GenericLabelRowTVCell(reuseIdentifier: buildReuseIdentifier(id: id, width: width))
        } else if ImageLabelRowModel.isImageLabelRowModel(id: id) {
            return ImageLabelRowTVCell(reuseIdentifier: buildReuseIdentifier(id: id, width: width))
        } else if CardRowModel.isCardRowModel(id: id) {
            return CardRowTVCell(reuseIdentifier: buildReuseIdentifier(id: id, width: width))
        } else if ImageRowModel.isImageRowModel(id: id) {
            return ImageRowTVCell(reuseIdentifier: buildReuseIdentifier(id: id, width: width))
        } else if CarouselRowModel.isCarouselRowModel(id: id) {
            return CarouselRowTVCell(reuseIdentifier: buildReuseIdentifier(id: id, width: width))
        }

//        else if GenericLabelRowModel.isGenericLabelRowModel(id: id) {
//            return GenericLabelRowTVCell(reuseIdentifier: buildReuseIdentifier(id: id, width: width))
//        } else if SummaryRowModel.isSummaryRowModel(id: id) {
//            return SummaryRowTVCell(reuseIdentifier: buildReuseIdentifier(id: id, width: width))
//        } else if HtmlRowModel.isHtmlRowModel(id: id) {
//            return HtmlRowTVCell(reuseIdentifier: buildReuseIdentifier(id: id, width: width))
        return BaseRowTVCell(reuseIdentifier: "BASE")
    }
    
    open lazy var cell: BaseRowView = {
        self.createCell()
    }()
    
    open func createCell() -> BaseRowView {
        return BaseRowView(frame: CGRect.zero)
    }
    
    open func createLayout() {
        self.contentView.addSubview(cell)
        cell.baseRowViewDelegate = self
    }
    open func getHeight(model: BaseRowModel) -> CGFloat {
        let h = model.getContainerHeight()
        return (h > 2) ? h : 2
    }
    open func getDesiredSize(model: BaseRowModel, forWidth width: CGFloat) -> CGSize {
         let effWidth = width - model.padding.left - model.padding.right
        return CGSize(width: width, height: cell.getDesiredSize(model: model, forWidth: effWidth).height)
    }
    open func setData(model: BaseRowModel, forWidth width: CGFloat) {
        cell.setData(model: model)
        cell.frame.size = CGSize(width: width, height: self.getHeight(model: model))
    }
    open func setFrame() {
        cell.frameUpdate()
    }
    
    override open var canBecomeFocused: Bool {
        get {
            return false
        }
    }
    
    // MARK: - BaseRowViewDelegate Methods -
    open weak var baseRowTVCellDelegate: BaseRowTVCellDelegate?
    public func active(view: BaseRowView) {
        self.baseRowTVCellDelegate?.active(view: view)
    }
    public func tapped(model: BaseRowModel, view: BaseRowView) {
        self.baseRowTVCellDelegate?.tapped(model: model, view: view)
    }
    public func longPressed(model: BaseRowModel, view: BaseRowView) {
        self.baseRowTVCellDelegate?.longPressed(model: model, view: view)
    }
    public func submitArgsValidityChanged(valid: Bool) {
        self.baseRowTVCellDelegate?.submitArgsValidityChanged(valid: valid)
    }
    
    public func submitArgsChanged() {
        self.baseRowTVCellDelegate?.submitArgsChanged()
    }
}
