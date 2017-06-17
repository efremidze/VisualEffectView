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
            visualEffectView1.tint(.red, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView2: VisualEffectView! {
        didSet {
            visualEffectView2.tint(.orange, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView3: VisualEffectView! {
        didSet {
            visualEffectView3.tint(.yellow, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView4: VisualEffectView! {
        didSet {
            visualEffectView4.tint(.green, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView5: VisualEffectView! {
        didSet {
            visualEffectView5.tint(.tealBlue, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView6: VisualEffectView! {
        didSet {
            visualEffectView6.tint(.blue, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView7: VisualEffectView! {
        didSet {
            visualEffectView7.tint(.purple, blurRadius: 10)
        }
    }
    
    @IBOutlet weak var visualEffectView8: VisualEffectView! {
        didSet {
            visualEffectView8.tint(.pink, blurRadius: 10)
        }
    }
    
    @IBAction func sliderChange(_ slider: UISlider) {
        let views = [visualEffectView1, visualEffectView2, visualEffectView3, visualEffectView4, visualEffectView5, visualEffectView6, visualEffectView7, visualEffectView8]
        views.forEach { $0?.blurRadius = CGFloat(slider.value) * 20 }
    }
    
}

extension VisualEffectView {
    
    func tint(_ color: UIColor, blurRadius: CGFloat) {
        self.colorTint = color
        self.colorTintAlpha = 0.5
        self.blurRadius = blurRadius
    }
    
}

private extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
    class var red: UIColor { return UIColor(red: 255, green: 59, blue: 48) }
    class var orange: UIColor { return UIColor(red: 255, green: 149, blue: 0) }
    class var yellow: UIColor { return UIColor(red: 255, green: 204, blue: 0) }
    class var green: UIColor { return UIColor(red: 76, green: 217, blue: 100) }
    class var tealBlue: UIColor { return UIColor(red: 90, green: 200, blue: 250) }
    class var blue: UIColor { return UIColor(red: 0, green: 122, blue: 255) }
    class var purple: UIColor { return UIColor(red: 88, green: 86, blue: 214) }
    class var pink: UIColor { return UIColor(red: 255, green: 45, blue: 85) }
}
