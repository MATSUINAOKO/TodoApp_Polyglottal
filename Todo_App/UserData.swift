//
//  UserData.swift
//  Todo_App
//
//  Created by user on 2023/12/07.
//

import SwiftUI

//ObservableObjectで上位のViewなどから渡されたインスタンスを参照する
class UserData : ObservableObject{
    //tasksのインスタンス作成 @Publishedで他のViewからも参照できる
    @Published var tasks = [
        Task(title: "ペインポイント洗い出し", checked: true, category: "work"),
        Task(title: "アプリの仕様検討", checked: false, category: "work"),
        Task(title: "言語選択", checked: true, category: "work"),
        Task(title: "環境設定", checked: false, category: "work"),
        Task(title: "住民票を取りに行く", checked: true, category: "home"),
        Task(title: "牛乳", checked: true, category: "home")
    ]
    @Published var isEditing : Bool = false
}
