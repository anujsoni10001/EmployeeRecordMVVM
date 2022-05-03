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
@State private var showingAddEmployeeView:Bool = false
    
var body: some View {
    
    NavigationView{
      List(0 ..< 5) { item in
            Text("Hello")
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
