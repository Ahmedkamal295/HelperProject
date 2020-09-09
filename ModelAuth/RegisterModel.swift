//
//  RegisterModel.swift
//  iOSApp
//
//  Created by Ahmed kamal on 8/25/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import Foundation
struct RegisterModel : Codable {
    let value : Bool?
    let msg : String?
    let code : Int?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case msg = "msg"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(Bool.self, forKey: .value)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
    }

}
