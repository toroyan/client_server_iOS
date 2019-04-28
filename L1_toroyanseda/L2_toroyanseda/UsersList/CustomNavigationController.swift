
import UIKit

class CustomNavigationController: UINavigationController,
    UINavigationControllerDelegate {
    
    override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    }
    
    let interactiveTransition = CustomInteractiveTransition()

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if operation == .push {
        self.interactiveTransition.viewController = toVC

    return CustomPushAnimator()
    } else if operation == .pop {
        if navigationController.viewControllers.first != toVC {
            self.interactiveTransition.viewController = toVC
        }

        return CustomPopAnimator() 
    }
 
 return nil
    }

}

