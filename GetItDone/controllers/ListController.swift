//
//  ListController.swift
//  GetItDone
//
//  Created by Saurabh Mirajkar on 19/05/20.
//  Copyright © 2020 Saurabh Mirajkar. All rights reserved.
//

import UIKit

class ListController: UIViewController, TDHeaderViewDelegate, TDNewItemDelegate {
    
    func openAddItemPopUp() {
        print("trying to open add item popup view")
    }
    
    func addItemToList(text: String) {
        print("text in textfield is: \(text)")
    }
    
    let header = TDHeaderView(title: "Stuff to get done", subTitle: "10 left")
    let popUp = TDNewItemPopUp()
    
    var keyboardHeight: CGFloat = 333
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        self.keyboardHeight = keyboardSize.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(header)
        header.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        header.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        view.addSubview(popUp)
        popUp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        popUp.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        popUp.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        popUp.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        header.delegate = self
        popUp.textfield.delegate = self
        popUp.delegate = self
    }
    
}

extension ListController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        popUp.animateView(transform: CGAffineTransform(translationX: 0, y: -keyboardHeight), duration: 0.5)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        popUp.animateView(transform: CGAffineTransform(translationX: 0, y: 0), duration: 0.6)
    }
    
}
