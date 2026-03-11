import Foundation
import Observation

@Observable
class TodoStore {
    var todos: [Todo] = []

    // BUG: returns incomplete todos instead of completed ones.
    // This is intentionally broken — ask the agent to find and fix it.
    var completedTodos: [Todo] {
        todos.filter { !$0.isComplete }
    }

    func add(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        todos.append(Todo(title: trimmed))
    }

    func toggle(_ todo: Todo) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        todos[index].isComplete.toggle()
    }

    func delete(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}
