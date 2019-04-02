//
//  Concentration.swift
//  Concentration
//
//  Created by Daniel Marcos on 07/02/2019.
//  Copyright © 2019 Daniel Marcos. All rights reserved.
//

import Foundation

class Concentration{
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        //Shuffle the cards
        cards = shuffleCards(toShuffleCards: cards)
    }
    
    func shuffleCards(toShuffleCards: [Card]) -> [Card]{
        var auxCards = toShuffleCards
        var newCards = [Card]()
        for _ in 1...(auxCards.count){
            let randomIndex = Int(arc4random_uniform(UInt32(auxCards.count)))
            newCards += [auxCards[randomIndex]]
            auxCards.remove(at: randomIndex)
        }
        return newCards
    }
}









