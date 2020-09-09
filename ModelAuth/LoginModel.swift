//
//  LoginModel.swift
//  iOSApp
//
//  Created by Ahmed kamal on 8/25/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import Foundation
struct LoginModel : Codable {
    let status : Bool?
    let data : LoginData?
    let code : Int?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
    }

}
struct LoginData : Codable {
    let id : Int?
    let name : String?
    let email : String?
    let email_verified_at : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case email = "email"
        case email_verified_at = "email_verified_at"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        email_verified_at = try values.decodeIfPresent(String.self, forKey: .email_verified_at)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
