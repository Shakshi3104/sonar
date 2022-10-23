//
//  PingObserver.swift
//  sonar
//
//  Created by MacBook Pro M1 on 2022/10/23.
//

import Foundation
import SwiftyPing

class PingObserver: ObservableObject {
    @Published var responses: String = ""
    var pinger: SwiftyPing?
    
    func start(destination: String) {
        // Remove last responses
        responses = ""
        
        // Ping configuration
        pinger = try? SwiftyPing(host: destination,
                                 configuration: PingConfiguration(interval: 0.5, with: 5),
                                 queue: .global())
        pinger?.observer = { (response) in
            let output: String
            
            if let byteCount = response.byteCount {
                output = "\(byteCount) byte from \(response.ipAddress ?? "?.?.?.?"): time=\(String(format: "%.3f", response.duration * 1000)) ms"
            } else {
                output = "Request timeout"
            }
            
            print("🔊 \(output)")
            
            self.responses += "\(output)\n"
        }
        
        // Start ping
        print("🔊 start")
        try? pinger?.startPinging()
    }
    
    func stop() {
        // Stop ping
        pinger?.stopPinging()
        print("🔊 stop")
    }
}
