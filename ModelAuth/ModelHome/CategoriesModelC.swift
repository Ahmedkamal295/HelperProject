//
//  CategoriesModelC.swift
//  iOSApp
//
//  Created by Ahmed kamal on 9/2/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import Foundation
struct CategoriesModel : Codable {
    let status : Bool?
    let message : String?
    let data : [CategoriesData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([CategoriesData].self, forKey: .data)
    }

}

struct CategoriesData : Codable {
    let cat_name : String?
    let id : Int?
    let name : String?
    let img : String?

    enum CodingKeys: String, CodingKey {

        case cat_name = "cat_name"
        case id = "id"
        case name = "name"
        case img = "img"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        img = try values.decodeIfPresent(String.self, forKey: .img)
    }

}
