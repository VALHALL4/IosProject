import Foundation

struct TodoList {
    var title: String = ""
    var content: String?
    var isComplete: Bool = false
    var completionDate: Date?

    init(title: String, content: String?, isComplete: Bool = false, completionDate: Date? = nil) {
        self.title = title
        self.content = content
        self.isComplete = isComplete
        self.completionDate = completionDate
    }
}
