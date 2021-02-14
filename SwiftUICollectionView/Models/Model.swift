//
//  Model.swift
//  SwiftUICollectionView
//
//  Created by Adrian B. Haeske on 14.02.21.
//

import Foundation

struct Vegetable: Hashable {
    let id = UUID()
    var name: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Vegetable, rhs: Vegetable) -> Bool {
        lhs.id == rhs.id
    }
}
