//
//  OrderStatusPriceView.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import SwiftUI

struct OrderStatusPriceView: View {
    
    let status: OrderStatus
    let formattedPrice: String
    
    var body: some View {
        HStack {
            Text(status.rawValue.lowercased())
                .font(.caption)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .background {
                    Capsule(style: .continuous).fill(statusColor(from: status))
                }
            
            Spacer()
            
            Text(formattedPrice)
                .font(.caption)
        }
    }
    
    private func statusColor(from orderStatus: OrderStatus) -> Color {
        switch orderStatus {
        case .new:
            return Color.blue.opacity(0.1)
        case .pending:
            return Color.yellow.opacity(0.1)
        case .delivered:
            return Color.green.opacity(0.1)
        case .invalidStatus:
            return Color.red.opacity(0.1)
        }
    }
}

#Preview {
    OrderStatusPriceView(status: .new, formattedPrice: "68.99 RON")
}
