//
//  AddEmployeeView.swift
//  EmployeeRecord
//
//  Created by Anuj Soni on 03/05/22.
//

import SwiftUI

enum EmployeeType: String, CaseIterable, Identifiable {
    case parttime,fulltime,seasonal,temporary,leased
    var id: Self { self }
}

struct AddEmployeeView: View {
    
//@StateObject private var employeeVM = EmployeeViewModel()
@ObservedObject var employeeVM = EmployeeViewModel.shared
    
//    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var changePicker:Bool = false
    
//    @State private var name:String = ""
//    @State private var gender:String = "Male"
//    @State private var mobileno:String = ""
//    @State private var email:String = ""
    //@State private var desgination:String = ""
    //@State private var worksat:String = ""
    //@State private var location:String = ""
//    @State private var selectedEmployeeType: EmployeeType = .fulltime
    
    @State private var errorShowing:Bool = false
    @State private var errorTitle:String = ""
    @State private var errorMessage:String = ""
    
    let genders = ["Male","Female"]
    
    @ObservedObject var theme = ThemeSettings.shared
    let themes : [Theme] = themeData
//    @ObservedObject var theme = ThemeSettings()
    
    var body: some View {
        NavigationView{
        VStack{
        //Form tag is used to make a prototype for
        //building an app , after when desgining UI we can replace
        //it with a VStack
//        Form{
        VStack(alignment:.leading, spacing:20) {
        // MARK: - Employee Name
            TextField( "Employee", text: $employeeVM.name)
                .padding()
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(9)
                .font(.system(size:24, weight:.bold, design:.default))
                .keyboardType(.namePhonePad)
            
        
        // MARK: - Employee Gender
        Picker(  "Gender",selection:$employeeVM.gender){
            ForEach(genders,id:\.self){
            Text($0)
            }
        }
        .pickerStyle(.segmented)
         
        // MARK: - Employee Mobile Number
            TextField( "Mobile",text: $employeeVM.mobileno)
                .padding()
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(9)
                .font(.system(size:24, weight:.bold, design:.default))
                .keyboardType(.phonePad)
            
        // MARK: - Employee Email Address
            TextField( "Email",text: $employeeVM.email)
                .padding()
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(9)
                .font(.system(size:24, weight:.bold, design:.default))
                .keyboardType(.emailAddress)
        
        // MARK: - Employee Type
//        Picker("Type",selection: $selectedEmployeeType) {
//           ForEach(EmployeeType.allCases) { item in
//               Text(item.rawValue.capitalized)
//           }
//        }
            Menu {
                Picker(selection: $employeeVM.selectedEmployeeType) {
                    ForEach(EmployeeType.allCases) { value in
                        Text(value.rawValue.capitalized)
                            .tag(value)
                    }
                } label: {}
                    .onChange(of: employeeVM.selectedEmployeeType) { tag in
                    changePicker = true
                }
            } label: {
                Text(employeeVM.selectedEmployeeType.rawValue.capitalized)
                    .font(.system(size:24, weight:.bold, design:.default))
                    .padding()
                    .frame(minWidth: 0, maxWidth:.infinity,alignment:.leading)
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(9)
                    .foregroundColor(changePicker ? Color.primary : Color("ColorText"))
            }
            
        Button{
            if employeeVM.name != ""{
            
            guard employeeVM.mobileno.isValidPhone else{
            
            errorShowing = true
                
            if employeeVM.mobileno == "" {
            errorTitle = "Enter Mobile Number"
            errorMessage = "Make sure to enter Mobile\nNumber for new Employee Record."
            } else {
            errorTitle = "Invalid Mobile Number"
            errorMessage = "Make sure to enter correct Mobile\nNumber for new Employee Record."
            }
            return
            }
            
            guard employeeVM.email.isValidEmail else{
            
            errorShowing = true
            
            if employeeVM.email == "" {
            errorTitle = "Enter EmailId"
            errorMessage = "Make sure to enter Email\nId for new Employee Record."
            } else {
            errorTitle = "Invalid EmailId"
            errorMessage = "Make sure to enter correct Email\nId for new Employee Record."
            }
            return
            }
  
            employeeVM.save()
            employeeVM.getAllEmployees()
        
//            let employee = Employee(context:self.managedObjectContext)
//            employee.name = self.name
//            employee.gender = self.gender
//            employee.mobileno = self.mobileno
//            employee.email = self.email
//            employee.type = self.selectedEmployeeType.rawValue.capitalized
//
//            do{
//            try self.managedObjectContext.save()
//            }
//            catch{
//            print(error)
//            }
            } else{
                errorShowing = true
                errorTitle = "Enter Name"
                errorMessage = "Make sure to enter something for\nthe new Employee Record."
                return
            }
            self.presentationMode.wrappedValue.dismiss()
        } label: {
        Text("Add")
        .font(.system(size:24, weight:.bold, design:.default))
        .padding()
        .frame(minWidth: 0, maxWidth:.infinity)
        .background(themes[self.theme.themeSettings].themeColor)
        .cornerRadius(9)
        .foregroundColor(Color.white)
        }
        }
        .padding(.horizontal)
        .padding(.vertical,30)
        
        Spacer()
        }
        .navigationTitle("New Employee")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:Button{
            self.presentationMode.wrappedValue.dismiss()
              } label: {
                  Image(systemName:"xmark")
        })
        .alert(isPresented: $errorShowing){
            Alert(title: Text(errorTitle), message:Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
        .accentColor(themes[self.theme.themeSettings].themeColor)
        .navigationViewStyle(.stack)
}
}

struct AddEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmployeeView()
    }
}




