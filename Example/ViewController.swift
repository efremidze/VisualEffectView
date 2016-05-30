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
            imageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "https://upload.wikimedia.org/wikipedia/en/d/dc/IOS_9_Homescreen.png")!)!)
        }
    }
    
    @IBOutlet weak var visualEffectView1: VisualEffectView! {
        didSet {
            visualEffectView1.tint(.greenColor(), blurRadius: 5)
        }
    }
    
    @IBOutlet weak var visualEffectView2: VisualEffectView! {
        didSet {
            visualEffectView2.tint(.blueColor(), blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView3: VisualEffectView! {
        didSet {
            visualEffectView3.tint(.redColor(), blurRadius: 15)
        }
    }
    
    @IBOutlet weak var visualEffectView4: VisualEffectView! {
        didSet {
            visualEffectView4.tint(.yellowColor(), blurRadius: 20)
        }
    }
    
    @IBOutlet weak var visualEffectView5: VisualEffectView! {
        didSet {
            visualEffectView5.tint(.cyanColor(), blurRadius: 20)
        }
    }
    
    @IBOutlet weak var visualEffectView6: VisualEffectView! {
        didSet {
            visualEffectView6.tint(.magentaColor(), blurRadius: 15)
        }
    }
    
    @IBOutlet weak var visualEffectView7: VisualEffectView! {
        didSet {
            visualEffectView7.tint(.orangeColor(), blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView8: VisualEffectView! {
        didSet {
            visualEffectView8.tint(.purpleColor(), blurRadius: 5)
        }
    }
    
}

extension VisualEffectView {
    
    func tint(color: UIColor, blurRadius: CGFloat) {
        self.colorTint = color
        self.colorTintAlpha = 0.2
        self.blurRadius = blurRadius
        self.scale = 1
    }
    
}
