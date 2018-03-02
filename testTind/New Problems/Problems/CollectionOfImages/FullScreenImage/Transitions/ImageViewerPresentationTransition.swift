import UIKit

final class ImageViewerPresentationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let fromImageView: UIImageView
    var imageViewBeforePresentDelegate: SWImageAnimationDelegate?
    
    init(fromImageView: UIImageView) {
        self.fromImageView = fromImageView
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        imageViewBeforePresentDelegate?.prepareImageIncreasing {
            
            let containerView = transitionContext.containerView
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
            let fromParentView = self.fromImageView.superview!
            
            let imageView = AnimatableImageView()
            imageView.image = self.fromImageView.image
            imageView.frame = fromParentView.convert(self.fromImageView.frame, to: nil)
            imageView.contentMode = self.fromImageView.contentMode
            imageView.layer.cornerRadius = self.fromImageView.layer.cornerRadius
            
            let fadeView = UIView(frame: containerView.bounds)
            fadeView.backgroundColor = .black
            fadeView.alpha = 0.0
            
            toView.frame = containerView.bounds
            toView.isHidden = true
            self.fromImageView.isHidden = true
            
            containerView.addSubview(toView)
            containerView.addSubview(fadeView)
            containerView.addSubview(imageView)
            
            
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseOut,  animations: {
                            imageView.contentMode = .scaleAspectFit
                            imageView.frame = containerView.bounds
                            fadeView.alpha = 1.0
            }, completion: { _ in
                toView.isHidden = false
                fadeView.removeFromSuperview()
                imageView.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
            
        }
        
    }
}
