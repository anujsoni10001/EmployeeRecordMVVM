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

@State private var showingSettingsView:Bool = false
@State private var showingAddEmployeeView:Bool = false
@State private var animatingButton:Bool = false

@ObservedObject var theme = ThemeSettings.shared
let themes : [Theme] = themeData
//@ObservedObject var theme = ThemeSettings()

    
var body: some View {
    
    NavigationView{
        ZStack {
            List{
              ForEach(self.employees,id:\.self){item in
                  
                  HStack{
                  Circle()
                  .frame(width: 12, height: 12, alignment: .center)
                  .foregroundColor(self.colorize(type: item.type ?? "Unknown"))
                  Text(item.name ?? "Unknown")
                  .fontWeight(.semibold)
                      
                  Spacer()
                      
                   Text(item.type ?? "Unknown")
                  .font(.footnote)
                  .foregroundColor(Color(UIColor.systemGray2))
                  .padding(3)
                  .frame(minWidth: 85)
                  .overlay(
                   Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                  )
                  }
                  .padding(.vertical, 10)
            }
            .onDelete(perform:deleteEmployee)
        }
            
            
          .navigationBarItems(leading:EditButton()
            .accentColor(themes[self.theme.themeSettings].themeColor),trailing:
              Button{
              showingSettingsView.toggle()
              } label: {
                  Image(systemName:"paintbrush")
                  .imageScale(.large)
              }
//              .sheet(isPresented:$showingAddEmployeeView){
//                  AddEmployeeView().environment(\.managedObjectContext,self.managedObjectContext)
//              }
            .accentColor(themes[self.theme.themeSettings].themeColor)
            .sheet(isPresented:$showingSettingsView){
               SettingsView()
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
            .fill(themes[self.theme.themeSettings].themeColor)
            .opacity(animatingButton ? 0.2 : 0)
            .scaleEffect(animatingButton ? 1 : 0)
            .frame(width: 68, height: 68, alignment:.center)
            Circle()
            .fill(themes[self.theme.themeSettings].themeColor)
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
            }
            .accentColor(themes[self.theme.themeSettings].themeColor)
            .sheet(isPresented:$showingAddEmployeeView){
             AddEmployeeView().environment(\.managedObjectContext,self.managedObjectContext)
            }
            .onAppear(){
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
    
    private func colorize(type: String) -> Color {
        switch type {
        case "fulltime".capitalized:
            return .green
        case "parttime".capitalized:
            return .pink
        case "seasonal".capitalized:
            return .yellow
        case "leased".capitalized:
            return .blue
        case "temporary".capitalized:
            return .orange
        default:
            return .gray
        }
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
