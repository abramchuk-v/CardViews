//
//  SVSwipeCardsView.swift
//  testTind
//
//  Created by Uladzislau Abramchuk on 1/22/18.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

import UIKit

public enum SwipeMode {
    case left
    case right
}

public protocol SwipeCardViewDelegate: class {
    func swipedLeft(_ object: Any)
    func swipedRight(_ object: Any)
    func cardTapped(_ object: Any)
    func reachedEnd()
    /** Add here new data.*/
    func nearOfEnd()
}

public protocol SwipeCardViewDataSource: class {
    func createViewForCard(index: Int, with frame: CGRect) -> UIView
    func rowCount() -> Int
    func createViewForOverlay(index: Int, swipe: SwipeMode, with frame: CGRect) -> UIView
}


public class SwipeCardsView: UIView {
    public weak var dataSource: SwipeCardViewDataSource?
    public weak var delegate: SwipeCardViewDelegate?
    
    /** Count of visible views.*/
    var bufferSize: Int = 3
    
    /** Minimal number of elements when update. Must be bigger than *bufferSize* Default 4.*/
    var updateWhenCountElements = 4
    
    var currentNumber: Int = 0
    
    fileprivate var loadedCards = [SwipeCard]()
    fileprivate var cardsCount: Int? {
        return dataSource?.rowCount()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    
    
    /** Reload card view.*/
    
    public func reloadData() {
        
        self.isUserInteractionEnabled = true
        guard let cardsCount = cardsCount else { return }
        
        currentNumber = 0
        
        for _ in 0..<cardsCount {
            if loadedCards.count < bufferSize {
                let cardView = createCardView(index: currentNumber)
                if loadedCards.isEmpty {
                    addSubview(cardView)
                } else {
                    cardView.isUserInteractionEnabled = false
                    insertSubview(cardView, belowSubview: loadedCards.last!)
                }
                self.loadedCards.append(cardView)
            }
        }
    }
}

extension SwipeCardsView: SwipeCardDelegate {
    func cardSwipedLeft(_ card: SwipeCard) {
        removeSwipeCard(card)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) { [weak self] in
            self?.delegate?.swipedLeft(card.value)
            self?.loadNextCard()
        }
        
    }
    
    func cardSwipedRight(_ card: SwipeCard) {
        removeSwipeCard(card)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) { [weak self] in
            self?.delegate?.swipedRight(card.value)
            self?.loadNextCard()
        }
        
//        removeSwipeCard(card)
    }
    
    func cardTapped(_ card: SwipeCard) {
        delegate?.cardTapped("tap")
    }
}

extension SwipeCardsView {
    fileprivate func removeSwipeCard(_ card: SwipeCard) {
        
        loadedCards.removeFirst()
        loadedCards.first?.isUserInteractionEnabled = true
        
        if cardsCount! - currentNumber <= updateWhenCountElements {
            delegate?.nearOfEnd()
        }
        
        if cardsCount == 0 {
            isUserInteractionEnabled = false
            delegate?.reachedEnd()
        }
    }
    
    fileprivate func loadNextCard() {
        guard let cardsCount = self.cardsCount else {
            print(#line, "cardsCount is empty ")
            return
        }
        
        if cardsCount - loadedCards.count > 0 {
            let nextView = createCardView(index: currentNumber)
            
            nextView.isUserInteractionEnabled = false
            guard let lastLoaded = loadedCards.last else { return }
            loadedCards.append(nextView)
            
            insertSubview(nextView, belowSubview: lastLoaded)
        }
    }
    
    fileprivate func createCardView(index: Int) -> SwipeCard {
        currentNumber += 1
        let cardView = SwipeCard(frame: self.frame)
        cardView.delegate = self
        
        guard let nextView = dataSource?.createViewForCard(index: index, with: self.frame) else {
            print(#line, "no such view")
            return cardView
        }
        cardView.addSubview(nextView)
        nextView.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleHeight, .flexibleWidth]

        cardView.leftOverlay = self.dataSource?.createViewForOverlay(index: index, swipe: .left, with: cardView.frame)
        cardView.rightOverlay = self.dataSource?.createViewForOverlay(index: index, swipe: .right, with: cardView.frame)
        
        cardView.configureOverlays()
        cardView.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleHeight, .flexibleWidth]
        
        cardView.value = index
        
        return cardView
    }
}

