//
//  AddEmployeeView.swift
//  EmployeeRecord
//
//  Created by Anuj Soni on 03/05/22.
//

import SwiftUI

struct AddEmployeeView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State private var name:String = ""
    @State private var gender:String = "Male"
    @State private var mobileno:String = ""
    @State private var email:String = ""
    //@State private var desgination:String = ""
    //@State private var worksat:String = ""
    //@State private var location:String = ""
    
    @State private var errorShowing:Bool = false
    @State private var errorTitle:String = ""
    @State private var errorMessage:String = ""
    
    let genders = ["Male","Female"]
    
    var body: some View {
        NavigationView{
        VStack{
        Form{
        // MARK: - Employee Name
        TextField( "Employee", text: $name)
                .keyboardType(.namePhonePad)
        
        // MARK: - Employee Gender
        Picker(  "Gender",selection:$gender){
            ForEach(genders,id:\.self){
            Text($0)
            }
        }
        .pickerStyle(.segmented)
         
        // MARK: - Employee Mobile Number
        TextField( "Mobile",text: $mobileno)
                .keyboardType(.phonePad)
            
        // MARK: - Employee Email Address
        TextField( "Email",text: $email)
                .keyboardType(.emailAddress)
            
        Button{
            if self.name != ""{
            
            if !mobileno.isValidPhone{
            errorShowing = true
            errorTitle = "Invalid Mobile Number"
            errorMessage = "Make sure to enter correct Mobile\nNumber for new Employee Record."
            return
            }
            
            if !email.isValidEmail{
            errorShowing = true
            errorTitle = "Invalid EmailId"
            errorMessage = "Make sure to enter correct Email\nId for new Employee Record."
            return
            }
                
            let employee = Employee(context:self.managedObjectContext)
            employee.name = self.name
            employee.gender = self.gender
            employee.mobileno = self.mobileno
            employee.email = self.email
                
            do{
            try self.managedObjectContext.save()
            }
            catch{
            print(error)
            }
            } else{
                errorShowing = true
                errorTitle = "Invalid Name"
                errorMessage = "Make sure to enter something for\nthe new Employee Record."
                return
            }
            self.presentationMode.wrappedValue.dismiss()
        } label: {
        Text("Add")
        }
        }
        
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
}
}

struct AddEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmployeeView()
    }
}




