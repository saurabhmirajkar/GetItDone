//
//  ProtocolExt.swift
//  GetItDone
//
//  Created by Saurabh Mirajkar on 21/05/20.
//  Copyright © 2020 Saurabh Mirajkar. All rights reserved.
//

import Foundation

protocol TDHeaderViewDelegate {
    func openAddItemPopUp()
}

protocol TDNewItemDelegate {
    func addItemToList(text: String)
}
