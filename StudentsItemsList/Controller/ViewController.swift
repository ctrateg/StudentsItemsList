import UIKit
import CoreData

class ViewController: UIViewController {
    static var indexPathRow: Int? = nil
    
    let student = Students()
    
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
        let secondNameStudent = "\(secondNameTextField.text ?? "")"
        let nameStudent = "\(nameTextField.text ?? "")"
        let raiting = raitingTextField.text ?? ""
        
        
        // name check logic
        if containsLetters(input: nameStudent) == true {
            // secondName check logic
            if containsLetters(input: secondNameStudent) == true {
                // raiting check logic
                if containsRaiting(input: raiting) == true {
                    
                    saveOrEditLogic(nameStudent, secondNameStudent, raiting)
                    
                } else {
                    alert(typeError: "raiting")
                }
            } else {
                alert(typeError: "second name")
            }
        } else {
            alert(typeError: "name")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        student.loadItems()
    }
    
    /// Check nameTextField and secondNameTextField for correct input
    /// - Parameter input: String
    /// - Returns: Bool
    func containsLetters(input: String) -> Bool {
        switch input.lowercased() {
        case "a"..."z":
            return true
        case "а"..."я":
            return true 
        default:
            return false
        }
    }
    
    /// Check raitingTextField for correct input
    /// - Parameter input: Int
    /// - Returns: Bool
    func containsRaiting(input: String) -> Bool {
        
        if (Int(input) ?? 0 >= 1) && (Int(input) ?? 0 <= 5) {
            return true
        }
        return false
    }

    
    
    func saveOrEditLogic( _ name: String, _ secondName: String, _ raiting: String){
        
        if  ViewController.indexPathRow != nil {
        
            student.editData(name, secondName, raiting, indexPathRow: ViewController.indexPathRow ?? 0)
            
            ViewController.indexPathRow = nil
            
            dismiss(animated: true, completion: nil)
            
        } else {
            
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
        }
    
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDataNotification"), object: nil)
        
    }
    
    func alert(typeError: String) {
        let ac = UIAlertController(title: "Error", message: "Wrong \(typeError)", preferredStyle: .alert)
    
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
        present(ac, animated: true)
    }
}
