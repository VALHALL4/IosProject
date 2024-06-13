import UIKit


class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        return cell
    }
    

    @IBOutlet weak var todoLIstTabel: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoLIstTabel.delegate = self
        todoLIstTabel.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBAction func EditbtnAction(_ sender: Any) {
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
 
