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
            visualEffectView1.tint(.greenColor())
            visualEffectView1.round()
        }
    }
    
    @IBOutlet weak var visualEffectView2: VisualEffectView! {
        didSet {
            visualEffectView2.tint(.blueColor())
            visualEffectView2.round()
        }
    }
    
    @IBOutlet weak var visualEffectView3: VisualEffectView! {
        didSet {
            visualEffectView3.tint(.yellowColor())
            visualEffectView3.round()
        }
    }

    @IBOutlet weak var visualEffectView4: VisualEffectView! {
        didSet {
            visualEffectView4.tint(.redColor())
            visualEffectView4.round()
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

extension VisualEffectView {
    
    func tint(color: UIColor) {
        self.colorTint = color
        self.colorTintAlpha = 0.2
        self.blurRadius = 4
    }
    
    func round() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.masksToBounds = true
    }
    
}
