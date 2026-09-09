//
//  Product.swift
//  SwiftUIDemo
//
//  Created by user301537 on 9/8/26.
//

import SwiftUI

@Observable
class Product: Identifiable, Hashable {
    
    var id: Int
    var prodName: String
    var productNumber: String
    var color: String
    var listPrice: Double
    
    init(id: Int, prodName: String, productNumber: String, color: String, listPrice: Double) {
        self.id = id
        self.prodName = prodName
        self.productNumber = productNumber
        self.color = color
        self.listPrice = listPrice
    }
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
    func hash (into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
