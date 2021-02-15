//
//  ContentView.swift
//  SwiftUICollectionView
//
//  Created by Adrian B. Haeske on 14.02.21.
//

import SwiftUI

struct ContentView: View {
    let exampleItems = Vegetable.exampleItems
    
    @State private var selectedItemIndexPath: Int? = nil
    @State private var selectedVegetable: Vegetable? = nil

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Vegetable")
        }
    }
}

// MARK: - View parts
extension ContentView {
    var content: some View {
        VStack {
            collectionView
            navigationLink
        }
    }

    var collectionView: some View {
        CollectionView(
            items: exampleItems) { indexPath, item in
            cell(for: item, at: indexPath)
        }
    }

    var navigationLink: some View {
        NavigationLink(
            destination: DetailViewControllerRepresentable(selectedVegetable: selectedVegetable ?? .preview),
            tag: selectedItemIndexPath ?? 0,
            selection: $selectedItemIndexPath) {
            EmptyView()
        }
    }

    var navigationLinkOld: some View {
        NavigationLink(
            destination: DetailView(
                vegetable: selectedVegetable ?? Vegetable(name: "Empty Veggy", color: "white")
            ),
            tag: selectedItemIndexPath ?? 0,
            selection: $selectedItemIndexPath) {
            EmptyView()
        }
    }

    func cell(for item: Vegetable, at indexPath: IndexPath) -> some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .fill(Color.gray)
                Text(item.name)
                    .multilineTextAlignment(.center)
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
            }
            .onTapGesture {
                selectedItemIndexPath = indexPath.item
                selectedVegetable = item
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
