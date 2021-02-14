//
//  CollectionView.swift
//  SwiftUICollectionView
//
//  Created by Adrian B. Haeske on 14.02.21.
//

import SwiftUI

struct CollectionView<Item: Hashable, Cell: View>: UIViewRepresentable {
    let items: [Item]
    let cell: (IndexPath, Item) -> Cell

    // accept a SwiftUI View as a Cell
    public init(items: [Item], @ViewBuilder cell: @escaping (IndexPath, Item) -> Cell) {
        self.items = items
        self.cell = cell
    }

    func makeUIView(context: Context) -> UICollectionView {
        let cellIdentifier = "hostCell"
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout(context: context)
        )

        collectionView.delegate = context.coordinator
        collectionView.register(
            HostCell.self,
            forCellWithReuseIdentifier: cellIdentifier
        )

        let dataSource = Coordinator.DataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                let hostCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: cellIdentifier,
                    for: indexPath
                ) as? HostCell
                hostCell?.hostedCell = cell(indexPath, item)
                return hostCell
            }
        )

        addDataSourceToCoordinator(dataSource: dataSource, in: context)

        reloadData(in: collectionView, in: context)
        return collectionView
    }

    private func layout(context: Context) -> UICollectionViewLayout {
        return UICollectionViewFlowLayout()
    }

    func reloadData(
        in collectionView: UICollectionView,
        in context: Context,
        animated: Bool = false
    ) {
        let coordinator = context.coordinator

        guard let dataSource = coordinator.dataSource else { return }

        dataSource.apply(
            snapshot(),
            animatingDifferences: animated
        )
    }

    private func snapshot() -> NSDiffableDataSourceSnapshot<Sections, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        return snapshot
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {
        reloadData(in: uiView, in: context, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func addDataSourceToCoordinator(dataSource: UICollectionViewDiffableDataSource<Sections, Item>, in context: Context) {
        context.coordinator.dataSource = dataSource
    }
}

// MARK: - Coordinator
extension CollectionView {
    class Coordinator: NSObject, UICollectionViewDelegate {
        fileprivate typealias DataSource = UICollectionViewDiffableDataSource<CollectionView.Sections, Item>
        fileprivate var dataSource: DataSource? = nil
    }
}

// MARK: - Cell (wrapped SwiftUI View)
extension CollectionView {
    private class HostCell: UICollectionViewCell {
        private var hostController: UIHostingController<Cell>?

        override func prepareForReuse() {
            if let hostView = hostController?.view {
                hostView.removeFromSuperview()
            }
            hostController = nil
        }

        var hostedCell: Cell? {
            willSet {
                guard let view = newValue else { return }
                // todo: check if ignoring safe area would help. requires extension of hostingcontroller.
                //hostController = UIHostingController(rootView: view, ignoreSafeArea: true)
                hostController = UIHostingController(rootView: view)
                if let hostView = hostController?.view {
                    hostView.frame = contentView.bounds
                    hostView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    contentView.addSubview(hostView)
                }
            }
        }
    }
}