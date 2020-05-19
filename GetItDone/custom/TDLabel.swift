//
//  TDLabel.swift
//  GetItDone
//
//  Created by Saurabh Mirajkar on 19/05/20.
//  Copyright © 2020 Saurabh Mirajkar. All rights reserved.
//

import UIKit

class TDLabel: UILabel {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String = "default text", color: UIColor = .white, size: CGFloat = 16, textAlign: NSTextAlignment = .left, frame: CGRect = .zero) {
        super.init(frame: frame)
        
        if frame == .zero {
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.text = title
        self.textColor = color
        self.font = UIFont(name: "Raleway-Regular", size: size)
        self.textAlignment = textAlign
    }
    
}
