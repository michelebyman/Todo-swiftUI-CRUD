//
//  AddTodoView.swift
//  Todo-swiftUI-tutorial-inhouse
//
//  Created by Michele Byman on 2020-11-25.
//

import SwiftUI
import Firebase

struct AddTodoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    
    let ref = Database.database().reference()
    @State var task = ""
    @State var descriptionText = ""
    @State var isError = false
    var todosItem = ["🧹","🪠","🪣", "🩺", "🛒", "🧺", "💌", "📲", "☎️", "✈️"].shuffled()
    
    var body: some View {
        
        VStack{
            ZStack(alignment: .leading) {
                if task.isEmpty { Text(isError ? "Add a To Do \(todosItem[0]) " : "Add Todo"  ).foregroundColor(.white ).padding(.leading) }
                TextField( "" ,text: $task)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 25)
                                .stroke(isError && task.isEmpty ? Color.red : Color.orange , lineWidth: 2)
                    )
                    .onChange(of: task, perform: { value in
                       isError = false 
                    })
    
            }.padding(.bottom, 30)

            
            ZStack(alignment: .leading) {
                if descriptionText.isEmpty { Text("Add Description").foregroundColor(.white).padding(.leading)}
                TextField( "" ,text: $descriptionText)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.orange, lineWidth: 2)
                    )
            }
            Spacer()
        }.padding(.horizontal)
        .padding(.top, -30)
        .navigationBarItems(
            trailing:
                Button(action: addTodo) {
                   Text("Done")
                    
                }
        )
        
        
        
        
    }
    
    private func addTodo() {
        if task == ""  {
            isError = true
            return
        }
        self.ref.child("todo").childByAutoId().setValue(["name": task, "description": descriptionText, "isDone": false])
        task = ""
        descriptionText = ""
        isError = false
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
