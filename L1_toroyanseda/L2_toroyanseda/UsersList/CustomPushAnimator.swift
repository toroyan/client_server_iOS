
import UIKit

class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else {
            return
            
        }
        guard let destination = transitionContext.viewController(forKey: .to) else {
            return
            
        }

        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)
 destination.view.transform =   destination.view.transform.rotated(by: 90)
     
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                  
                                   UIView.addKeyframe(withRelativeStartTime: 0.6,
                                                       relativeDuration: 0.4,
                                                       animations: {
                                                        
                                                        destination.view.transform = .identity
                                    })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }

    
    
    
    }
    
    
    
    

}
