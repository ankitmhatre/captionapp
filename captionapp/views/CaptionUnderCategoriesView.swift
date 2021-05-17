//
//  CaptionUnderCategoriesView.swift
//  captionapp
//
//  Created by Ankit Mhatre on 17/05/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Grid


struct CaptionUnderCategoriesView: View {
    @State var style = StaggeredGridStyle(.vertical, tracks: 1, spacing: 1)
    @State var captionList : [Caption] = []
    var category_id: String
    
    var body: some View {
        ScrollView(style.axes) {
            if self.captionList.count > 0 {
        Grid(self.captionList, id: \.self) { caption in
            VStack(alignment: .leading){
                Text(caption.text!)
            }.shadow(radius: 10)
            .background(Color.gray)
                
            }
        .gridStyle(
            self.style
        )
            }else{
                LottieView(name: "loading", loopMode: .loop)
                    .frame(width: 250, height: 250)
            }
        }.onAppear(){
            self.loadCaptions()
        }
    }
    
    func loadCaptions(){
        let db = Firestore.firestore()
        db.collection("categories")
            .document(category_id)
            .collection("captions")
            .limit(to: 10)
            .getDocuments()
            { (querySnapshot, err) in
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var captionsList : [Caption] = []
                    for document in querySnapshot!.documents {
                        do {
                            
                            let caption = try document.data(as: Caption.self)
                            captionsList.append(caption!)
                        } catch let error as NSError {
                            print("error: \(error.debugDescription)")
                        }
                    }
                    captionsList.sort  { $0.srno! < $1.srno! }
                    captionList = captionsList
                    
                }
            
        
        
    }
}


}
