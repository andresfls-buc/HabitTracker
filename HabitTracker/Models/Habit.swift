//
//  Habit.swift
//  HabitTracker
//
//  Created by Andres Landazabal on 2025/06/08.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    
    var isCompletedToday: Bool = false
}
