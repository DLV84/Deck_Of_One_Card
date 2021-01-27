//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Daniel Villedrouin on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardDrawButton: UIButton!
    
    
    
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        cardDrawButton.layer.cornerRadius = 6
        cardImageView.image = UIImage(named: "backOfCard")
    }
    
    //MARK: - Actions
    @IBAction func drawCardButtonTapped(_ sender: Any) {
        cardImageView.image = UIImage(named: "backOfCard")
        cardNameLabel.text = "Shuffling..."
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (_) in
            CardController.fetchCard { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let card):
                        self?.fetchImageAndUpdateViews(for: card)
                    case .failure(let error):
                        self?.presentErrorToUser(localizedError: error)
                    }
                }
            }
        }
        
    }
    
    //MARK: - Helper Functions
    func fetchImageAndUpdateViews(for card: Card) {
        
        CardController.fetchImage(for: card) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let image):
                    self?.cardNameLabel.text = "\(card.value) of \(card.suit)"
                    self?.cardImageView.image = image
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}// End of class
