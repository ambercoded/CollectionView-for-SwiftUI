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

    var body: some View {
        NavigationView {
            VStack {
                CollectionView(
                    selectedIndexPath: $selectedItemIndexPath,
                    items: exampleItems) { indexPath, item in
                    cell(for: item, at: indexPath)
                }
                .navigationTitle("Vegetable")

                NavigationLink(
                    destination: Text("indexPath: \(selectedItemIndexPath ?? -1) :)"),
                    tag: selectedItemIndexPath ?? 0,
                    selection: $selectedItemIndexPath) {
                    EmptyView()
                }
            }
        }
    }
}

// MARK: - View parts
extension ContentView {
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
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
