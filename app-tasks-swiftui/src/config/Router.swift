//
//  Router.swift
//  app-tasks-swiftui
//
//  Created by joel on 24/03/24.
//

import Foundation
import SwiftUI
final class Router : ObservableObject{
    public enum Destination: Codable,Hashable{
        case login
        case home
        case formTask(task: Task?)
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination){
        navPath.append(destination)
    }
    
    func navigateBack(){
        navPath.removeLast()
    }
    
    func navigateToRoot(){
        navPath.removeLast(navPath.count)
    }
    
}
