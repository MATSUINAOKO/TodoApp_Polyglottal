//
//  ListRow.swift
//  ›Todo_App
//
//  Created by user on 2023/12/07.
//

import SwiftUI

struct ListRow: View {
    let task : String
    var isCheck : Bool
    
    var body: some View {
        HStack {
            if isCheck{
                Text("☑️")
                Text(task)
                    .strikethrough()
                    .fontWeight(.ultraLight)
            }else{
                Text("▫️")
                Text(task)
            }
        }
    }
}

#Preview {
    ListRow(task: "料理",isCheck: true)
}
