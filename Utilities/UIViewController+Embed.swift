//
//  UIViewController+Embed.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import UIKit

extension UIViewController {
    public func embed(_ childViewController: UIViewController?,
                      over view: UIView? = nil) {
        guard let child = childViewController,
              let view = view ?? self.view
        else { return }
        
        child.view.frame = view.bounds
        child.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(child.view)
        child.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        child.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        child.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        addChild(child)
        child.didMove(toParent: self)
    }
    
    public func unembedFromParent() {
        view.removeFromSuperview()
        removeFromParent()
        didMove(toParent: nil)
    }
}
