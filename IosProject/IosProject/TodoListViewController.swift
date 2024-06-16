import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: TodoListViewController.self, action: #selector(doneButtonAction))
    
    @objc func doneButtonAction() {
        self.navigationItem.leftBarButtonItem = editButton
        todoListTable.setEditing(false, animated: true)
    }
    
    @objc func editButtonAction() {
        guard !TodoListManager.shared.list.isEmpty else {
            return
        }
        self.navigationItem.leftBarButtonItem = doneButton
        todoListTable.setEditing(true, animated: true)
    }
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var todoListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.style = .plain
        doneButton.target = self
        todoListTable.delegate = self
        todoListTable.dataSource = self
        TodoListManager.shared.loadAllData()
        todoListTable.rowHeight = 80
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TodoListManager.shared.saveAllData()
        todoListTable.reloadData()
    }
    
    @IBAction func EditbtnAction(_ sender: Any) {
        guard !TodoListManager.shared.list.isEmpty else {
            return
        }
        self.navigationItem.leftBarButtonItem = doneButton
        todoListTable.setEditing(true, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoListManager.shared.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        let todoItem = TodoListManager.shared.list[indexPath.row]
        
        cell.titleLabel.text = todoItem.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        if let deadline = todoItem.deadline {
            cell.deadlineLabel.text = dateFormatter.string(from: deadline)
        } else {
            cell.deadlineLabel.text = "No Deadline"
        }
        
        if todoItem.isComplete {
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
        todoListTable.reloadData()
        TodoListManager.shared.saveAllData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !TodoListManager.shared.list[indexPath.row].isComplete else {
            return
        }
        
        TodoListManager.shared.list[indexPath.row].isComplete = true
        TodoListManager.shared.list[indexPath.row].completionDate = Date()
        
        let dialog = UIAlertController(title: "Todo List", message: "할 일을 완료했습니다!!!", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        dialog.addAction(action)
        self.present(dialog, animated: true, completion: nil)
        
        todoListTable.reloadData()
        TodoListManager.shared.saveAllData()
    }
    
}
