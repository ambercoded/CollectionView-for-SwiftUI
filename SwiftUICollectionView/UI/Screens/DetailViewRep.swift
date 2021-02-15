//
//  DetailViewRepresentable.swift
//  SwiftUICollectionView
//
//  Created by Adrian B. Haeske on 15.02.21.
//

import SwiftUI

struct DetailViewControllerRepresentable: UIViewControllerRepresentable {
    let selectedVegetable: Vegetable

    func makeUIViewController(context: Context) -> some UIViewController {
        let detailViewController = UIHostingController(rootView: DetailView(vegetable: selectedVegetable))
        detailViewController.transitioningDelegate = context.coordinator
        return detailViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}

// MARK: - Coordinator
extension DetailViewControllerRepresentable {
    class Coordinator: NSObject {}
}

// MARK: Transition Delegate
extension DetailViewControllerRepresentable.Coordinator: UIViewControllerTransitioningDelegate {
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

struct DetailViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        DetailViewControllerRepresentable(selectedVegetable: Vegetable.preview)
    }
}
