//
//  TDButton.swift
//  GetItDone
//
//  Created by Saurabh Mirajkar on 19/05/20.
//  Copyright © 2020 Saurabh Mirajkar. All rights reserved.
//

import UIKit

class TDButton: UIButton {
    
    var title: String!
    var type: ButtonOptions!
    var radius: CGFloat!
    
    init(title: String = "button text", frame: CGRect = .zero, type: ButtonOptions = .roundedText, radius: CGFloat = 20) {
        super.init(frame: .zero)
        
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.title = title
        self.type = type
        self.radius = radius
        self.phaseTwo()
        
    }
    
    func phaseTwo() {
        self.backgroundColor = .white
        if let titleLabel = self.titleLabel {
            titleLabel.font = UIFont(name: "Raleway-Regular", size: 16)
        }
        
        switch self.type {
            case .roundedText:
                self.roundedText()
            case .squareIcon:
                self.squareIcon()
            default:
                break
        }
    }
    
    func squareIcon() {
        self.setImage(UIImage(named: "add-icon"), for: .normal)
    }
    
    func roundedText() {
        self.layer.cornerRadius = self.radius
        self.setTitle(self.title, for: .normal)
        self.setTitleColor(.grayZero, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
