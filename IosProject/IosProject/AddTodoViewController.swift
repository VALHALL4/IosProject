import UIKit

class AddTodoViewController: UIViewController {
    
    
    @IBOutlet weak var deadlineDatepicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Set date picker mode to date and time
        deadlineDatepicker.datePickerMode = .dateAndTime
        
    }
    
    @IBAction func AddListItemAction(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty else {
            // Handle the case where the title is empty
            return
        }
        
        let deadline = deadlineDatepicker.date
        let item = TodoList(title: title, deadline: deadline)
        
        TodoListManager.shared.list.append(item)
        TodoListManager.shared.saveAllData()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func canclebtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
