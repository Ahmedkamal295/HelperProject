//
//  CategoriesModelT.swift
//  iOSApp
//
//  Created by Ahmed kamal on 9/2/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import Foundation
struct StoresModel : Codable {
    let status : Bool?
    let message : String?
    let item_found : Int?
    let data : [StoresData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case item_found = "item_found"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        item_found = try values.decodeIfPresent(Int.self, forKey: .item_found)
        data = try values.decodeIfPresent([StoresData].self, forKey: .data)
    }

}
struct StoresData : Codable {
    let id : Int?
    let name : String?
    let desc : String?
    let seller_name : String?
    let img : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case desc = "desc"
        case seller_name = "seller_name"
        case img = "img"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        seller_name = try values.decodeIfPresent(String.self, forKey: .seller_name)
        img = try values.decodeIfPresent(String.self, forKey: .img)
    }

}
