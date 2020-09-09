//
//  DetailsModel.swift
//  iOSApp
//
//  Created by Ahmed kamal on 9/9/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import Foundation
struct DetailsModel : Codable {
    let value : Bool?
    let data : DetailsData?
    let code : Int?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case data = "data"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(Bool.self, forKey: .value)
        data = try values.decodeIfPresent(DetailsData.self, forKey: .data)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
    }

}
struct DetailsData : Codable {
    let id : Int?
    let username : String?
    let email : String?
    let brands_id : Int?
    let categories_id : Int?
    let name : String?
    let size : String?
    let color : String?
    let purchase_year : String?
    let where_to_buy : String?
    let defects : String?
    let description : String?
    let price : Int?
    let selling_price : Int?
    let created_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case username = "username"
        case email = "email"
        case brands_id = "brands_id"
        case categories_id = "categories_id"
        case name = "name"
        case size = "size"
        case color = "color"
        case purchase_year = "purchase_year"
        case where_to_buy = "where_to_buy"
        case defects = "defects"
        case description = "description"
        case price = "price"
        case selling_price = "selling_price"
        case created_at = "created_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        brands_id = try values.decodeIfPresent(Int.self, forKey: .brands_id)
        categories_id = try values.decodeIfPresent(Int.self, forKey: .categories_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        purchase_year = try values.decodeIfPresent(String.self, forKey: .purchase_year)
        where_to_buy = try values.decodeIfPresent(String.self, forKey: .where_to_buy)
        defects = try values.decodeIfPresent(String.self, forKey: .defects)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        selling_price = try values.decodeIfPresent(Int.self, forKey: .selling_price)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
    }

}
