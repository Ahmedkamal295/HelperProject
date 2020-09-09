//
//  AboutModel.swift
//  DemoProject
//
//  Created by Ahmed kamal on 8/19/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
   struct AboutModel : Codable {
        let value : Bool?
        let data : AboutData?
        let code : Int?

        enum CodingKeys: String, CodingKey {

            case value = "value"
            case data = "data"
            case code = "code"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            value = try values.decodeIfPresent(Bool.self, forKey: .value)
            data = try values.decodeIfPresent(AboutData.self, forKey: .data)
            code = try values.decodeIfPresent(Int.self, forKey: .code)
        }

    }

    struct AboutData : Codable {
        let content : String?

        enum CodingKeys: String, CodingKey {

            case content = "content"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            content = try values.decodeIfPresent(String.self, forKey: .content)
        }

    }

