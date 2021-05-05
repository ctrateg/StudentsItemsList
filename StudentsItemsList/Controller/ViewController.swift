import UIKit

class ViewController: UIViewController {
    
    var indexPathRow: Int = -1
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var raitingTextField: UITextField!
    
    //Cancel button
    @IBAction func cancelButton(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }
    
    /// Save button, relize check textField, creat new student, edit student
    /// - Parameter sender: Any
    @IBAction func saveButton(_ sender: Any) {
        let secondNameStudent = "\(secondNameTextField.text ?? "")"
        let nameStudent = "\(nameTextField.text ?? "")"
        let raiting = raitingTextField.text ?? ""
        
        if (containsLetters(input: nameStudent) && containsLetters(input: secondNameStudent)) == true {
            if containsRaiting(input: Int(raiting) ?? 0) == true {
                
                saveData(name: nameStudent, secondName: secondNameStudent, raiting: raiting)
                
                let ac = UIAlertController(title: "Seccessfull", message: "", preferredStyle: .alert)
                
                present(ac, animated: true)
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotificationForItemEdit"), object: nil)
                dismiss(animated: true, completion: nil)
                
            } else {
                let ac = UIAlertController(title: "Error", message: "Wrong raiting", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                present(ac, animated: true)
            }
        } else {
            let ac = UIAlertController(title: "Error", message: "Wrong name or second name", preferredStyle: .alert)
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
        for chr in input {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && (!(chr >= "а" && chr <= "я") && !(chr >= "А" && chr <= "Я")) ) {
                return false
            }
        }
        return true
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
    
    /// Save in UserDefaults data and check input string data, relize edit save too
    /// - Parameters:
    ///   - name: String
    ///   - secondName: String
    ///   - raiting: String
    public func saveData(name: String, secondName: String, raiting: String) {
        if indexPathRow == -1 {
            informationAboutStudent.append(["Name": name,"SecondName": secondName, "Raiting": raiting])
            UserDefaults.standard.set(informationAboutStudent, forKey: informationAboutStudentKey)
        } else {
            informationAboutStudent[indexPathRow]["Name"] = name
            informationAboutStudent[indexPathRow]["SecondName"] = secondName
            informationAboutStudent[indexPathRow]["Raiting"] = raiting
            indexPathRow = 0
        }
    }
}
