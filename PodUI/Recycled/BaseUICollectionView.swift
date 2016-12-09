//
//  BaseUICollectionView.swift
//  PodUI
//
//  Created by Etienne Goulet-Lang on 12/8/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation

class BaseUICollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.__initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var initialized = false
    private var currSize = CGSize.zero
    private func __initialize() {
        if !initialized {
            initialized = true
            self.initialize()
            self.createAndAddSubviews()
        }
    }
    
    override var frame: CGRect {
        didSet {
            self.frameDidSet()
        }
    }
    
    private func frameDidSet() {
        if self.currSize != self.frame.size {
            self.currSize = self.frame.size
            self.frameUpdate()
        }
    }
    
    func initialize() {}
    func createAndAddSubviews() {}
    func frameUpdate() {}
}
