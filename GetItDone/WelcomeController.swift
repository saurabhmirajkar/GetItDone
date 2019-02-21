//
//  ViewController.swift
//  GetItDone
//
//  Created by Saurabh Mirajkar on 21/02/19.
//  Copyright © 2019 Saurabh Mirajkar. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    let bg : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cyan
        view.layer.cornerRadius = 6
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("you are in view did load")
        view.backgroundColor = .white
        
        view.addSubview(bg)
        bg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        bg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        bg.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        bg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        
        
    }


}

