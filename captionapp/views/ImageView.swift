//
//  ImageView.swift
//  captionapp
//
//  Created by Ankit Mhatre on 17/05/21.
//

import Foundation
import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

    init(withURL url:String) {
       let updatedUrl = url.replacingOccurrences(of: "/", with: "%2F")
        let newUrl = "https://firebasestorage.googleapis.com/v0/b/captions-7f095.appspot.com/o/\(updatedUrl)?alt=media"
        imageLoader = ImageLoader(urlString:newUrl)
    
    }

    var body: some View {

            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
        }
    }
}
