//
//  TaskViewModel.swift
//  app-tasks-swiftui
//
//  Created by joel on 29/11/23.
//

import Foundation


final class TaskViewModel: ObservableObject{
    var keyPersistData = "tasks"
    @Published var tasks = [Task]()
    
    init() {
        getData()
    }
    
    func getData(){
        if let tasks = UserDefaults.standard.object(forKey:self.keyPersistData ) as? Data{
            do{
                let decoder = JSONDecoder()
                let dataDecoder = try decoder.decode([Task].self, from: tasks)
                self.tasks = dataDecoder
            }catch{
                print(error)
            }
        }
    }
    
    func removeTask(id:String)-> Bool?{
        let newTasks = self.tasks.filter { data in
            return data.id != id
        }
        let isSaveData = saveData(tasks: newTasks)
        return isSaveData
    }
    
    func saveData(tasks: [Task])-> Bool?{
        do{
            let encodedData = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(encodedData, forKey: self.keyPersistData)
            return true
        }catch{
            print("Ocurrio un problema al guardar la tarea")
        }
        return nil
    }
}
