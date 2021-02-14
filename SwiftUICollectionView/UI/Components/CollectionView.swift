//
//  CollectionView.swift
//  SwiftUICollectionView
//
//  Created by Adrian B. Haeske on 14.02.21.
//

import SwiftUI

struct CollectionView: UIViewRepresentable {
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )

        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "vegetableCell"
        )

        let dataSource = UICollectionViewDiffableDataSource<CollectionView.Sections, Vegetable>(collectionView: collectionView) { collectionView, indexPath, vegetable in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "vegetableCell",
                for: indexPath
            )

            cell.backgroundColor = .green
            // perform any additional cell configuration here
            return cell
        }

        populate(dataSource: dataSource)
        addDataSourceToCoordinator(dataSource: dataSource, in: context)
        return collectionView
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {
        let dataSource = context.coordinator.dataSource

        // you can update the content of the datasource here (e.g. call populate datasource here to change a snapshot)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func addDataSourceToCoordinator(dataSource: UICollectionViewDiffableDataSource<Sections, Vegetable>, in context: Context) {
        context.coordinator.dataSource = dataSource
    }

    func populate(dataSource: UICollectionViewDiffableDataSource<CollectionView.Sections, Vegetable>) {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionView.Sections, Vegetable>()
        snapshot.appendSections([.main])
        snapshot.appendItems(
            [
                Vegetable(name: "Carrot"),
                Vegetable(name: "Broccoli"),
                Vegetable(name: "Eggplant")
            ]
        )
        dataSource.apply(snapshot)
    }
}

// MARK: - Coordinator
extension CollectionView {
    class Coordinator: NSObject {
        var dataSource: UICollectionViewDiffableDataSource<CollectionView.Sections, Vegetable>?
    }
}

