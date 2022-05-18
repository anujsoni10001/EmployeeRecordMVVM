//
//  EmployeeViewModel.swift
//  EmployeeRecord
//
//  Created by Anuj Soni on 18/05/22.
//

import Foundation
import CoreData

class EmployeeViewModel:ObservableObject{
    
public static let shared = EmployeeViewModel()
        
@Published var mobileno: String = ""
@Published var name: String = ""
@Published var selectedEmployeeType: EmployeeType = EmployeeType.fulltime
@Published var email: String = ""
@Published var gender: String = "Male"
@Published var employees:[Employee] = []
    
func getAllEmployees(){
    employees = PersistenceController.shared.getAllEmployees()
}
    
func save(){
    let employee = Employee(context:PersistenceController.shared.viewContext)
    employee.name = name
    employee.gender = gender
    employee.mobileno = mobileno
    employee.email = email
    employee.type = selectedEmployeeType.rawValue.capitalized
    PersistenceController.shared.save()
}

func delete(_ employee:Employee){
let existingEmployee = PersistenceController.shared.getEmployeeById(id:employee.objectID)
if let existingEmployee = existingEmployee{
PersistenceController.shared.deleteEmployee(employee: existingEmployee)
}
}
}



