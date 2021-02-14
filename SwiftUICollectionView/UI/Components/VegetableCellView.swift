//
//  VegetableCellView.swift
//  SwiftUICollectionView
//
//  Created by Adrian B. Haeske on 14.02.21.
//

import SwiftUI

struct VegetableCellView: View {
    let vegetable: Vegetable

    var body: some View {
        Text(vegetable.name)
            .padding()
    }
}

struct VegetableCellView_Previews: PreviewProvider {
    static var previews: some View {
        VegetableCellView(vegetable: Vegetable(name: "Cucumber", color: "green"))
    }
}
