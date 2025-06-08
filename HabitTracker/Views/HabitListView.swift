import SwiftUI

struct HabitListView: View {
    @EnvironmentObject var viewModel: HabitViewModel
    @State private var showCompletionAlert = false
    @State private var completedHabitName = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.habits) { habit in
                    habitRow(habit)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                        .listRowSeparator(.hidden)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                viewModel.deleteHabit(habit)
                            } label: {
                                Label("Eliminar", systemImage: "trash.fill")
                            }
                        }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Tus Hábitos")
            .alert("¡Bien hecho!", isPresented: $showCompletionAlert) {
                Button("OK") {}
            } message: {
                Text("Completaste '\(completedHabitName)' hoy 🎉")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddHabitView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func habitRow(_ habit: Habit) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(habit.name)
                    .font(.headline)
                Text(habit.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if habit.isCompletedToday {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title2)
            } else {
                Button {
                    viewModel.completeHabit(habit)
                    completedHabitName = habit.name
                    showCompletionAlert = true
                } label: {
                    Text("Hecho")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(habit.isCompletedToday ? Color.green.opacity(0.1) : Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .padding(.horizontal, 8)
    }
}
