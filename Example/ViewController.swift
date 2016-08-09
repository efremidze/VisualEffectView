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
            imageView.image = UIImage(data: try! Data(contentsOf: URL(string: "http://iphonewalls.net/wp-content/uploads/2014/09/Oil%20Painting%20Colorful%20Strokes%20iPhone%206%20Plus%20HD%20Wallpaper.jpg")!))
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var visualEffectView1: VisualEffectView! {
        didSet {
            visualEffectView1.tint(color: .green, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView2: VisualEffectView! {
        didSet {
            visualEffectView2.tint(color: .blue, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView3: VisualEffectView! {
        didSet {
            visualEffectView3.tint(color: .red, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView4: VisualEffectView! {
        didSet {
            visualEffectView4.tint(color: .yellow, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView5: VisualEffectView! {
        didSet {
            visualEffectView5.tint(color: .cyan, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView6: VisualEffectView! {
        didSet {
            visualEffectView6.tint(color: .magenta, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView7: VisualEffectView! {
        didSet {
            visualEffectView7.tint(color: .orange, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView8: VisualEffectView! {
        didSet {
            visualEffectView8.tint(color: .purple, blurRadius: 10)
        }
    }
    
    @IBAction func sliderChange(_ slider: UISlider) {
        let views = [visualEffectView1, visualEffectView2, visualEffectView3, visualEffectView4, visualEffectView5, visualEffectView6, visualEffectView7, visualEffectView8]
        views.forEach { $0?.blurRadius = CGFloat(slider.value) * 20 }
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
