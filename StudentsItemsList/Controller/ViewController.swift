import UIKit
import CoreData

class ViewController: UIViewController {
    let student = Students()
    var indexPathRow: Int?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var raitingTextField: UITextField!
    
    //Cancel button
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    /// Save button, relize check textField, creat new student, edit student
    /// - Parameter sender: Any
    @IBAction func saveButton(_ sender: Any) {
        let secondNameStudent = secondNameTextField.text ?? ""
        let nameStudent = nameTextField.text ?? ""
        let raiting = raitingTextField.text ?? ""
        let person = [nameStudent, secondNameStudent, raiting]
        
        switch contains(person) {
        case "":
            if indexPathRow != nil {
                save(nameStudent, secondNameStudent, raiting)
            } else {
                edit(nameStudent, secondNameStudent, raiting)
            }
            
        default:
            alert(typeError: contains(person))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        student.loadItems()
    }
    
    func contains(_ persons: [String]) -> String {
        var result = ""
        for person in persons {
            switch person.lowercased() {
            case "a"..."z":
                result = ""
            case "а"..."я":
                result = ""
            case "1"..."5":
                result = ""
            default:
                result = "\(person)"
            }
        }
        return result
    }


    
    
    func edit( _ name: String, _ secondName: String, _ raiting: String){
            student.editData(name, secondName, raiting, indexPathRow: indexPathRow ?? 0)

            dismiss(animated: true, completion: nil)
    
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDataNotification"), object: nil)
        
    }
    
    func save(_ name: String, _ secondName: String, _ raiting: String){
        student.saveData(name, secondName, raiting)
        
        let ac = UIAlertController(title: "Save successful", message: "Add another one?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel){_ in
            
            self.navigationController?.popToRootViewController(animated: true)
            
        })
        
        ac.addAction(UIAlertAction(title: "NewStudent", style: .default){ [self]_ in
            nameTextField.text = ""
            secondNameTextField.text = ""
            raitingTextField.text = ""
        })
        
        present(ac, animated: true)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDataNotification"), object: nil)
    }
    
    func alert(typeError: String) {
        let ac = UIAlertController(title: "Error", message: "U are cant add \(typeError)", preferredStyle: .alert)
    
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
        present(ac, animated: true)
    }
}
