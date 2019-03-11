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
    
    @IBOutlet var blurImageViews: [BlurImageView]! {
        didSet {
            for (blurImageView, color) in zip(blurImageViews, UIColor.allCases) {
                blurImageView.image = UIImage(named: "swift")
                blurImageView.contentMode = .center
                blurImageView.visualEffectView.tint(color, blurRadius: 2)
            }
        }
    }
    
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.thumbTintColor = .white
            slider.minimumTrackTintColor = .white
            slider.maximumTrackTintColor = .white
        }
    }
    
    @IBAction func sliderChange(_ slider: UISlider) {
        for blurImageView in blurImageViews {
            blurImageView.visualEffectView.blurRadius = CGFloat(slider.value)
        }
    }
    
}

class BlurImageView: UIImageView {
    lazy var visualEffectView: VisualEffectView = { [unowned self] in
        let view = VisualEffectView()
        self.addSubview(view)
        view.constrainToEdges()
        return view
    }()
}

extension VisualEffectView {
    func tint(_ color: UIColor, blurRadius: CGFloat) {
        self.colorTint = color
        self.colorTintAlpha = 0.5
        self.blurRadius = blurRadius
    }
}
