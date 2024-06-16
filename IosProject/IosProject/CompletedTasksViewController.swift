import UIKit

class CompletedTasksViewController: UIViewController {
    
    var completedTasks: [TodoList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white // 팝업 배경색 설정
        setupUI()
    }
    
    func setupUI() {
        // Title Label
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "완료된 일들"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor(red: 0.678, green: 0.847, blue: 0.902, alpha: 1.0) // 민트색 배경
        titleLabel.layer.cornerRadius = 5
        titleLabel.layer.masksToBounds = true
        
        // Tasks Label
        let tasksLabel = UILabel()
        tasksLabel.translatesAutoresizingMaskIntoConstraints = false
        tasksLabel.numberOfLines = 0
        tasksLabel.textAlignment = .center
        tasksLabel.backgroundColor = .black
        tasksLabel.textColor = .white
        tasksLabel.layer.cornerRadius = 5
        tasksLabel.layer.masksToBounds = true

        let tasksText = completedTasks.isEmpty ? "완료된 일이 없습니다." : completedTasks.map { $0.title }.joined(separator: "\n")
        tasksLabel.text = tasksText
        
        // Confirm Button
        let confirmButton = UIButton(type: .system)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.addTarget(self, action: #selector(dismissPopover), for: .touchUpInside)
        confirmButton.backgroundColor = UIColor(red: 1.0, green: 0.843, blue: 0.0, alpha: 1.0) // 노란색 배경
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.layer.cornerRadius = 5
        
        view.addSubview(titleLabel)
        view.addSubview(tasksLabel)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            // Title Label Constraints
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            // Tasks Label Constraints
            tasksLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tasksLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            tasksLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            tasksLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            // Confirm Button Constraints
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.topAnchor.constraint(equalTo: tasksLabel.bottomAnchor, constant: 10),
            confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            confirmButton.heightAnchor.constraint(equalToConstant: 40),
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func dismissPopover() {
        self.dismiss(animated: true, completion: nil)
    }
}
