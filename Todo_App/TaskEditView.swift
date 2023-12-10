//
//  TaskEditView.swift
//  Todo_App
//
//  Created by user on 2023/12/08.
//

import SwiftUI

// TaskEditView.swift

struct TaskEditView: View {
    ////UserDataのインスタンス化,@EnvironmentObjectをつけているので、変更したらviewも更新可能
    @EnvironmentObject var userData: UserData
    //@Bindingつけているので変更可能
    @Binding var task: Task?
    @Binding var isPresented: Bool
    //削除ボタンと保存ボタンの色
    let gradient_Del = Gradient(stops: [.init(color: Color.yellow, location: 0.0), .init(color: Color.red, location: 0.8)])
    
    let gradient_Patch = Gradient(stops: [.init(color: Color.green, location: 0.0), .init(color: Color.blue, location: 0.8)])

    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    HStack {
                        //askがnilでない場合にcheckedプロパティの値をtrue/falseを切り替え
                        Button(action: {
                            task?.checked.toggle()
                            print("Task Checked Toggled: \(task?.checked ?? false)")
                        }) {
                            //taskがnilでない場合にcheckedプロパティの値を取るが、nilの場合はfalseにする
                            Image(systemName: task?.checked ?? false ? "checkmark.square" : "square")
                                .imageScale(.large)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.2)
                        .padding()
                        //taskがnilでない場合titleプロパティの値を表示、titleプロパティが存在しない場合は""
                        TextField("Task Title", text: Binding(
                            get: { task?.title ?? "" },
                            //ユーザーがテキストを変更した時に呼び出しtaskのtitleに新しい値をセットする
                            set: { newValue in
                                task?.title = newValue
                                print("変更後のtaskの値: \(newValue)")
                            }
                        ))
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .multilineTextAlignment(.leading)
                    }
                }
            }
            
            .navigationBarItems(
                trailing: VStack {
                    Text("  ")
                    
                    
                    HStack {
                        
                        Button(action: {
                            deleteTask()
                            isPresented = false
                        }) {
    //                        Text("Delete")
                            Image(systemName: "trash")
                                .padding()
                                .frame(width: 60, height: 60)
                                .imageScale(.large)
                                .foregroundColor(Color.white)
                                .background(gradient_Del)
                                .clipShape(Circle())
                        }
                        Spacer().frame(width: 16)
                        Button(action: {
                            saveChanges()
                            isPresented = false
                        }) {
    //                        Text("Save")
                            Image(systemName: "square.and.arrow.down.on.square")
                                .padding()
                                .frame(width: 60, height: 60)
                                .imageScale(.large)
                                .foregroundColor(Color.white)
                                .background(gradient_Patch)
                                .clipShape(Circle())
                        }
                    }
                }
            )
            
            .onAppear {
                print("TaskEditView Appeared with task: \(task?.title ?? "nil")")
            }
        }
        .navigationTitle("Edit Task")
    }
    //保存ボタン処理
    private func saveChanges() {
        guard let editedTask = task else {
            print("保存時エラー：taskの値がnil")
            return
        }
        //Patch処理のため、元々のidを取得
        if let index = userData.tasks.firstIndex(where: { $0.id == editedTask.id }) {
            userData.tasks[index] = editedTask
            print("taskを上書き保存しました: \(editedTask.title)")
        } else {
            print("taskのidが見つかりませんでした")
        }
    }
    //削除ボタンの処理
    private func deleteTask() {
        guard let editedTask = task else {
            print("削除時エラー：taskの値がnil")
            return
        }
        //Delete処理のため、元々のidを取得
        userData.tasks.removeAll { $0.id == editedTask.id }
        print("taskを削除しました: \(editedTask.title)")
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(task: .constant(Task(title: "Sample Task", checked: false, category: "work")), isPresented: .constant(true))
            .environmentObject(UserData())
    }
}
