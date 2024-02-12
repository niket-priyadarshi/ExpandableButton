//
//  ContentView.swift
//  expandableButton
//
//  Created by Manu Singh on 09/02/24.
//

import SwiftUI

struct ContentView: View {
    @State var text = "None"
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("")
//        }
//        .padding()
//        ExpandableBUttonView()
        VStack{
            Spacer()
            Text("\(self.text) pressed")
                .font(.title)
            Spacer()
            HStack{
                
                ExpandableBUttonView(primaryItem: ExpandableButtonItem(image: "plus", text: ""), secondaryItem: [ExpandableButtonItem(image: "lock.rotation.open", text: "Lock"){
                    withAnimation(){
                        self.text = "Lock"
                    }
                },ExpandableButtonItem(image: "xmark.bin", text: "Delete"){
                    withAnimation(){
                        self.text = "Delete"
                    }
                },ExpandableButtonItem(image: "archivebox", text: "archive"){
                    withAnimation(){
                        self.text = "Archive"
                    }
                }])
                
            }.padding()
        }.padding()
    }
}

#Preview {
    ContentView()
}

struct ExpandableBUttonView:View {
    let primaryItem : ExpandableButtonItem
    let secondaryItem : [ExpandableButtonItem]
    let none: () -> Void = {}
    
    var size:CGFloat = 70
    var cornerRadius : CGFloat = 35
    @State var isExpanded = false
    var body: some View {
        Spacer()
        VStack{
            if isExpanded{
                ForEach(secondaryItem){item in
                    
                    Button(action:
                        item.action ?? self.none
                    , label: {
                        HStack{
                            Image(systemName: item.image)
                            Text(item.text)
                        }
                        .font(.body)
                        .foregroundColor(.white)
                    }).padding()
                }
                
            }
            
            Button(action: {
                withAnimation{self.isExpanded.toggle()}
                self.primaryItem.action?()
            }, label: {
                Image(systemName: primaryItem.image)
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .rotationEffect(self.isExpanded ? .degrees(45.0) : .degrees(0))
            }).frame(width: size, height: size)
        }
        .background(.black)
        .cornerRadius(cornerRadius)
        .shadow(color: .black.opacity(0.17), radius: 3, x: 2,y: 2)
    }
}

struct ExpandableButtonItem : Identifiable {
    let id = UUID()
    let image:String
    let text:String
    private(set) var action: (() -> Void)? = nil
}
