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
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var changePicker:Bool = false
    
    @State private var name:String = ""
    @State private var gender:String = "Male"
    @State private var mobileno:String = ""
    @State private var email:String = ""
    //@State private var desgination:String = ""
    //@State private var worksat:String = ""
    //@State private var location:String = ""
    
    @State private var selectedEmployeeType: EmployeeType = .fulltime
    
    @State private var errorShowing:Bool = false
    @State private var errorTitle:String = ""
    @State private var errorMessage:String = ""
    
    let genders = ["Male","Female"]
    
    var body: some View {
        NavigationView{
        VStack{
        //Form tag is used to make a prototype for
        //building an app , after when desgining UI we can replace
        //it with a VStack
        //Form{
        VStack(alignment:.leading, spacing:20) {
        // MARK: - Employee Name
        TextField( "Employee", text: $name)
                .padding()
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(9)
                .font(.system(size:24, weight:.bold, design:.default))
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
                .padding()
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(9)
                .font(.system(size:24, weight:.bold, design:.default))
                .keyboardType(.phonePad)
            
        // MARK: - Employee Email Address
        TextField( "Email",text: $email)
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
                Picker(selection: $selectedEmployeeType) {
                    ForEach(EmployeeType.allCases) { value in
                        Text(value.rawValue.capitalized)
                            .tag(value)
                    }
                } label: {}
                .onChange(of: selectedEmployeeType) { tag in
                    changePicker = true
                }
            } label: {
               Text(selectedEmployeeType.rawValue.capitalized)
                    .font(.system(size:24, weight:.bold, design:.default))
                    .padding()
                    .frame(minWidth: 0, maxWidth:.infinity,alignment:.leading)
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(9)
                    .foregroundColor(changePicker ? Color("ColorPicker") : Color("ColorText"))
            }
            
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
            employee.type = self.selectedEmployeeType.rawValue.capitalized
                
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
        .font(.system(size:24, weight:.bold, design:.default))
        .padding()
        .frame(minWidth: 0, maxWidth:.infinity)
        .background(Color.blue)
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
}
}

struct AddEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmployeeView()
    }
}



