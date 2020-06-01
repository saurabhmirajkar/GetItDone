//
//  TDTextField.swift
//  GetItDone
//
//  Created by Saurabh Mirajkar on 30/05/20.
//  Copyright © 2020 Saurabh Mirajkar. All rights reserved.
//

import UIKit

class TDTextField: UITextField {
    
    var insets: UIEdgeInsets!
    
    init(frame: CGRect = .zero, placeholder: String = "placeholder", radius: CGFloat = 4, inset: CGFloat = 0) {
        super.init(frame: frame)
        checkIfAutoLayout()
         
        self.placeholder = placeholder
        self.backgroundColor = .white
        self.layer.cornerRadius = radius
        self.insets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0)
        self.textColor = .grayZero
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.insets)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.insets)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
