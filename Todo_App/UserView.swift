//
//  UserView.swift
//  Todo
//
//  Created by user on 2023/12/06.
//

import SwiftUI

struct UserView: View {
    
    let image : Image
    let userName : String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("こんにちは")
                    .font(.footnote)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    
                Text("\(userName)")
                    .font(.title)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            }
            Spacer()
            image
                .resizable()
                .frame(width: 60,height: 60)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        }
        .padding()
        .background(Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)))
    }
}

#Preview {
    Group{
        UserView(image: Image("profile"), userName: "User Name")
    
    }
    
}
