//
//  BannersModel.swift
//  iOSApp
//
//  Created by Ahmed kamal on 8/25/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import Foundation
struct BannersModel : Codable {
    let value : Bool?
    let data : [BannersData]?
    let code : Int?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case data = "data"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(Bool.self, forKey: .value)
        data = try values.decodeIfPresent([BannersData].self, forKey: .data)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
    }

}

struct BannersData : Codable {
    let image : String?

    enum CodingKeys: String, CodingKey {

        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}
