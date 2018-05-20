//
//  Memo.swift
//  
//
//  Created by 蒲生廣人 on 2018/04/30.
//

import UIKit
import RealmSwift

class Memo: Object {
    @objc dynamic var date = ""
    @objc dynamic var title = ""
    @objc dynamic var content = ""
}

let realm = try! Realm()

func addMemo(date: String, title: String, content: String) {
    let newMemo = Memo()
    newMemo.date = "2018/05/13"
    newMemo.title = "example"
    newMemo.content = "example content"
    try! realm.write {
        realm.add(newMemo)
    }
}
