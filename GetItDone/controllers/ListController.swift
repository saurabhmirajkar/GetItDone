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
    
    let tbInset: CGFloat = 16
   
    lazy var bg: UIView = {
       let view = TDGradient()
        view.layer.cornerRadius = tbInset
        return view
    }()
    
    let listTable = TDTableView()
    let CELL_ID = "cell_id"
    
    var listData: [ToDo] = [ToDo]()
    
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
        
        listData = [
            ToDo(id: 0, title: "first item", status: false),
            ToDo(id: 1, title: "hey doodh", status: true),
            ToDo(id: 2, title: "let it rip!", status: true)
        ]
        
        view.backgroundColor = .white
        
        view.addSubview(header)
        header.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        header.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        view.addSubview(bg)
        bg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        bg.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
        bg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        bg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
        view.addSubview(listTable)
        listTable.leftAnchor.constraint(equalTo: bg.leftAnchor, constant: tbInset).isActive = true
        listTable.topAnchor.constraint(equalTo: bg.topAnchor, constant: tbInset).isActive = true
        listTable.rightAnchor.constraint(equalTo: bg.rightAnchor, constant: -tbInset).isActive = true
        listTable.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: -tbInset).isActive = true
        
        view.addSubview(popUp)
        popUp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        popUp.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        popUp.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        popUp.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        header.delegate = self
        popUp.textfield.delegate = self
        popUp.delegate = self
        
        listTable.delegate = self
        listTable.dataSource = self
        listTable.register(TDListCell.self, forCellReuseIdentifier: CELL_ID)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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

extension ListController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "To Do"
        }
        return "Done"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleForHeader = TDLabel(color: .white, size: 20, frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
        if section == 0 {
            titleForHeader.text = "To Do"
        } else {
            titleForHeader.text = "Done"
        }
        return titleForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        self.listData.forEach { (toDo) in
            if section == 0 && !toDo.status {
                count += 1
            } else if section == 1 && toDo.status {
                count += 1
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! TDListCell
        
        cell.box.delegate = self
        
        var itemsForSection : [ToDo] = []
        self.listData.forEach { (toDo) in
            if indexPath.section == 0 && !toDo.status {
                itemsForSection.append(toDo)
            } else if indexPath.section == 1 && toDo.status {
                itemsForSection.append(toDo)
            }
        }
        
        cell.toDo = itemsForSection[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
    
}

extension ListController : TDListCellDelegate {
    
    func toggleToDo(id: Int, status: Bool) {
        
        let newListData = self.listData.map { (toDo) -> ToDo in
            if toDo.id == id {
                var newToDo = toDo
                newToDo.status = status
                return newToDo
            }
            return toDo
        }
        
        self.listData = newListData
        self.listTable.reloadData()
    }
    
}
