//
//  UserTask.swift
//  Todo_App
//
//  Created by user on 2023/12/07.
//

import SwiftUI

//Identifiableで　配列　Taskの作成
struct Task: Identifiable, Equatable{
    //id は自動　UUID()
    let id = UUID()
    var title : String
    var checked : Bool
    var category :String
    
    init(title: String, checked: Bool, category:String){
        self.title = title
        self.checked = checked
        self.category = category
    }
}
