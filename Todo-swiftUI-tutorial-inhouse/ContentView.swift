//
//  ContentView.swift
//  Todo-swiftUI-tutorial-inhouse
//
//  Created by Michele Byman on 2020-11-24.
//

import SwiftUI

struct ContentView: View {
    @State var todos = [Todo]()
    @State var task = ""
    
    private func addTodo() {
        self.todos.append(Todo(name: task))
        task = ""
    }
    
    func deleteTodo(at offset: IndexSet) {
        todos.remove(atOffsets: offset)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add Todo", text: $task)
                    Button(action: addTodo) {
                        Text("Add todo")
                    }
                }
                List {
                    ForEach(todos) { todo in
                        Text(todo.name)
                    }
                    .onDelete(perform: deleteTodo )
                }
                
            }.padding()
            .navigationBarTitle("To Do LIst", displayMode: .inline)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
