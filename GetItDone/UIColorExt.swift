//
//  UIColorExt.swift
//  GetItDone
//
//  Created by Saurabh Mirajkar on 18/05/20.
//  Copyright © 2020 Saurabh Mirajkar. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var blueZero: UIColor {
        return UIColor(rgb: 0x64E4FF)  // #64E4FF
    }
    
    static var blueOne: UIColor {
        return UIColor(rgb: 0x3A7BD5)  // #3A7BD5
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
}
