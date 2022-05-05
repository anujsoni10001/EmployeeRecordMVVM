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
@State private var animatingButton:Bool = false
    
var body: some View {
    
    NavigationView{
        ZStack {
            List{
              ForEach(self.employees,id:\.self){item in
                  HStack{
                  Text(item.name ?? "Unknown")
                  
                  Spacer()
                      
                  Text(item.type ?? "Unknown")
                  }
            }
            .onDelete(perform:deleteEmployee)
         }

          .navigationBarItems(leading:EditButton(),trailing:
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
        
          if employees.count == 0{
              EmptyListView()
          }
        }//ZStack
        .overlay(
            ZStack
            {
                
            Group{
            Circle()
            .fill(Color.blue)
            .opacity(animatingButton ? 0.2 : 0)
            .scaleEffect(animatingButton ? 1 : 0)
            .frame(width: 68, height: 68, alignment:.center)
            Circle()
            .fill(Color.blue)
            .opacity(animatingButton ? 0.15 : 0)
            .scaleEffect(self.animatingButton ? 1 : 0)
            .frame(width: 88, height: 88, alignment:.center)
            }
            //.animation(.easeInOut(duration:2).repeatForever(autoreverses:true))
                
            Button{
                showingAddEmployeeView.toggle()
            } label: {
                Image(systemName:"plus.circle.fill")
                .resizable()
                .scaledToFit()
                .background(Circle().fill(Color("ColorBase")))
                .frame(width:48, height: 48, alignment: .center)
            }.onAppear(){
            withAnimation(.easeInOut(duration:2).repeatForever(autoreverses:true)){
            animatingButton.toggle()
            }
            }
            }
            .padding(.bottom,15)
            .padding(.trailing,15)
            ,alignment:.bottomTrailing
        )
  }//Navigation
}
    
// MARK: - funtions

private func deleteEmployee(at offsets:IndexSet){
    for index in offsets{
        let employee = employees[index]
        managedObjectContext.delete(employee)
        do{
            try self.managedObjectContext.save()
        }
        catch{
            print(error)
        }
    }
}

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}




