//
//  ContentView.swift
//  EmployeeRecord
//
//  Created by Anuj Soni on 03/05/22.
//

import SwiftUI
import CoreData

struct ContentView: View {

@Environment(\.managedObjectContext) var managedObjectContext

@FetchRequest(entity: Employee.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Employee.name, ascending: true)]) var employees: FetchedResults<Employee>
    
@State private var showingAddEmployeeView:Bool = false
    
var body: some View {
    
    NavigationView{
      List{
          ForEach(self.employees,id:\.self){item in
              HStack{
              Text(item.type ?? "Unknown")
              
              Spacer()
              }
        }
     }
    .navigationBarItems(trailing:
          Button{
              showingAddEmployeeView.toggle()
          } label: {
              Image(systemName:"plus")
          }
          .sheet(isPresented:$showingAddEmployeeView){
              AddEmployeeView().environment(\.managedObjectContext,self.managedObjectContext)
          }
      )
     .navigationTitle("Employee")
     .navigationBarTitleDisplayMode(.inline)
  }
}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

