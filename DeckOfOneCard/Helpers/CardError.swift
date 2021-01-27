//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Daniel Villedrouin on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String {
        switch self {
        
        case .invalidURL:
            return "Invalid URL"
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "Unable to decode data"
        }
    }
}

