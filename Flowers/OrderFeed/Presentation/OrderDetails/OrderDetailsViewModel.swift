//
//  OrderDetailsViewModel.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation
import Observation
import CoreLocation

@Observable
final class OrderDetailsViewModel: NSObject {
    
    enum State {
        case idle
        case loading
        case loaded
        case failed
    }
    
    private(set) var state: State = .idle
    private(set) var item: OrderItemDetails
    
    private(set) var canUpdateStatus: Bool
    
    var distanceToCustomer: String {
        if customerDistance >= 0 {
            return formatDistance(customerDistance)
        } else {
            return "n/a"
        }
    }
    private var customerDistance: Double = -1
    
    private let repository: CustomerRepository
    private let storage: OrderStorage
    
    let locationManager = CLLocationManager()
    private var userLocation: CLLocation?
    
    init(orderItem: OrderItem, repository: CustomerRepository, storage: OrderStorage) {
        self.item = .init(order: orderItem)
        
        self.repository = repository
        self.storage = storage
        
        canUpdateStatus = orderItem.status.next() != nil
        
        super.init()
        locationManager.delegate = self
        userLocation = locationManager.location
    }
    
    func updateOrderStatus() {
        guard let nextStatus = item.status.next() else {
            return
        }
        canUpdateStatus = false
        
        Task {
            await storage.updateOrder(id: item.orderId, newStatus: nextStatus)
        }
        
        fetchDetails()
    }
    
    func fetchDetails() {
        state = .loading
        
        Task {
            guard let order = await storage.getOrder(id: item.orderId) else {
                state = .failed
                return
            }
            
            if let customer = await storage.getCustomer(id: order.customerId) {
                await fullfilData(order: order, customer: customer)
            } else {
                await fetchCustomer(for: order)
            }
        }
    }
    
    private func fetchCustomer(for order: Order) async {
        do {
            let customers = try await repository.fetchCustomers()
            await storage.store(customers)
            
            if let customer = customers.first(where: { $0.id == order.customerId }) {
                await fullfilData(order: order, customer: customer)
            } else {
                state = .failed
            }
        } catch {
            state = .failed
        }
    }
    
    @MainActor
    private func fullfilData(order: Order, customer: Customer) {
        item = OrderItemDetails(order: .init(order: order), customer: customer)
        canUpdateStatus = order.status.next() != nil
        calculateDistanceToCustomer()
        
        state = .loaded
    }
    
    // Helper
    private func formatDistance(_ value: Double) -> String {
        let meters = Measurement(value: value, unit: UnitLength.meters)
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.unitOptions = .naturalScale
        
        return formatter.string(from: meters)
    }
}

extension OrderDetailsViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            self.userLocation = manager.location
            calculateDistanceToCustomer()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        calculateDistanceToCustomer()
    }
    
    private func calculateDistanceToCustomer() {
        guard let userLocation,
              let coordinate = item.customerLocationCoordinate
        else {
            return
        }
        let customerLocation = CLLocation(latitude: coordinate.lat, longitude: coordinate.lon)
        customerDistance = userLocation.distance(from: customerLocation)
    }
}
