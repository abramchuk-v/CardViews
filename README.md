# CardViews
Collection like a Badoo or Tinder cards
## CardViews [![Swift 3.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
<p align="center">
<img src="https://user-images.githubusercontent.com/26678744/35629853-c513c8cc-06b0-11e8-9e44-d14c1913e3dd.gif" alt="Sample">
</p>

If you want to create something like a badoo card, then enjoy it!

## Installation
*SWCardView requires iOS 10.0 or later.*

### Using [CocoaPods](http://cocoapods.org)

1.  Add the pod `SWCardView` to your [Podfile](http://guides.cocoapods.org/using/the-podfile.html).

pod 'SWCardView'

2.  Run `pod install` from Terminal, then open your app's `.xcworkspace` file to launch Xcode.

## Usage

```swift
import SWCardView
```

1. Register cardView.
```swift
let cardView = SwipeCardsView(frame: frame)
cardView.delegate = self
cardView.dataSource = self
self.view.addSubview(cardView)
cardView.reloadData()
```
2. Add DataSource and Delegate method.
```swift
extension ViewController: SwipeCardViewDelegate {
    func nearOfEnd() {
        obtainNewData()
    }

    func swipedLeft(_ object: Any) {
        //left action
    }

    func swipedRight(_ object: Any) {
        //right action
    }

    func cardTapped(_ object: Any) {
        //tap
    }

    func reachedEnd() {
        //end
    }
}

extension ViewController: SwipeCardViewDataSource {
    func createViewForOverlay(index: Int, swipe: SwipeMode, with frame: CGRect) -> UIView {
        let label = UILabel()
        label.frame.size = CGSize(width: 100, height: 100)
        label.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        label.text = swipe == .right ? "right" : "left"
        return label
    }

    func rowCount() -> Int {
        return dataArray.count
    }

    func createViewForCard(index: Int, with frame: CGRect) -> UIView {
        let cell = ProblemCell(frame: frame)
        cell.element = dataArray[index]
        return cell
    }
}
```



## Demo

Build and run the `testTind` project in Xcode to see this pod in action.
Have fun.

## Contact

Abramchuk Vladislav

- http://github.com/abramchuk-v

- abramchukv97@gmail.com

## License

This project is available under the Apache 2.0 license. See the LICENSE file for more info.
