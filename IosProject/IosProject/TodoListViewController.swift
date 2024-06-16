import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: TodoListViewController.self, action: #selector(doneButtonAction))
         
    @objc func doneButtonAction() {
        self.navigationItem.leftBarButtonItem = editButton
        todoLIstTabel.setEditing(false, animated: true)
    }
       
    @objc func editButtonAction() {
        guard !TodoListManager.shared.list.isEmpty else {
            return
        }
           
        self.navigationItem.leftBarButtonItem = doneButton
        todoLIstTabel.setEditing(true, animated: true)
    }
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var todoLIstTabel: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.style = .plain
        doneButton.target = self
        todoLIstTabel.delegate = self
        todoLIstTabel.dataSource = self
        TodoListManager.shared.list.append(TodoList(title: "test1", content: "testdata1"))
        TodoListManager.shared.loadAllData()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TodoListManager.shared.saveAllData()
        todoLIstTabel.reloadData()
    }
    
    @IBAction func EditbtnAction(_ sender: Any) {
        guard !TodoListManager.shared.list.isEmpty else {
            return
        }
        self.navigationItem.leftBarButtonItem = doneButton
        todoLIstTabel.setEditing(true, animated: true)
    }
    
//    func saveAllData() {
//        let data = TodoListManager.shared.list.map {
//            [
//                "title": $0.title,
//                "content": $0.content ?? "",
//                "isComplete": $0.isComplete,
//                "completionDate": $0.completionDate?.timeIntervalSince1970 ?? 0
//            ] as [String : Any]
//        }
//        
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(data, forKey: "items")
//        userDefaults.synchronize()
//    }
//    
//    func loadAllData() {
//        let userDefaults = UserDefaults.standard
//        guard let data = userDefaults.object(forKey: "items") as? [[String: AnyObject]] else {
//            return
//        }
//        
//        TodoListManager.shared.list = data.map {
//            let title = $0["title"] as? String ?? ""
//            let content = $0["content"] as? String ?? ""
//            let isComplete = $0["isComplete"] as? Bool ?? false
//            let completionDate = $0["completionDate"] as? TimeInterval ?? 0
//            return TodoList(title: title, content: content, isComplete: isComplete, completionDate: completionDate == 0 ? nil : Date(timeIntervalSince1970: completionDate))
//        }
//    }
//    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoListManager.shared.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
        cell.textLabel?.text = TodoListManager.shared.list[indexPath.row].title
        cell.detailTextLabel?.text = TodoListManager.shared.list[indexPath.row].content
        if TodoListManager.shared.list[indexPath.row].isComplete {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let completedTask = TodoListManager.shared.list.remove(at: indexPath.row)
        if completedTask.isComplete {
            TodoListManager.shared.completedList.append(completedTask)
        }
        todoLIstTabel.reloadData()
        TodoListManager.shared.saveAllData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !TodoListManager.shared.list[indexPath.row].isComplete else {
            return
        }
        
        TodoListManager.shared.list[indexPath.row].isComplete = true
        TodoListManager.shared.list[indexPath.row].completionDate = Date()
        
        let dialog = UIAlertController(title: "Todo List", message: "일을 완료했습니다!!!!!", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        dialog.addAction(action)
        self.present(dialog, animated: true, completion: nil)
        
        todoLIstTabel.reloadData()
        TodoListManager.shared.saveAllData()
    }
}
