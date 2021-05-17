//
//  Caption.swift
//  captionapp
//
//  Created by Ankit Mhatre on 17/05/21.
//

import Foundation


public struct Caption: Decodable, Hashable{

    let added_by: String?
    let caption_id: String?
    let category_id: String?
    let srno  :Float?
    let text: String?
    

    enum CodingKeys:  CodingKey {
        case added_by
        
        case caption_id
        case category_id
        case srno 
        case text
  
    }
}
