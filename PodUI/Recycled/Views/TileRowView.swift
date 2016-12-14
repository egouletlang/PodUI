//
//  TileRowView.swift
//  PodUI
//
//  Created by Etienne Goulet-Lang on 12/13/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation
import BaseUtils

private let DESIRED_IMAGE_HEIGHT: CGFloat = 60
private let LABEL_HEIGHT: CGFloat = 15
private let PADDING: CGFloat = 5

open class TileRowView: BaseRowView {
    
    let imageView = BaseUIImageView(frame: CGRect.zero)
    let labelView = BaseUILabel(frame: CGRect.zero)
    
    // MARK: - Lifecycle -
    override open func createAndAddSubviews() {
        super.createAndAddSubviews()
        self.contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.contentView.addSubview(labelView)
    }
    override open func frameUpdate() {
        super.frameUpdate()
        
        let imageHeight = self.frame.height - LABEL_HEIGHT - PADDING
        
        
        self.imageView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.contentView.bounds.width,
            height: imageHeight)
        
        self.labelView.frame = CGRect(
            x: 0,
            y: imageHeight + PADDING,
            width: self.contentView.bounds.width,
            height: LABEL_HEIGHT)
    }
    
    override open func setData(model: BaseRowModel) {
        super.setData(model: model)
        if let m = model as? TileRowModel {
            self.imageView.load(str: m.imageUrl)
            if let m = model as? LabelRowModel {
                labelView.numberOfLines = m.titleNumberOfLines
                labelView.labelInformation = m.title
                
            }
        }
    }
    
    override open func getDesiredSize(model: BaseRowModel, forWidth w: CGFloat) -> CGSize {
        
        return CGSize(width: DESIRED_IMAGE_HEIGHT, height: DESIRED_IMAGE_HEIGHT + PADDING + LABEL_HEIGHT)
        
    }
    
}
