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
    var bufferSize: Int = 3 {
        didSet {
            if bufferSize == 1 {
                isAppearAnimatable = true
            }
        }
    }
    
    /** Minimal number of elements when update. Must be bigger than *bufferSize* Default 4.*/
    var updateWhenCountElements = 4
    
    /** Current number of data element.*/
    private var currentNumber: Int = 0
    
    private var isAppearAnimatable = false
    
    fileprivate var loadedCards = [SwipeCard]()
    fileprivate var cardsCount: Int? {
        return dataSource?.rowCount()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        backgroundColor = .white
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
    
    /** Animatable appearing of new view.*/
    fileprivate func present(view: UIView, animate: Bool, newFrame: CGRect) {
        
        // hide view
        view.alpha = 0
        
        view.frame = newFrame
        view.transform = view.transform.scaledBy(x: 0.1, y: 0.1)
        view.transform = view.transform.translatedBy(x: (newFrame.width + newFrame.origin.x) * 0.6,
                                                     y: (newFrame.height + newFrame.origin.y) * 0.6)
        view.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleHeight, .flexibleWidth]
        
        UIView.animate(withDuration: 0.5) {
            view.alpha = 1
            view.transform = .identity
        }
    }
}

extension SwipeCardsView: SwipeCardDelegate {
    internal func cardSwipedLeft(_ card: SwipeCard) {
        removeSwipeCard(card)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) { [weak self] in
            self?.delegate?.swipedLeft(card.value)
            self?.loadNextCard()
        }
    }
    
    internal func cardSwipedRight(_ card: SwipeCard) {
        removeSwipeCard(card)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) { [weak self] in
            self?.delegate?.swipedRight(card.value)
            self?.loadNextCard()
        }
    }
    
    internal func cardTapped(_ card: SwipeCard) {
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
            
            guard let lastLoaded = loadedCards.last else {
                addSubview(nextView)
                nextView.isUserInteractionEnabled = true
                loadedCards.append(nextView)
                return
            }
            loadedCards.append(nextView)
            insertSubview(nextView, belowSubview: lastLoaded)
        }
    }
    
    fileprivate func createCardView(index: Int) -> SwipeCard {
        currentNumber += 1
        let cardView = SwipeCard()
        cardView.value = index
        
        self.present(view: cardView, animate: true,  newFrame: bounds)
        
        cardView.leftOverlay = self.dataSource?.createViewForOverlay(index: index, swipe: .left, with: self.frame)
        cardView.rightOverlay = self.dataSource?.createViewForOverlay(index: index, swipe: .right, with: self.frame)
        
        guard let nextView = dataSource?.createViewForCard(index: index, with: self.frame) else {
            print(#line, "no such view")
            return cardView
        }
        nextView.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleHeight, .flexibleWidth]
        cardView.delegate = self
        
//        nextView.translatesAutoresizingMaskIntoConstraints = false

        cardView.addSubview(nextView)
        
//        nextView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10).isActive = true
//        nextView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10).isActive = true
//        nextView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
//        nextView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true

        cardView.configureOverlays()
        return cardView
    }
}

