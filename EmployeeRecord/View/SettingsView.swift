//
//  SettingsView.swift
//  EmployeeRecord
//
//  Created by Anuj Soni on 06/05/22.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    //THEME
    
    let themes : [Theme] = themeData
//    @ObservedObject var theme = ThemeSettings()
    @ObservedObject var theme = ThemeSettings.shared
    @State private var isThemeChanged:Bool = false
    
    var body: some View {
        NavigationView{
        VStack(alignment:.center, spacing: 0){
        Form{
            
            Section(header:
            HStack{
            Text("Choose the app theme")
            Image(systemName:"circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 10, height: 10)
            .foregroundColor(themes[self.theme.themeSettings].themeColor)
            }
            ){
            List{
            ForEach(themes,id:\.id){item in
                
            Button{
                self.theme.themeSettings = item.id
                UserDefaults.standard.set(self.theme.themeSettings,forKey:"Theme")
            } label: {
                
                HStack{
                    Image(systemName:"circle.fill")
                        .foregroundColor(item.themeColor)
                    
                    Text(item.themeName)
                }
            }
            .accentColor(Color.primary)
                
            }
            }
            }
            .padding(.vertical, 3)
            .alert(isPresented:$isThemeChanged){
                Alert(
                    title: Text("SUCCESS!"),
                    message: Text("App has been changed to the \(themes[self.theme.themeSettings].themeName)!"),
                    dismissButton: .default(Text("OK"))
                )
            }
            // MARK: - SECTION 3
            
            Section(header: Text("Follow us on social media")) {
                FormRowLinkView(icon: "globe", color:Color.pink, text:"Website", link:"https://anujsoni10001.github.io/anujsoni10001/")
                FormRowLinkView(icon: "link", color: Color.blue, text: "Twitter", link: "https://twitter.com/anujsoni10001")
                FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Courses", link:
                    "https://twitter.com/anujsoni10001")
            } //: SECTION 3
            .padding(.vertical, 3)
            
            // MARK: - About the Application
            Section(header:Text("About the application")){
                FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Employee Record")
                FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Anuj Soni")
                FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Anuj Soni")
                FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.5.0")
            }
            .padding(.vertical,3)
        }
    
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass,.regular)
            
        Text("Copyright © All rights reserved.\nBetter Apps ♡ Less Code")
        .multilineTextAlignment(.center)
        .font(.footnote)
        .padding(.top, 6)
        .padding(.bottom, 8)
        .foregroundColor(Color.secondary)
        //alternative
        //.opacity(0.4)
        }
        .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
        .navigationBarItems(trailing:
        Button{
        self.presentationMode.wrappedValue.dismiss()
        } label: {
        Image(systemName: "xmark")
        }
        )
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(themes[self.theme.themeSettings].themeColor)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.light)
    }
}



    

