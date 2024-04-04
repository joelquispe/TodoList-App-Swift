//
//  Task.swift
//  app-tasks-swiftui
//
//  Created by joel on 27/11/23.
//

import Foundation

struct Task : Codable,Hashable{
    var id  :String;
    var title:String;
    var description:String;
    var isSuccess:Bool;
    
    mutating func setTitle(_ title:String){
        self.title = title
    }
    
    mutating func setDescription(_ description:String){
        self.description = description
    }
}
