//
//  ModalViewController.swift
//  Blur
//
//  Created by Lasha Efremidze on 5/25/16.
//  Copyright © 2016 Lasha Efremidze. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clearColor()
        
        let visualEffectView = CustomVisualEffectView()
        visualEffectView.colorTint = .redColor()
        visualEffectView.colorTintAlpha = 0.2
        visualEffectView.frame = self.view.bounds
        visualEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.view.insertSubview(visualEffectView, atIndex: 0)
    }

}
