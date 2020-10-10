//
//  NewItemPopUp.swift
//  GetItDone
//
//  Created by Saurabh Mirajkar on 30/05/20.
//  Copyright © 2020 Saurabh Mirajkar. All rights reserved.
//

import UIKit

class TDNewItemPopUp: TDGradient {
    
    let cancel = TDButton(title: "  cancel  ", type: .roundedText, radius: 4)
    let add = TDButton(title: "  add  ", type: .roundedText, radius: 4)
    let textfield = TDTextField(placeholder: "go buy IKEA frames", inset: 6)
    var delegate: TDNewItemDelegate?
    
    var popupLocation: CGFloat = 70
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animatePopUp)))
        
        let inset: CGFloat = 12
        
        self.layer.cornerRadius = 16
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(cancel)
        cancel.leftAnchor.constraint(equalTo: leftAnchor, constant: inset).isActive = true
        cancel.topAnchor.constraint(equalTo: topAnchor, constant: inset).isActive = true
        cancel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(add)
        add.rightAnchor.constraint(equalTo: rightAnchor, constant: -inset).isActive = true
        add.topAnchor.constraint(equalTo: topAnchor, constant: inset).isActive = true
        add.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(textfield)
        textfield.leftAnchor.constraint(equalTo: leftAnchor, constant: inset).isActive = true
        textfield.topAnchor.constraint(equalTo: add.bottomAnchor, constant: 8).isActive = true
        textfield.rightAnchor.constraint(equalTo: rightAnchor, constant: -inset).isActive = true
        textfield.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        add.addTarget(self, action: #selector(self.handleAdd), for: .touchUpInside)
        cancel.addTarget(self, action: #selector(self.handleCancel), for: .touchUpInside)
        
    }
    
    @objc func handleAdd() {
        if let delegate = self.delegate, let textFieldText = self.textfield.text  {
            delegate.addItemToList(text: textFieldText)
        }
    }
    
    @objc func handleCancel() {
        print("cancel button tapped")
        self.animatePopUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func animatePopUp() {
        textfield.resignFirstResponder()
        self.animateView(transform: CGAffineTransform(translationX: 0, y: popupLocation), duration: 0.3)
        if popupLocation == 70 {
            popupLocation = 0
        } else {
            popupLocation = 70
        }
    }
}
