//
//  ProductDetails.swift
//  SwiftUIDemo
//
//  Created by user301537 on 9/8/26.
//


import SwiftUI

struct ProductDetails: View {
    
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Product #\(product.id)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Name: \(product.prodName)")
                .font(.title2)
            
            Text("Product Number: \(product.productNumber)")
                .font(.title2)
            
            Text("Color: \(product.color)")
                .font(.title2)
            
            Text("List Price: $\(String("%.2f", product.listPrice))")
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding()
        .navigationTitle("Product Details")
    }
}
#Preview {
    ContentView()
}
