//
//  EmptyView.swift
//  EmployeeRecord
//
//  Created by Anuj Soni on 04/05/22.
//

import SwiftUI

struct EmptyListView: View {
    
    @State private var isAnimated:Bool = false
    
    let images: [String] = [
       "illustration-no1",
       "illustration-no2",
       "illustration-no3"
     ]
     
     let tips: [String] = [
       "Use your time wisely.",
       "Slow and steady wins the race.",
       "Keep it short and sweet.",
       "Put hard tasks first.",
       "Reward yourself after work.",
       "Collect tasks ahead of time.",
       "Each night schedule for tomorrow."
     ]
    
    var body: some View {
        ZStack {
            VStack(alignment: .center,spacing: 20){
                
            Image(images.randomElement() ?? images[0])
            .resizable()
            .scaledToFit()
            .frame(minWidth:256, idealWidth: 280, maxWidth:360, minHeight: 256, idealHeight: 280, maxHeight: 380, alignment: .center)
            .layoutPriority(1)
                
            Text(tips.randomElement() ?? tips[0])
            .layoutPriority(0.5)
            .font(.system(.headline, design:.rounded))
            }
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0 )
            .offset(y:isAnimated ? 0 : -50)
            //.animation(.easeOut(duration:1.5),value:isAnimated)
            .onAppear(){
                withAnimation(.easeOut(duration:1.5)){
                isAnimated.toggle()
                }
            }
        }
        .frame(minWidth:0, maxWidth:.infinity, minHeight: 0, maxHeight: .infinity, alignment:.center)
        .background(Color("ColorBase"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
            .preferredColorScheme(.light)
    }
}
