//
//  ContactModel.swift
//  ContactJSC
//
//  Created by Dimas Syuhada on 11/01/22.
//

import Foundation

struct Contact: Decodable {
    var name_first: String = ""
    var name_last: String = ""
    var number: String = ""
    var picture: String = ""
    
    private enum getKeys: String, CodingKey{
        case name_first, name_last, number, picture
    }
}
