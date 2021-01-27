//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Daniel Villedrouin on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardController {
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        
        // 1 Prepare URL
        
        guard let finalURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1") else { return completion(.failure(.invalidURL))}
        print(finalURL)
        
        // 2 - Contact Server
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            // 3 - Handle errors from the server
            
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            // 4 - Check for JSON data
            guard let data = data else { return completion(.failure(.noData))}
            
            // 5 - Decode JSON into a Card
            
            do {
                let deckOfCards = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let card = deckOfCards.cards[0]
                return completion(.success(card))
            } catch let error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.noData))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result <UIImage, CardError>) -> Void) {
        
      // 2 - Contact server
        
        URLSession.shared.dataTask(with: card.image) { (data, _, error) in
            
            // 3 - Handle errors from the server
            
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
            }
        
            // 4 - Check for image data
            
            guard let data = data else { return completion(.failure(.noData))}
              
            // 5 - Initialize an image from the data
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            
            completion(.success(image))
            
        }.resume()
    }
}// End of class
