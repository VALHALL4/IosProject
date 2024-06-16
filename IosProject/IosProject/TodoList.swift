import Foundation

struct TodoList {
    var title: String = ""
    var deadline: Date?
    var isComplete: Bool = false
    var completionDate: Date?

    init(title: String, deadline: Date? = nil, isComplete: Bool = false, completionDate: Date? = nil) {
        self.title = title
        self.deadline = deadline
        self.isComplete = isComplete
        self.completionDate = completionDate
    }
}
