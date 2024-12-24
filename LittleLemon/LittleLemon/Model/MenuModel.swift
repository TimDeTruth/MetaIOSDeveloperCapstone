//
//  MenuModel.swift
//  LittleLemon
//
//  Created by Timmy Lau on 2024-12-23.
//

import Foundation

struct MenuList: Decodable{
    let menu: [MenuItem]

}


struct MenuItem: Decodable{
    let title: String
    let image: String
    let price: String
}
