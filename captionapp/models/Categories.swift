//
//  Categories.swift
//  captionapp
//
//  Created by Ankit Mhatre on 17/05/21.
//

import Foundation


public struct Categories: Decodable, Hashable{

    let artwork_bg: String?
    let text: String?
    let artwork: String?
    let srno: Float?
    let category_id: String?
    

    enum CodingKeys:  CodingKey {
        case artwork_bg
        case text
        case artwork
        case srno
        case category_id
  
    }
}
