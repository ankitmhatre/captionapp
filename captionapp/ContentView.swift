//
//  ContentView.swift
//  captionapp
//
//  Created by Ankit Mhatre on 16/05/21.
//

import SwiftUI
import Grid
import Firebase
import FirebaseFirestoreSwift


struct ContentView: View {
    
    
    @State var style = StaggeredGridStyle(.vertical, tracks: 2, spacing: 1)
    @State var listOfCategories : [Categories] = []
    
    
    var body: some View {
        NavigationView{
            ScrollView(style.axes) {
                
                if listOfCategories.count > 0 {
                    
                    Grid(self.listOfCategories, id: \.self) { index in
                        NavigationLink(destination: CaptionUnderCategoriesView(category_id: index.category_id!)){
                            VStack {
                                VStack{
                                    VStack{
                                        ImageView(withURL: index.artwork!)
                                        Text(index.text!)
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 18, weight: .heavy, design: .default))
                                            .padding(.top, 10)
                                    }.padding(20)
                                    .background(Color(hex : index.artwork_bg!))
                                }.cornerRadius(10)
                            }
                            .padding(10)
                        }
                        
                    }
                    .animation(.easeInOut)
                    
                }else{
                    VStack{
                        
                        LottieView(name: "loading", loopMode: .loop)
                            .frame(width: 250, height: 250)
                    }
                }
            }.gridStyle(
                self.style
            ).onAppear(){
                self.loadCategories()
            }.navigationBarHidden(true)
            .navigationBarTitle(Text("Categories"))
//            .navigationBarItems(trailing:
//                HStack {
//                    Button(action: { self.loadCategories()}) {
//                        Text("Shuffle")
//                    }
//
//                    Button(action: { self.loadCategories() }) {
//                        Image(systemName: "gear")
//                    }
//                }
//            )
            
            
        }
    }
    
    
    func loadCategories(){
        let db = Firestore.firestore()
        db.collection("categories").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var categoriesList : [Categories] = []
                for document in querySnapshot!.documents {
                    do {
                        
                        let category = try document.data(as: Categories.self)
                        categoriesList.append(category!)
                    } catch let error as NSError {
                        print("error: \(error.debugDescription)")
                    }
                }
                categoriesList.sort  { $0.srno! < $1.srno! }
                listOfCategories = categoriesList
                
            }
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

