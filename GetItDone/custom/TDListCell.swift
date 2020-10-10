//
//  TDTableCell.swift
//  GetItDone
//
//  Created by Saurabh Mirajkar on 01/06/20.
//  Copyright © 2020 Saurabh Mirajkar. All rights reserved.
//

import UIKit

class TDListCell: UITableViewCell {
    
    var delegate: TDListCellDelegate?
    
    @objc func toggleStatus() {
        if let delegate = self.delegate, let toDo = self.toDo {
//            let newToDo = ToDo(id: toDo.id, title: textField.text!, status: !toDo.status)
//            delegate.toggleToDo(updatedToDo: newToDo)
            CoreDataManager.shared.deleteToDo(id: toDo.id)
            CoreDataManager.shared.createToDo(id: toDo.id, title: textField.text!, status: !toDo.status)
            delegate.toggleToDo()
        }
    }
    
//    let titleLabel = TDLabel(color: .grayZero, size: 14)
    let textField = TDTextField(placeholder: "ToDo", radius: 0, inset: 14)
    
    let view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var toDo: ToDo? {
        didSet {
            if let toDo = toDo {
                self.box.toggled = toDo.status
                self.textField.text = toDo.title
            }
        }
    }
    
    let box = TDCheckbox()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        box.addTarget(self, action: #selector(self.toggleStatus), for: .touchUpInside)
        
        view.backgroundColor = .white
        
        addSubview(view)
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor, constant: 3).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
        
        addSubview(textField)
        textField.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        
        addSubview(box)
        box.rightAnchor.constraint(equalTo: rightAnchor, constant: -14).isActive = true
        box.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        box.widthAnchor.constraint(equalToConstant: 22).isActive = true
        box.heightAnchor.constraint(equalTo: box.widthAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
