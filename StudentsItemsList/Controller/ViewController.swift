import UIKit

class ViewController: UIViewController {
    static var indexPathRow: Int? = nil
    var student = Students()
    
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
                if containsRaiting(input: Int(raiting) ?? 0) == true {
                    //save or edit logic
                    if  ViewController.indexPathRow != nil{
                        student.editLoad(name: nameStudent, secondName: secondNameStudent, raiting: raiting, indexPathRow: ViewController.indexPathRow ?? 0)
                    } else {
                        student.saveData(name: nameStudent, secondName: secondNameStudent, raiting: raiting)
                    }
                
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDataNotification"), object: nil)
                
                    self.navigationController?.popToRootViewController(animated: true)
                    dismiss(animated: true, completion: nil)
                
                } else {
                    let ac = UIAlertController(title: "Error", message: "Wrong raiting", preferredStyle: .alert)
                
                    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                    present(ac, animated: true)
                }
            } else {
                let ac = UIAlertController(title: "Error", message: "Wrong second name", preferredStyle: .alert)
            
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
                present(ac, animated: true)
            }
        } else {
            let ac = UIAlertController(title: "Error", message: "Wrong name name", preferredStyle: .alert)
        
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
            present(ac, animated: true)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Check nameTextField and secondNameTextField for correct input
    /// - Parameter input: String
    /// - Returns: Bool
    func containsLetters(input: String) -> Bool {
        var inputResult:Bool = false
        
        input.lowercased().forEach{ chr in
            if ("a"..."z").contains(String(chr)) == true || ("а"..."я").contains(String(chr)) == true {
                inputResult = true
            }
        }
        return inputResult
    }
    
    /// Check raitingTextField for correct input
    /// - Parameter input: Int
    /// - Returns: Bool
    func containsRaiting(input: Int) -> Bool {
        if (input >= 1) && (input <= 5) {
            return true
        }
        return false
    }
}
