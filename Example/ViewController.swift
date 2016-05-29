//
//  ViewController.swift
//  Example
//
//  Created by Lasha Efremidze on 5/28/16.
//  Copyright © 2016 Lasha Efremidze. All rights reserved.
//

import UIKit
import VisualEffectView

class ViewController: UIViewController {
    
    @IBOutlet weak var visualEffectView1: VisualEffectView! {
        didSet {
            visualEffectView1.colorTint = .redColor()
            visualEffectView1.colorTintAlpha = 0.5
            visualEffectView1.blurRadius = 1
        }
    }
    
    @IBOutlet weak var visualEffectView2: VisualEffectView! {
        didSet {
            visualEffectView2.colorTint = .blueColor()
            visualEffectView2.colorTintAlpha = 0.5
            visualEffectView2.blurRadius = 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let visualEffectView = VisualEffectView()
//        visualEffectView.colorTint = .redColor()
//        visualEffectView.colorTintAlpha = 0.5
//        visualEffectView.blurRadius = 1
//        visualEffectView.frame = self.view.bounds
//        visualEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
//        self.view.addSubview(visualEffectView)
    }
    
}
