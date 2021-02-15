//
//  AnimationController.swift
//  SwiftUICollectionView
//
//  Created by Adrian B. Haeske on 15.02.21.
//
/* a delegate that handles custom transitions animations from one UIViewController to the next.  */

import UIKit

class AnimationController: NSObject {
    private let animationDuration: Double
    private let animationType: AnimationType

    enum AnimationType {
        case present, dismiss
    }

    // MARK: - Init
    init(animationDuration: Double, animationType: AnimationType) {
        self.animationDuration = animationDuration
        self.animationType = animationType
    }
}

extension AnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // get access to the to and the from VC
        guard let toVC = transitionContext.viewController(forKey: .to),
              let fromVC = transitionContext.viewController(forKey: .from) else
        {
            transitionContext.completeTransition(false)
            return
        }

        // trigger present or dismiss presentation
        switch animationType {
        case .present:
            // add the view that we want to animate during the transition to the container view
            transitionContext.containerView.addSubview(toVC.view)
            presentAnimation(using: transitionContext, viewToAnimate: toVC.view)
        case .dismiss:
            print("Todo")
        }

    }

    func presentAnimation(using transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView) {
        // necessary to cut everything that exceeds the screen's bounds
        viewToAnimate.clipsToBounds = true
        // set start transform to zero (size and position)
        viewToAnimate.transform = CGAffineTransform(scaleX: 0, y: 0)

        // start animation
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.1,
            options: .curveEaseInOut,
            animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            },
            completion: { _ in
                transitionContext.completeTransition(true)
            }
        )
    }
}
