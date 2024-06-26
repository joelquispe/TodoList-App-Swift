//
//  app_tasks_swiftuiApp.swift
//  app-tasks-swiftui
//
//  Created by joel on 26/11/23.
//

import SwiftUI

@main
struct app_tasks_swiftuiApp: App {
    @ObservedObject var router = Router()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath){
                LoginView()
                    .navigationDestination(for: Router.Destination.self){destination in
                    switch destination {
                    case .login:
                        LoginView()
                    case .home:
                        HomeView()
                    case .formTask(let task):
                        FormTaskView(task: task)
                    
                   
                    }
                    
                }
            
                
            }
                
            
        }.environmentObject(router)
    }
}
