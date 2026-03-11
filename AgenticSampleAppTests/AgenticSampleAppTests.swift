import Foundation
import Testing
@testable import AgenticSampleApp

@Suite("TodoStore")
struct TodoStoreTests {

    // Each @Test gets a fresh struct instance, so each test starts with a clean store.
    var store = TodoStore()

    // MARK: - add

    @Test func add_appendsTodo() {
        var store = TodoStore()
        store.add(title: "Buy milk")
        #expect(store.todos.count == 1)
        #expect(store.todos[0].title == "Buy milk")
        #expect(store.todos[0].isComplete == false)
    }

    @Test func add_trimsWhitespace() {
        var store = TodoStore()
        store.add(title: "  Walk the dog  ")
        #expect(store.todos[0].title == "Walk the dog")
    }

    @Test func add_withEmptyTitle_doesNotAdd() {
        var store = TodoStore()
        store.add(title: "")
        #expect(store.todos.isEmpty)
    }

    @Test func add_withWhitespaceOnly_doesNotAdd() {
        var store = TodoStore()
        store.add(title: "   ")
        #expect(store.todos.isEmpty)
    }

    // MARK: - toggle

    @Test func toggle_marksIncompleteAsComplete() {
        var store = TodoStore()
        store.add(title: "Walk the dog")
        store.toggle(store.todos[0])
        #expect(store.todos[0].isComplete == true)
    }

    @Test func toggle_marksCompleteAsIncomplete() {
        var store = TodoStore()
        store.add(title: "Walk the dog")
        store.toggle(store.todos[0])
        store.toggle(store.todos[0])
        #expect(store.todos[0].isComplete == false)
    }

    // MARK: - delete

    @Test func delete_removesItemAtOffset() {
        var store = TodoStore()
        store.add(title: "First")
        store.add(title: "Second")
        store.delete(at: IndexSet(integer: 0))
        #expect(store.todos.count == 1)
        #expect(store.todos[0].title == "Second")
    }

    // MARK: - completedTodos

    // INTENTIONALLY FAILING — validates the agentic feedback loop.
    // The bug is in TodoStore.completedTodos. Ask the agent to find and fix it.
    @Test func completedTodos_returnsOnlyCompletedItems() {
        var store = TodoStore()
        store.add(title: "First")
        store.add(title: "Second")
        store.toggle(store.todos[0]) // First is now complete

        #expect(store.completedTodos.count == 1)
        #expect(store.completedTodos[0].title == "First")
    }
}
