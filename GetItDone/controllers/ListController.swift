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
        popUp.animatePopUp()
    }
    
    func notInList(text: String) -> Bool {
        var isNotInList = true
        self.listData.forEach { toDo in
            if toDo.title == text {
                isNotInList = false
            }
        }
        return isNotInList
    }
    
    func addItemToList(text: String) {
        if !self.notInList(text: text) {
//            let newItem = ToDo(id: self.listData.count, title: text, status: false)
//            self.listData.append(newItem)
            CoreDataManager.shared.createToDo(id: Double(self.listData.count), title: text, status: false)
            self.listData = CoreDataManager.shared.fetchToDos()
            self.listTable.reloadData()
            updateHeaderItemsLeft()
            self.popUp.textfield.text = ""
            self.popUp.animatePopUp()
        } else {
            print("Item already present!")
        }
        
    }
    
    let header = TDHeaderView(title: "Stuff to get done", subTitle: "10 left")
    let popUp = TDNewItemPopUp()
    
    let tbInset: CGFloat = 16
    var bgBottom: NSLayoutConstraint!
   
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
        
        listData = CoreDataManager.shared.fetchToDos()
        
        self.updateHeaderItemsLeft()
        
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
        bgBottom = bg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        bgBottom.isActive = true
        
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
        
        self.openAddItemPopUp()
        
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
    
    var todoToUpdate: ToDo?
    
}



extension ListController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        var heightToAnimate = -keyboardHeight - 20
        
        if textField == popUp.textfield {
            popUp.animateView(transform: CGAffineTransform(translationX: 0, y: -keyboardHeight), duration: 0.5)
            heightToAnimate -= 80
        } else {
            self.todoToUpdate = CoreDataManager.shared.fetchToDo(title: textField.text!)
        }
        
        self.bgBottom.constant = heightToAnimate
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let heightToAnimate: CGFloat = -100
        
        if textField == popUp.textfield {
            popUp.animateView(transform: CGAffineTransform(translationX: 0, y: 0), duration: 0.6)
        } else {
            if let toDoToUpdate = self.todoToUpdate {
                CoreDataManager.shared.deleteToDo(id: toDoToUpdate.id)
                CoreDataManager.shared.createToDo(id: toDoToUpdate.id, title: textField.text!, status: toDoToUpdate.status)
            }
        }
        
        self.bgBottom.constant = heightToAnimate
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
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
        
        cell.delegate = self
        cell.textField.delegate = self
        
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
    
    func toggleToDo() {
        self.listData = CoreDataManager.shared.fetchToDos()
        self.listTable.reloadData()
        updateHeaderItemsLeft()
    }
    
}

extension ListController {
    
    func updateHeaderItemsLeft() {
        header.itemsLeft = 0
        _ = self.listData.map { (toDo) in
            if !toDo.status { header.itemsLeft += 1 }
        }
    }
    
}
