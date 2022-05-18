//
//  Persistence.swift
//  EmployeeRecord
//
//  Created by Anuj Soni on 03/05/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<11 {
            let employee = Employee(context:viewContext)
            employee.id = UUID()
            employee.name = "Anuj Soni"
            employee.mobileno = "8962422004"
            employee.email = "doni381@gmail.com"
            employee.type = "Fulltime"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
            return container.viewContext
    }
    
    func getEmployeeById(id:NSManagedObjectID) -> Employee?{
        do{
        return try viewContext.existingObject(with:id) as? Employee
        }catch{
        return nil
        }
    }
    
    func deleteEmployee(employee:Employee){
        viewContext.delete(employee)
        save()
    }
    
    func getAllEmployees() -> [Employee] {
        
        let request: NSFetchRequest<Employee> = Employee.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func save() {
            do {
                try viewContext.save()
            } catch {
                viewContext.rollback()
                print(error.localizedDescription)
            }
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "EmployeeRecord")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

