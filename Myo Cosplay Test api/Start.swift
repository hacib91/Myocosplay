//
//  Start.swift
//  Myo Cosplay Test api
//
//  Created by haseeb khalid on 26/07/2016.
//  Copyright © 2016 haseeb khalid. All rights reserved.
//

import Foundation
import UIKit

class Start : UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topColor = UIColor(red: (14/255.0), green: (48/255.0), blue: (94/255.0), alpha: 1)
        let bottomColor = UIColor(red: (44/255.0), green: (130/255.0), blue: (189/255.0), alpha: 1)
        
        let gradientColors : [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
