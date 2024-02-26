//
//  OrderItemView.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import SwiftUI

struct OrderItemView: View {
    
    let item: OrderItem
    
    var body: some View {
        HStack {
            RemoteImageView(url: item.imageUrl)
                .frame(width: 60, height: 70)
                .background(Color(uiColor: .secondarySystemFill))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .bold()
                
                OrderStatusPriceView(status: item.status, formattedPrice: item.formattedPrice)
            }
        }
    }
}

#Preview {
    OrderItemView(item: .init(order: Order(
        id: 1,
        description: "Rose",
        price: 12,
        customerId: 1,
        imageUrl: URL(string: "https://images.pexels.com/photos/2300713/pexels-photo-2300713.jpeg"),
        status: .new)
    ))
}
