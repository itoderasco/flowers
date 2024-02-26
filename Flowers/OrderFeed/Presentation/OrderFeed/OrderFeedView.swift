//
//  OrderFeedView.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import SwiftUI

struct OrderFeedView: View {
    
    let model: OrderFeedViewModel
    
    init(viewModel: OrderFeedViewModel) {
        self.model = viewModel
        viewModel.fetchOrders()
    }
    
    var body: some View {
        Group {
            switch model.state {
            case .loading:
                ProgressView()
                
            case .loaded:
                if model.items.isEmpty {
                    EmptyView()
                } else {
                    ListView(items: model.items)
                }
            
            case .failed:
                ErrorView()
                
            default:
                EmptyView()
            }
        }
        .onAppear(perform: {
            model.prefetchData()
        })
    }
    
    @ViewBuilder
    private func ListView(items: [OrderItem]) -> some View {
        List {
            ForEach(items) { item in
                OrderItemView(item: item)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        model.selectionHandler(item: item)
                    }
            }
        }
    }
    
    @ViewBuilder
    private func ErrorView() -> some View {
        VStack(spacing: 16) {
            Image(systemName: "text.badge.xmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("Error")
                .bold()
                .font(.title2)
            
            Text("Something went wrong.\nPlease try again.")
                .multilineTextAlignment(.center)
                .font(.callout)
            
            Button(action: model.fetchOrders, label: {
                Text("Retry")
                    .frame(height: 35)
                    .frame(maxWidth: .infinity)
            })
            .padding(.top, 32)
            .padding(.horizontal)
            .buttonStyle(.borderedProminent)
        }
    }
    
    @ViewBuilder
    private func EmptyView() -> some View {
        ContentUnavailableView(
            "No orders",
            systemImage: "list.clipboard",
            description: Text("Order list is empty")
        )
    }
}

#Preview {
    OrderFeedView(viewModel: PreviewMock.mockedOrderFeedVM)
}
