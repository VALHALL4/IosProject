//
//  AddTodoViewController.swift
//  IosProject
//
//  Created by hanseongmin on 2024/06/13.
//

import UIKit

class AddTodoViewController: UIViewController {

    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.layer.borderColor = UIColor.gray.cgColor
        contentTextView.layer.borderWidth = 0.3
        contentTextView.layer.cornerRadius = 2.0
        contentTextView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddListItemAction(_ sender: Any) {
        let title = titleTextField.text!
        let content = contentTextView.text ?? ""
                
        let item: TodoList = TodoList(title: title, content: content)
                
        print("Add List title : \(item.title)")
                // TodoListViewController에 생성한 전역변수에 append
        TodoListManager.shared.list.append(item)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func canclebtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
