//
//  DetailView.swift
//  SwiftUICollectionView
//
//  Created by Adrian B. Haeske on 15.02.21.
//

import SwiftUI

struct DetailView: View {
    let vegetable: Vegetable

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.gray)

            Text(vegetable.name)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(vegetable: Vegetable(name: "Cucumber", color: "green"))
    }
}
