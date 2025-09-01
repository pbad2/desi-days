//
//  desi_daysApp.swift
//  desi-days
//
//  Created by Pallavi Badanahatti on 8/26/25.
//

import SwiftUI

@main
struct desi_daysApp: App {
    @StateObject private var hinduCalendarService = HinduCalendarService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(hinduCalendarService)
        }
    }
}
