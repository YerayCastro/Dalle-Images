//
//  ImageModel.swift
//  DalleImageGenerator
//
//  Created by Yery Castro on 10/3/23.
//

import Foundation


struct ImageModel: Codable {
    
    struct ImageResponse: Codable {
        let url : URL
    }
    
    let created: Int
    let data : [ImageResponse]
}
