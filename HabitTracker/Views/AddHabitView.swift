import SwiftUI

struct AddHabitView: View {
    @EnvironmentObject var viewModel: HabitViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var name = ""
    @State private var description = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre del hábito", text: $name)
                TextField("Descripción", text: $description)
            }
            .navigationTitle("Nuevo Hábito")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        let newHabit = Habit(name: name, description: description)
                        viewModel.addHabit(newHabit)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(name.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
