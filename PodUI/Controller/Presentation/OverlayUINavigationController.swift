//
//  OverlayUINavigationController.swift
//  Wand
//
//  Created by Etienne Goulet-Lang on 10/6/15.
//  Copyright © 2015 Heine Frifeldt. All rights reserved.
//

import Foundation



class OverlayUINavigationController: BaseUINavigationController, UIViewControllerTransitioningDelegate, OverlayPresentationControllerDelegate {
    
    func allowVcStackTransition() -> Bool {
        return false
    }
    
    override func initialize() {
        super.initialize()
        
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
        
    }
    var servicePresentationControllerLayout: OverlayPresentationController?
    
    // MARK: - UIViewControllerTransitioningDelegate methods -
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        if presented == self {
            servicePresentationControllerLayout = OverlayPresentationController(presentedViewController: presented, presenting: source)
            servicePresentationControllerLayout?.allowVcStackTransition = self.allowVcStackTransition()
            self.presentationHook()
            servicePresentationControllerLayout?.overlayPresentationControllerDelegate = self
            return servicePresentationControllerLayout
        }
        
        return nil
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented == self {
            let allowVcStackTransition = !self.allowVcStackTransition()
            return OverlayPresentationAnimationController(isPresenting: true, allowSpringyAnimation: allowVcStackTransition)
        }
        else {
            return nil
        }
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if dismissed == self {
            let allowVcStackTransition = !self.allowVcStackTransition()
            return OverlayPresentationAnimationController(isPresenting: false, allowSpringyAnimation: allowVcStackTransition)
        }
        else {
            return nil
        }
    }
    
    
    // MARK:  - Size -
    func presentationHook() {
        
    }
    func getMinBorderSize() -> CGSize {
        return OverlayPresentationController.DEFAULT_MIN_BORDER_SIZE
    }
    func setRequiredSize(size: CGSize) {
        // Compare the container size to the required frame size to calculate the insets
        if let pc = servicePresentationControllerLayout {
            pc.setRequiredSize(size: size, borderSize: getMinBorderSize())
            pc.containerView?.setNeedsLayout()
        }
    }
    func setKeyboardHeight(height: CGFloat) {
        if let pc = servicePresentationControllerLayout {
            pc.setKeyboardHeight(keyboardHeight: height)
            pc.containerView?.setNeedsLayout()
        }
    }
    func setNoRequiredSize() {
        if let pc = servicePresentationControllerLayout {
            let w = UIScreen.main.bounds.width
            let h = UIScreen.main.bounds.height
            let s = (h > w) ? h : w
            pc.setRequiredSize(size: CGSize(width: s, height: s), borderSize: getMinBorderSize())
            pc.containerView?.setNeedsLayout()
        }
    }
    func isLargerSizeRequired(size: CGSize) -> (Bool, CGSize) {
        if let currSize = servicePresentationControllerLayout?.frameOfPresentedViewInContainerView.size {
            //Do the bounds contain this?
            
            let update = (size.width > currSize.width) || (size.height > currSize.height)
            let size = CGSize(width: max(size.width, currSize.width), height: max(size.height, currSize.height))
            return (update, size)
        }
        return (true, size)
    }
    func getContentFrameSize() -> CGSize? {
        return servicePresentationControllerLayout?.frameOfPresentedViewInContainerView.size
    }
    
    
    // MARK: - OverlayPresentationControllerDelegate -
    func cleanOrSave() {
        cleanUp()
    }
    func cleanUp() {
        let vcs = self.viewControllers
        self.servicePresentationControllerLayout = nil
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        self.cleanUp()
        super.dismiss(animated: flag, completion: completion)
    }
    
}

