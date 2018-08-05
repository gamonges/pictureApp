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


func addMemo(date: String, title: String, content: String) {
    let realm = try! Realm()

    let newMemo = Memo()
    newMemo.date = date
    newMemo.title = title
    newMemo.content = content
    try! realm.write {
        realm.add(newMemo)
    }
}

func getMemoByDate(date: String){
    let theMemo:String = "hoge"
    print(theMemo)
    return
//    DispatchQueue(label: "background").async {
//        autoreleasepool {
//            let realm = try! Realm()
//            if(realm.objects(Memo.self).filter("date == \(date)").first != nil){
//                theMemo = (realm.objects(Memo.self).filter("date == \(date)").first?.title)!
//            }
//
//
//        }
//    }

    
}
