
import SwiftUI

struct ProductList: View {
    
    @State private var products: [Product] = []
    
    var body: some View {
        NavigationStack{
            List(products) { prod in
                NavigationLink(prod.name, value: prod)
            }
            .navigationTitle("Products")
            .navigationDestination(for: Product.self) {
                selectedItem in
                ProductDetails(product: selectedItem)
            }
            .toolbar{
                Button(action: {}){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add new product")
            }
        }
        .task{
            loadData()
        }
    }
    
    func loadData(){
        products = [
            Product(id: 1529, prodName: "TV", productNumber: "7AB2C", color: "Black", listPrice: 159.02),
            Product(id: 843, prodName: "Ramen", productNumber: "4397R", color: "Orange", listPrice: 0.69),
            Product(id: 4456, prodName: "Auto Oil", productNumber: "8dBL", color: "Brown", listPrice: 14.97),
            Product(id: 3395, prodName: "Denim Jacket", productNumber: "D5497", color: "Blue", listPrice: 85.49),
            Product(id: 1, prodName: "Water", productNumber: "0001", color: "Clear", listPrice: 1.25),
            Product(id: 536, prodName: "Apple", productNumber: "42TB", color: "Red", listPrice: 4.99)
        ]
    }
    
}

#Preview {
    ProductList()
}
