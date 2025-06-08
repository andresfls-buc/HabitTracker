//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Andres Landazabal on 2025/06/08.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    @StateObject private var viewModel = HabitViewModel()
    
    var body: some Scene {
        WindowGroup {
            HabitListView()
                .environmentObject(viewModel)
        }
    }
}
