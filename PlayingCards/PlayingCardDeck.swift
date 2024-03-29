//
//  PlayingCardDeck.swift
//  PlayingCards
//
//  Created by JOEL CRAWFORD on 04/11/2019.
//  Copyright © 2019 PlayingCards. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
   private (set) var cards = [PlayingCard]()
    
    //uing init
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
                
            }
        }
    }
    
    //function which grap the playong card
    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
             return -Int(arc4random_uniform(UInt32(abs(self))))
            
        } else {
            return 0
        }
    }
}
