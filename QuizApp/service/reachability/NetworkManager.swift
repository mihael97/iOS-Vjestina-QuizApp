//
//  NetworkManager.swift
//  QuizApp
//
//  Created by five on 10/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import Network
import UIKit

protocol NetworkManagerListener {
    func networkStatusChanged(status: Bool) -> Void
}

protocol NetworkManagerProtocol {
    func isInternetConnected() -> Bool
    func startMonitoring()
    func stopMonitoring()
    func addObserver(observer: NetworkManagerListener?)
}

final class NetworkManager: NetworkManagerProtocol {
    
    static let networkManager: NetworkManagerProtocol = NetworkManager()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    private var isConnected: Bool = false
    private var observers: [NetworkManagerListener] = []
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func isInternetConnected() -> Bool {
        return isConnected
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {
            [weak self] path in
                self?.isConnected = path.status == .satisfied
            if let observers = self?.observers {
                for observer in observers {
                    observer.networkStatusChanged(status: path.status == .satisfied)
                }
            }
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    func addObserver(observer: NetworkManagerListener?) {
        if let observer = observer  {
            observers.append(observer)
        }
     }
}
