//
//  Structures.swift
//  8Ball
//
//  Created by Kolya Tatarenko on 27.01.2022.
//

struct Ball: Decodable {
    var magic: Magic
}


struct Magic: Decodable {
    var question: String
    var answer: String
    var type: String
}



