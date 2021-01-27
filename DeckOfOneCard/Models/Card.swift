//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Daniel Villedrouin on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

struct TopLevelObject: Decodable {
    var cards: [Card]
}

struct Card: Decodable {
    var image: URL
    var value: String
    var suit: String
}

