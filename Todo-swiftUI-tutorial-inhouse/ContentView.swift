//
//  ContentView.swift
//  Todo-swiftUI-tutorial-inhouse
//
//  Created by Michele Byman on 2020-11-24.
//

import SwiftUI
import Firebase

struct ContentView: View {
    let ref = Database.database().reference()
    @State var todos = [Todo]()
//    @State var task = ""
    @State var isDone = false
//    @State var descriptionText = ""

    
    var body: some View {
        NavigationView {
            
            
            VStack(alignment: .leading)  {
                List {
                    ForEach(todos) { todo in
                        HStack {
                            Image("michele").resizable().frame(width: 40, height:40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            VStack(alignment: .leading) {
                                todo.isDone  ? Text(todo.name).font(.body).strikethrough() : Text(todo.name).font(.body)
                                Text(todo.description).font(.caption2).lineLimit(3)
                            }
                            Spacer()
                            Button(action: {updateTodo(id: todo.id)}) {
                                Image(systemName: todo.isDone ?  "checkmark.circle.fill" : "circle").imageScale(.large)
                            }.foregroundColor(todo.isDone ? .green : .orange)
                        }
                    }
                    .onDelete(perform: deleteTodo )
                }
                
                .listStyle(PlainListStyle())
                
                
            }.padding()
            
            .onAppear() {
                loadTodos()
            }
            .navigationBarTitle("To Do List")
            .navigationBarItems(trailing: NavigationLink(destination: AddTodoView()) {Image(systemName: "plus").imageScale(.large)})
        }.accentColor(.orange)
    }
    
   
    
    func deleteTodo(at offsets: IndexSet) {
        //        let idsToDelete = offsets.map { self.todos[$0].id }
        //               let toDelete = idsToDelete[0]
        //               ref.child("todo").child(toDelete).removeValue()
        offsets.forEach {
            self.ref.child("todo").child(todos[$0].id).removeValue()
        }
        loadTodos()
    }
    
    func updateTodo(id:String) {
        isDone.toggle()
        ref.child("todo").child(id).updateChildValues(["isDone": isDone])
        loadTodos()
    }
    
    func loadTodos() {
        ref.child("todo").observeSingleEvent(of: .value, with: { (snapshot) in
            //                print("-------------",snapshot.children)
            var temporaryTodos = [Todo]()
            for child in snapshot.children {
                
                let childData = child as! DataSnapshot
                //                    print(childData)
                let childDictionary = childData.value as! [String : AnyObject]
                //                    print("-111111111",childDictionary)
                var tempTodo = Todo(name: childDictionary["name"]! as! String, description: childDictionary["description"]! as! String, isDone: childDictionary["isDone"]! as! Bool )
                tempTodo.id = childData.key
                temporaryTodos.append(tempTodo)
            }
            
            todos = temporaryTodos
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
