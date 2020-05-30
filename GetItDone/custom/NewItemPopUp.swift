//
//  NewItemPopUp.swift
//  GetItDone
//
//  Created by Saurabh Mirajkar on 30/05/20.
//  Copyright © 2020 Saurabh Mirajkar. All rights reserved.
//

import UIKit

class NewItemPopUp: TDGradient {
    
    let cancel = TDButton(title: "  cancel  ", type: .roundedText, radius: 3)
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        let inset: CGFloat = 16
        
        self.layer.cornerRadius = 14
        
        addSubview(cancel)
        cancel.leftAnchor.constraint(equalTo: leftAnchor, constant: inset).isActive = true
        cancel.topAnchor.constraint(equalTo: topAnchor, constant: inset).isActive = true
        cancel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
