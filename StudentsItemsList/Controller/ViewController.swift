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
        let result = checkTF(nameStudent, secondNameStudent, Int(raiting) ?? 0)
        
        if result == (true, "fine"){
            saveOrEditLogic(nameStudent,secondNameStudent,raiting)
        } else {
            alertContains(typeError: result.1)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        student.loadItems()
    }
    
    
    func contains(_ letter: String) -> Bool {
        var result = Bool()
        switch letter.lowercased() {
        case "a"..."z":
            result = true
        case "а"..."я":
            result =  true
        default:
            result = false
        }
        return result
    }
    
    
    func checkTF(_ name: String, _ secondName: String, _ raiting: Int) -> (Bool, String) {
        if contains(name) == false {
            return (false, name)
        }
        
        if contains(secondName) == false  {
            return (false, secondName)
        }
        
        if contains(raiting) == false  {
            return (false, String(raiting))
        }
        
        return (true, "fine")
    }
    
    
    func contains(_ raiting: Int) -> Bool{
        if raiting >= 1 && raiting <= 5{
            return true
        } else {
            return false
        }
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
    
    
    func alertContains(typeError: String) {
        let ac = UIAlertController(title: "Error", message: "U are cant add \(typeError)", preferredStyle: .alert)
    
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
        present(ac, animated: true)
    }
    
    
    func saveOrEditLogic( _ name: String, _ secondName: String, _ raiting: String){
        if indexPathRow == nil{
            save(name, secondName, raiting)
        }  else {
            edit(name, secondName, raiting)
        }
    }
}
