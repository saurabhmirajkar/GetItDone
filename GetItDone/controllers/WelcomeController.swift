//
//  ViewController.swift
//  GetItDone
//
//  Created by Saurabh Mirajkar on 21/02/19.
//  Copyright © 2019 Saurabh Mirajkar. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    let bg: UIView = {
       let view = TDGradient()
        view.layer.cornerRadius = 24
        return view
    }()
    
    let titleLabel = TDLabel(title: "GET IT DONE", size: 24, textAlign: .center)
    
    let infoLabel : UILabel = {
        let label = TDLabel(title: "WELCOME FOLKS!\nGET IT DONE IS A SIMPLE TO-DO LIST.\nIT IS LITERALLY A DOPE TO-DO LIST.", size: 14, textAlign: .center)
        label.numberOfLines = 0
        return label
    }()
    
    let nextButton = TDButton(title: "START WINNING", type: .roundedText)
    
    let copyrightLabel = TDLabel(title: "© 2020 | Saurabh Mirajkar", color: .grayOne, size: 14, textAlign: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("you are in view did load")
        view.backgroundColor = .white
        
        nextButton.addTarget(self, action: #selector(handleNext), for: [.touchUpInside, .touchUpOutside])
        
        view.addSubview(copyrightLabel)
        copyrightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        copyrightLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        copyrightLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        copyrightLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
                
        view.addSubview(bg)
        bg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        bg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        bg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        bg.bottomAnchor.constraint(equalTo: copyrightLabel.topAnchor, constant: -70).isActive = true
        
        bg.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: bg.topAnchor, constant: 60).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        bg.addSubview(infoLabel)
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: bg.leftAnchor, constant: 16).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: bg.rightAnchor, constant: -16).isActive = true
        
        bg.addSubview(nextButton)
        nextButton.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: -60).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }

    @objc func handleNext() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.nextButton.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.nextButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { (_) in
                let listVC = ListController()
                listVC.modalPresentationStyle = .fullScreen
                self.present(listVC, animated: true, completion: nil)
            }
        }
    }
    
}

