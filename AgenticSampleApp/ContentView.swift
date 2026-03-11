//
//  ContentView.swift
//  AgenticSampleApp
//
//  Created by Jesse Holwell on 11/3/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var store = TodoStore()
    @State private var newTodoTitle = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.todos) { todo in
                    TodoRow(todo: todo) {
                        store.toggle(todo)
                    }
                }
                .onDelete { store.delete(at: $0) }
            }
            .navigationTitle("Todos")
            .overlay {
                if store.todos.isEmpty {
                    ContentUnavailableView("No Todos", systemImage: "checklist")
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    TextField("New todo", text: $newTodoTitle)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityIdentifier("newTodoField")
                    Button("Add") {
                        store.add(title: newTodoTitle)
                        newTodoTitle = ""
                    }
                    .disabled(newTodoTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                    .accessibilityIdentifier("addButton")
                }
                .padding()
                .background(.regularMaterial)
            }
        }
    }
}

struct TodoRow: View {
    let todo: Todo
    let onToggle: () -> Void

    var body: some View {
        Button(action: onToggle) {
            HStack {
                Image(systemName: todo.isComplete ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(todo.isComplete ? .green : .secondary)
                Text(todo.title)
                    .strikethrough(todo.isComplete)
                    .foregroundStyle(todo.isComplete ? .secondary : .primary)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ContentView()
}
