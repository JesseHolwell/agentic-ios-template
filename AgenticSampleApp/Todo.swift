import Foundation

struct Todo: Identifiable {
    let id: UUID
    var title: String
    var isComplete: Bool

    init(id: UUID = UUID(), title: String, isComplete: Bool = false) {
        self.id = id
        self.title = title
        self.isComplete = isComplete
    }
}
