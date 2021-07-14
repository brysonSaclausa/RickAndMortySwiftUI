//
//  Character.swift
//  RickAndMortySwiftUI
//
//  Created by BrysonSaclausa on 7/14/21.
//

import Foundation

struct Results: Codable {
    var results: [Character]
}

struct Character: Codable {
    var image: String
    var name: String

}
