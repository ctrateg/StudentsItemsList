import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.shouldReload), name: NSNotification.Name(rawValue: "reloadDataNotification"), object: nil)
    }
    
    @objc func shouldReload() {
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationAboutStudent.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentStudent = informationAboutStudent[indexPath.row]
        
        cell.textLabel?.text = currentStudent["Name"]! + " " + currentStudent["SecondName"]!
        cell.detailTextLabel?.text = currentStudent["Raiting"]!
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    //Open then tapped cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let studentData = informationAboutStudent[indexPath.row]
        
        let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        
        let changeVc = storyboard.instantiateViewController(withIdentifier: "AddInformation") as! ViewController
        
        changeVc.indexPathRow = indexPath.row
        changeVc.loadViewIfNeeded()
        changeVc.nameTextField.text = studentData["Name"]
        changeVc.secondNameTextField.text = studentData["SecondName"]
        changeVc.raitingTextField.text = studentData["Raiting"]
        
        self.present(changeVc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deletAction = UIContextualAction(style: .destructive, title: "Delet") {_,_,_ in
            informationAboutStudent.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deletAction])
        
        return swipeActions
    }
}
