//
//  Router.swift
//  app-tasks-swiftui
//
//  Created by joel on 24/03/24.
//

import Foundation
import SwiftUI
final class Router : ObservableObject{
    public enum Destination: Codable{
        case login
        case profile(id:String)
        case formTask(id: Task)
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
