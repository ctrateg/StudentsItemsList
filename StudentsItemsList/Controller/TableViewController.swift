import UIKit
import CoreData

class TableViewController: UITableViewController {
    let student = Students()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        student.loadItems()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.shouldReload), name: NSNotification.Name(rawValue: "reloadDataNotification"), object: nil)
    }
    
    
    @objc func shouldReload() {
        self.tableView.reloadData()
        student.loadItems()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return student.informationAboutStudent.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentStudent = student.informationAboutStudent[indexPath.row]
        
        cell.textLabel?.text = (currentStudent.name ?? "") + " " + (currentStudent.secondName ?? "")
        cell.detailTextLabel?.text = currentStudent.raiting
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    //Open then tapped cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let studentData = student.informationAboutStudent[indexPath.row]
        
        let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        
        let changeVc = storyboard.instantiateViewController(withIdentifier: "AddInformation") as! ViewController
        
        changeVc.loadViewIfNeeded()
        changeVc.nameTextField.text = studentData.name
        changeVc.secondNameTextField.text = studentData.secondName
        changeVc.raitingTextField.text = studentData.raiting
        changeVc.indexPathRow = indexPath.row
        
        self.present(changeVc, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    
    // delet button after 11 version
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deletAction = UIContextualAction(style: .destructive, title: "Delet") {_,_,_ in
            self.student.informationAboutStudent.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deletAction])
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(student.informationAboutStudent[indexPath.row])
        
        do {
            try context.save()
            
        } catch let error as NSError {
            print("Ошибка при сохранении: \(error), \(error.userInfo)")
        }
        
        return swipeActions
    }
    
    
    //delet button до 11 version
    @available(iOS, deprecated: 11.0)
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") { _, indexPath in
            self.student.informationAboutStudent.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(student.informationAboutStudent[indexPath.row])
        
        do {
            try context.save()
            
        } catch let error as NSError {
            print("Ошибка при сохранении: \(error), \(error.userInfo)")
        }
        
        return [deleteAction]
    }
}
