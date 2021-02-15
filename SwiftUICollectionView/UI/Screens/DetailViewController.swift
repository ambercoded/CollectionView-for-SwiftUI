//
//  DetailViewController.swift
//  SwiftUICollectionView
//
//  Created by Adrian B. Haeske on 15.02.21.
//

import SwiftUI

class DetailViewController: UIHostingController<DetailView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        transitioningDelegate = self
        print("viewDidLoad called in DetailViewController.")
    }
}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(
            animationDuration: 2.5,
            animationType: .present
        )
    }
}
