import SwiftUI

struct Draft_Home: View {
    //ユーザーが入力した値を格納
    @State private var taskTitle = ""
    //TextFieldの初期値
    @State private var initialPlaceholder = "タスクを入力してください"
    
    //アプリ内で共有して使いたいから
    @EnvironmentObject var userData: UserData
    var selectedCategory: Binding<String?>

    var body: some View {
        HStack {
            TextField(initialPlaceholder, text: $taskTitle, onCommit: {
                print("onCommitハンドラが呼ばれました")
                //ユーザーがEnterで確定したら発動
                self.createTask()
                //isEditingの状態を変更することで+ボタンに戻す
                self.userData.isEditing = false
            })
            
            //.onAppearでユーザーが決定したタイミングを検知して、TextFieldの初期値を変更（一度入力すると、前の履歴が消えなかった対処
            .onAppear {
                self.taskTitle = self.initialPlaceholder
            }
            .foregroundColor(taskTitle == initialPlaceholder ? .gray : .black)
            .opacity(taskTitle == initialPlaceholder ? 0.5 : 1.0)
            .onChange(of: taskTitle) { newValue in
                if newValue == self.initialPlaceholder {
                    self.taskTitle = ""
                }
            }
        }
        .padding()
    }

    func createTask() {
         print("createTaskを通過できますか？")
//        guard let selectedCategoryValue = selectedCategory.wrappedValue else {
//            return
//        }
//workしか試さないことにします
        let newTask = Task(title: self.taskTitle, checked: false, category: "home")
        print("newTaskできますか？",newTask)
        self.userData.tasks.insert(newTask, at: 0)
    }
}

struct Draft_Home_Previews: PreviewProvider {
    static var previews: some View {
        Draft(selectedCategory: .constant(nil))
            .environmentObject(UserData())
    }
}

