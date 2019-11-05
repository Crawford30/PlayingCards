//
//  PlayingCards.swift
//  PlayingCards
//
//  Created by JOEL CRAWFORD on 04/11/2019.
//  Copyright © 2019 PlayingCards. All rights reserved.
//

///creating the model for the app using the swift

import Foundation

struct PlayingCard: CustomStringConvertible {
    //making playong look nice by using customestringConvertibleString
    var description: String { return "\(rank)\(suit)"}
    
    
    var suit: Suit
    var rank: Rank
    
    //creating enum for both the suit and the Rank
    
    enum Suit: String, CustomStringConvertible {
        var description: String {
            return "1"
        }
        
        case spades = "♠️"
        case hearts = "🖤"
        case diamonds = "🃁"
        case clubs = "♣️"
        //.hearts is inference since suit.spades has defned the tyoe now
        static var  all = [Suit.spades, .hearts, .diamonds, .clubs]
        
        
    }
    
    enum Rank: CustomStringConvertible {
//        case ace
//        case face(String)
//        case numeric(Int)
        
//        case ace
//        case two
//        case three
//        case jack
//        case queen
//        case king
        //uisng associative data
        
        case ace
        case face(String)
        case numeric(Int) // for 1,2,3,4--
        
        var order: Int {
            switch self {
                case .ace: return 1
                case .numeric( let pips):  return pips
                case .face(let kind) where kind == "J": return 11
                case .face(let kind) where kind == "Q": return 12
                case .face(let kind) where kind == "K": return 13
            default: return 0
                
                
            
            
            }
        }
        //ransk
        
        static var all: [Rank]{
            //allRank: [Rank] = [.ace]
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [Rank.face("J"), Rank.face("Q"), Rank.face("K")]
            return allRanks
            
        }
        var description: String  {
            switch self {
            case .ace: return "A"
            case .numeric(let pips): return String(pips)
            case .face(let kind): return kind
            }
        }
        
    }
}
