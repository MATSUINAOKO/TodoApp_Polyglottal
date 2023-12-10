import SwiftUI

struct CheckItem: View {
    //UserDataのインスタンス化,@EnvironmentObjectをつけているので、変更したらviewも更新可能
    @EnvironmentObject var userData: UserData
    @State private var selectedCategory: String?
    @State private var isPresentingTaskEdit = false
    @State private var selectedTask: Task?
    //Deleteボタンの色
    let gradient_Del = Gradient(stops: [.init(color: Color.yellow, location: 0.0), .init(color: Color.red, location: 0.8)])

    var body: some View {
        
        NavigationView {
            List {
                //userDataの中からcategoryがworkのものだけ表示
                ForEach(userData.tasks.filter { $0.category == "work" }) { task in
                    Button(action: {
                        self.selectedTask = task
                        self.isPresentingTaskEdit.toggle()
                    }) {
                        ListRow(task: task.title, isCheck: task.checked)
                    }
                }
                //isEditingがfalseだったらDraftWiewを表示
                if self.userData.isEditing {
                    Draft(selectedCategory: $selectedCategory)
                } else {
                    Button(action: {
                        self.userData.isEditing = true
                    }) {
                        Text("+")
                            .font(.title)
                    }
                }
            }
            //一覧表のタイトル表示
            .navigationTitle(Text("Tasks"))
            .navigationBarItems(trailing: Button(action: {
                DeleteTask()
            }) {
                Image(systemName: "trash")
                    .padding()
                    .frame(width: 60, height: 60)
                    .imageScale(.large)
                    .foregroundColor(Color.white)
                    .background(gradient_Del)
                    .clipShape(Circle())
            })
            .sheet(isPresented: $isPresentingTaskEdit) {
                TaskEditView(task: $selectedTask, isPresented: $isPresentingTaskEdit)
                    .environmentObject(userData)
            }
        }
    }

    var filteredTasks: [Task] {
        if let selectedCategory = selectedCategory {
            return userData.tasks.filter { $0.category == selectedCategory }
        } else {
            return userData.tasks
        }
    }

    func DeleteTask() {
        // userDataのtasksのcheckedがついていないものを削除
        let necessaryTask = self.userData.tasks.filter {
            !$0.checked
        }
        self.userData.tasks = necessaryTask
    }
}

struct CheckItem_Previews: PreviewProvider {
    static var previews: some View {
        CheckItem()
            .environmentObject(UserData())
    }
}
