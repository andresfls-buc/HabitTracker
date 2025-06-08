//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by Andres Landazabal on 2025/06/08.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = [] {
        didSet {
            saveHabits()
        }
    }
    
    private let habitsKey = "SavedHabits"

    init() {
        loadHabits()
    }
   // Funcion para anadir habitos.
    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }
//Funcion de habitos completados.
    func completeHabit(_ habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].isCompletedToday = true
            
        }
    }
    
    // Funciones para eliminar habitos.
    func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
        saveHabits()
    }

    func deleteHabit(_ habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits.remove(at: index)
            saveHabits()
        }
    }

    private func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: habitsKey)
        }
    }

    private func loadHabits() {
        if let data = UserDefaults.standard.data(forKey: habitsKey),
           let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
            habits = decoded
        }
    }
}
