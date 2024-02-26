//
//  OrderDetailsView.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import SwiftUI
import CoreLocation

struct OrderDetailsView: View {
    
    let model: OrderDetailsViewModel
    
    private var errorBinding: Binding<Bool> {
        Binding(
            get: { self.model.state == .failed },
            set: { _ in }
        )
    }
    
    init(viewModel: OrderDetailsViewModel) {
        self.model = viewModel
        viewModel.fetchDetails()
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ScrollView {
                LazyVStack {
                    RemoteImageView(url: model.item.imageURL)
                        .frame(height: 300)
                        .frame(minWidth: 300)
                        .scaledToFit()
                        .background(Color(uiColor: .secondarySystemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Text(model.item.title)
                        .font(.title2)
                        .bold()
                    
                    OrderStatusPriceView(
                        status: model.item.status,
                        formattedPrice: model.item.formattedPrice
                    )
                    .padding(.bottom, 32)
                    
                    VStack(spacing: 16) {
                        detailsRow(label: "Customer details:").bold()
                        detailsRow(label: "Name:", value: model.item.customerName)
                        detailsRow(label: "Distance:", value: model.distanceToCustomer)
                    }
                }
            }
            
            Button(action: model.updateOrderStatus, label: {
                Text("Update order status")
                    .frame(height: 35)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
            })
            .buttonStyle(.borderedProminent)
        }
        .padding([.horizontal, .bottom])
        .onAppear(perform: {
            model.locationManager.requestWhenInUseAuthorization()
        })
        .alert("Error", isPresented: errorBinding) {
            //do nothing
        } message: {
            Text("Failed to fetch more details.")
        }
    }
    
    @ViewBuilder
    private func detailsRow(label: String, value: String = "") -> some View {
        HStack {
            Text(label).fontWeight(.semibold)
            Text(value)
            Spacer()
        }
    }
}

#Preview {
    OrderDetailsView(viewModel: PreviewMock.mockedOrderDetailsVM)
}
