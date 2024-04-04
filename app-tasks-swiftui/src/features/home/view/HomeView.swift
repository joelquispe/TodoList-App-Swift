//
//  HomeView.swift
//  app-tasks-swiftui
//
//  Created by joel on 26/11/23.
//

import SwiftUI

struct HomeView: View {
    @State private var tfTextSearch  = ""
    @State private var isNavigateAddTask = false
    @State private var filterTasks = [Task]()
    @StateObject private var taskViewModel = TaskViewModel()
    @EnvironmentObject private var router: Router
    @Environment(\.dismiss) private var dismis
    func fillDataFilter(){
        self.filterTasks =  taskViewModel.tasks
    }
    var body: some View {
        
            ZStack{
                VStack{
                    TextField( text: $tfTextSearch,
                               label: {Text("Buscar")}).onChange(of: tfTextSearch, {
                        if tfTextSearch.isEmpty{
                            self.filterTasks = taskViewModel.tasks
                            return
                        }
                        filterTasks = taskViewModel.tasks.filter({ data in
                            data.title.lowercased().contains(tfTextSearch.lowercased())
                        })
                    }).padding(13).background(.gray.opacity(0.2)).cornerRadius(10)
                    List(self.filterTasks,id: \.id){
                        element in
                        HStack{
                            Button(action: {
                                self.router.navigate(to: .formTask(task: element))
                            }, label: {
                                VStack(alignment: .leading){
                                    Text(element.title)
                                    Text(element.description)
                                }
                            })
                            
                            Spacer()
                            Button(action: {
                                let isRemove = taskViewModel.removeTask(id: element.id)
                                
                                if isRemove == true{
                                    taskViewModel.getData()
                                    self.filterTasks = taskViewModel.tasks
                                }
                                
                            }, label: {
                                Image(systemName: "trash").font(.system(size: 22))
                            }).buttonStyle(PlainButtonStyle())
                            
                        }
                        
                    }.listStyle(PlainListStyle())
                        .onAppear(){
                            taskViewModel.getData()
                            
                            fillDataFilter()
                        }
                }.padding().background(.white)
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            self.router.navigate(to: .formTask(task: nil))
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                                .padding(16)
                        }).padding()
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    Text("Logout")
                })
           
        }
    }
}

#Preview {
    HomeView()
}
