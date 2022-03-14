//
//  NetworkManager.swift
//  WordCinameApp
//
//  Created by Денис Большачков on 14.03.2022.
//

import Foundation
import Network

class NetworkManger: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    @Published var isConnected = true
    
    var connectionDescription: String {
        if isConnected {
            return "Internet connection looks good"
        } else {
            return "It looks like you're not connected to the internet"
        }
    }
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
}
