//
//  ViewController.swift
//  PlayingCards
//
//  Created by JOEL CRAWFORD on 04/11/2019.
//  Copyright © 2019 PlayingCards. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var deck = PlayingCardDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for _ in 0...10 {
            if let card = deck.draw() {
                print("\(card)")
                
            } 
        }
    }


}

