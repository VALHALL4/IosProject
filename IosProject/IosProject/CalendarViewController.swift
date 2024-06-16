import UIKit

class CalendarViewController: UIViewController {
    
    lazy var dateView: UICalendarView = {
        var view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsDateDecorations = true
        return view
    }()
    
    var selectedDate: DateComponents? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        applyConstraints()
        setCalendar()
        reloadDateView(date: Date())
    }

    fileprivate func setCalendar() {
        dateView.delegate = self

        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateView.selectionBehavior = dateSelection
    }
    
    fileprivate func applyConstraints() {
        view.addSubview(dateView)
        
        let dateViewConstraints = [
            dateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(dateViewConstraints)
    }
    
    func reloadDateView(date: Date?) {
        guard let date = date else { return }
        let calendar = Calendar.current
        dateView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date)], animated: true)
    }
}

extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        let calendar = Calendar.current
        guard let date = calendar.date(from: dateComponents) else { return nil }
        
        let allTasks = TodoListManager.shared.list + TodoListManager.shared.completedList
        let completedTasks = allTasks.filter {
            guard let completionDate = $0.completionDate else { return false }
            return Calendar.current.isDate(completionDate, inSameDayAs: date)
        }
        
        let count = completedTasks.count
        var color: UIColor = .clear
        
        switch count {
        case 1:
            color = UIColor(red: 0.6, green: 1.0, blue: 0.6, alpha: 1.0) // 연두색
        case 2:
            color = UIColor(red: 0.3, green: 0.8, blue: 0.3, alpha: 1.0) // 초록색
        case 3...:
            color = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0) // 진한 녹색
        default:
            color = .clear
        }
        
        return .customView {
            let view = UIView()
            view.backgroundColor = color
            view.layer.cornerRadius = 15 // 원하는 크기로 조정
            view.frame = CGRect(x: 0, y: 0, width: 30, height: 30) // 크기 지정
            return view
        }
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        if let dateComponents = dateComponents {
            reloadDateView(date: Calendar.current.date(from: dateComponents))
            showCompletedTasks(for: dateComponents)
        }
    }
    
    func showCompletedTasks(for dateComponents: DateComponents) {
        guard let selectedDate = Calendar.current.date(from: dateComponents) else { return }
        
        let allTasks = TodoListManager.shared.list + TodoListManager.shared.completedList
        let completedTasks = allTasks.filter {
            guard let completionDate = $0.completionDate else { return false }
            return Calendar.current.isDate(completionDate, inSameDayAs: selectedDate)
        }
        
        var message = "완료된 일이 없습니다."
        if !completedTasks.isEmpty {
            message = completedTasks.map { $0.title }.joined(separator: "\n")
        }
        
        let alert = UIAlertController(title: "완료된 일들", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
