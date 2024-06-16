import Foundation

class TodoListManager {
    static let shared = TodoListManager()
    var list = [TodoList]()
    var completedList = [TodoList]() // 완료된 할 일들을 저장하는 배열

    private init() {}
    
    func saveAllData() {
        let data = list.map {
            [
                "title": $0.title,
                "deadline": $0.deadline?.timeIntervalSince1970 ?? 0,
                "isComplete": $0.isComplete,
                "completionDate": $0.completionDate?.timeIntervalSince1970 ?? 0
            ] as [String : Any]
        }
        
        let completedData = completedList.map {
            [
                "title": $0.title,
                "deadline": $0.deadline?.timeIntervalSince1970 ?? 0,
                "isComplete": $0.isComplete,
                "completionDate": $0.completionDate?.timeIntervalSince1970 ?? 0
            ] as [String : Any]
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "items")
        userDefaults.set(completedData, forKey: "completedItems")
        userDefaults.synchronize()
    }
    
    func loadAllData() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "items") as? [[String: AnyObject]] else {
            return
        }
        guard let completedData = userDefaults.object(forKey: "completedItems") as? [[String: AnyObject]] else {
            return
        }
        
        list = data.map {
            let title = $0["title"] as? String ?? ""
            let deadline = $0["deadline"] as?  TimeInterval ?? 0
            let isComplete = $0["isComplete"] as? Bool ?? false
            let completionDate = $0["completionDate"] as? TimeInterval ?? 0
            return TodoList(title: title, deadline: deadline == 0 ? nil : Date(timeIntervalSince1970: deadline), isComplete: isComplete, completionDate: completionDate == 0 ? nil : Date(timeIntervalSince1970: completionDate))
        }
        
        completedList = completedData.map {
            let title = $0["title"] as? String ?? ""
            let deadline = $0["deadline"] as? TimeInterval ?? 0
            let isComplete = $0["isComplete"] as? Bool ?? false
            let completionDate = $0["completionDate"] as? TimeInterval ?? 0
            return TodoList(title: title, deadline: deadline == 0 ? nil : Date(timeIntervalSince1970: deadline), isComplete: isComplete, completionDate: completionDate == 0 ? nil : Date(timeIntervalSince1970: completionDate))
        }
    }
}
