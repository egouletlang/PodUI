//
//  BaseRowUITableViewDelegate.swift
//  Phoenix
//
//  Created by Etienne Goulet-Lang on 9/23/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation
import CoreGraphics

@objc
public protocol BaseRowUITableViewDelegate: NSObjectProtocol {
    func tapped(model: BaseRowModel, view: BaseRowView)
    func longPressed(model: BaseRowModel, view: BaseRowView)
    @objc optional func newScrollOffset(offset: CGFloat)
    @objc optional func canCollectAndSubmitArgs(set: Bool)
    
    /// Any submit arg was changed in one of the elements
    @objc optional func submitArgsChanged()
}
