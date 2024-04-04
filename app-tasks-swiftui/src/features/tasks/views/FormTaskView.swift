//
//  AddTaskView.swift
//  app-tasks-swiftui
//
//  Created by joel on 27/11/23.
//

import SwiftUI
import SimpleToast
struct FormTaskView: View {
    var task : Task?
    private var taskViewModel = TaskViewModel()
    @Environment(\.dismiss) var dismiss;
    @EnvironmentObject private var router: Router
    @State private var tfTitle = ""
    @State private var tfDescription = ""
    @State private var showToast = false
    @State private var titleForm = "Crear Tarea"
    init(task: Task?) {
           self.task = task
    }
    private let toastOptions = SimpleToastOptions(
        hideAfter: 3
    )
    
    // agregar tarea
    func addTask(){
        taskViewModel.tasks.append(Task(id: UUID().uuidString, title: tfTitle, description: tfDescription, isSuccess: false))
        let isSave = taskViewModel.saveData(tasks: taskViewModel.tasks)
        if isSave != nil{
            taskViewModel.getData()
            showToast.toggle()
        }
    }
    //editar tarea
    func updateTask(){
        var updateTask = Task(id: self.task!.id, title: tfTitle, description: tfDescription, isSuccess: false)
        updateTask.setDescription(tfDescription)
        updateTask.setTitle(tfTitle)
        let index = taskViewModel.tasks.firstIndex { data in
            data.id == self.task!.id
        }
        taskViewModel.tasks[index!] = updateTask
        let isSave = taskViewModel.saveData(tasks: taskViewModel.tasks)
        if isSave != nil{
            showToast.toggle()
        }
        
    }
   func handleForm(){
        if self.task != nil {
            updateTask()
            print("update")
        }else{
            addTask()
        }
    }
    var body: some View {
       
            VStack{
                VStack(alignment: .leading){
                    Text("Titulo")
                    TextField( text: $tfTitle,
                               label: {Text("Titulo")}).padding(13).background(.gray.opacity(0.2)).cornerRadius(10)
                }
                Spacer().frame(height:20)
                VStack(alignment: .leading){
                    Text("Descripción")
                    TextField( text: $tfDescription,
                               label: {Text("Titulo")}).padding(13).background(.gray.opacity(0.2)).cornerRadius(10)
                }
                Spacer().frame(height:30)
                Button(action: {
                    handleForm()
                }, label: {
                    Text("Guardar")
                }).padding().background(.black).cornerRadius(10).foregroundColor(.white)
            }

            .padding().simpleToast(isPresented: $showToast, options: toastOptions) {
                Label("Tarea guardada", systemImage: "checkmark.circle.fill")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding(.top)
            }.onAppear(){
                
                if self.task != nil {
                    tfTitle = self.task!.title
                    tfDescription = self.task!.description
                }
                
            }
            .navigationBarBackButtonHidden()
            .navigationTitle(task != nil ? "Editar tarea" : "Crear tarea")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading, content: {
                        Text("Regresar")
                            .onTapGesture {
                                self.router.navigateBack()
                            }
                    })
                    
                }
    }
}

#Preview {
    
    FormTaskView(task: nil)
}
