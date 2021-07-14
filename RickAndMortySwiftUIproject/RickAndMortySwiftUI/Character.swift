//
//  Character.swift
//  RickAndMortySwiftUI
//
//  Created by BrysonSaclausa on 7/14/21.
//

import Foundation

struct Results: Codable {
    var results: [Character]
    //    ^^^naming must match the JSON array key string
}

struct Character: Codable {
    var image: String
    var name: String
    //  ^^^naming must match the JSON keys in array

}
