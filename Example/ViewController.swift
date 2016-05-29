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
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "https://octodex.github.com/images/welcometocat.png")!)!)
        }
    }
    
    @IBOutlet weak var visualEffectView1: VisualEffectView! {
        didSet {
            visualEffectView1.colorTint = .greenColor()
            visualEffectView1.colorTintAlpha = 0.2
            visualEffectView1.blurRadius = 4
        }
    }
    
    @IBOutlet weak var visualEffectView2: VisualEffectView! {
        didSet {
            visualEffectView2.colorTint = .blueColor()
            visualEffectView2.colorTintAlpha = 0.2
            visualEffectView2.blurRadius = 4
        }
    }
    
    @IBOutlet weak var visualEffectView3: VisualEffectView! {
        didSet {
            visualEffectView3.colorTint = .yellowColor()
            visualEffectView3.colorTintAlpha = 0.2
            visualEffectView3.blurRadius = 4
        }
    }

    @IBOutlet weak var visualEffectView4: VisualEffectView! {
        didSet {
            visualEffectView4.colorTint = .redColor()
            visualEffectView4.colorTintAlpha = 0.2
            visualEffectView4.blurRadius = 4
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
