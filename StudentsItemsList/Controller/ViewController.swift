import UIKit
import CoreData

class ViewController: UIViewController {
    static var indexPathRow: Int? = nil
    
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
                
                alert(typeError: "second name ")
                
            }
        } else {
            
            alert(typeError: "name")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewController.loadItems()
    }
    
    /// Check nameTextField and secondNameTextField for correct input
    /// - Parameter input: String
    /// - Returns: Bool
    func containsLetters(input: String) -> Bool {
        for chr in input.lowercased() {
            if !("a"..."z").contains(String(chr)) && !("а"..."я").contains(String(chr)) {
                return false
            }
        }
        return true
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

    static var informationAboutStudent: [StudentsEntity] = []
    
    // links
    let nameAttributeKey = "name"
    let secondNameAttributeKey = "secondName"
    let raitingAttributeKey = "raiting"
    
    
    //save function
    func saveData(_ name: String, _ secondName: String, _ raiting: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = StudentsEntity(context: context)
        
        entity.name = name
        entity.secondName = secondName
        entity.raiting = raiting
       
        do {
            try context.save()
            
            ViewController.informationAboutStudent.append(entity)
            
        } catch let error as NSError {
            print("Ошибка при сохранении: \(error), \(error.userInfo)")
        }
    }
    
    static func loadItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<StudentsEntity>(entityName: "StudentsEntity")
        
        do {
            ViewController.informationAboutStudent = try context.fetch(request)
        } catch let error as NSError {
            print("Ошибка при загрузке данных: \(error), \(error.userInfo)")
        }
    }
    
    // edit funcion
    func editData(_ name: String, _ secondName: String, _ raiting: String, indexPathRow: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let studentData = ViewController.informationAboutStudent[indexPathRow]
        
        studentData.name = name
        studentData.secondName = secondName
        studentData.raiting = raiting
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Ошибка при сохранении: \(error), \(error.userInfo)")
        }
    }
    
    func saveOrEditLogic( _ name: String, _ secondName: String, _ raiting: String){
        
        if  ViewController.indexPathRow != nil {
        
            editData(name, secondName, raiting, indexPathRow: ViewController.indexPathRow ?? 0)
            
            ViewController.indexPathRow = nil
        } else {
            
            saveData(name, secondName, raiting)
        }
    
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDataNotification"), object: nil)
    
        self.navigationController?.popToRootViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    func alert(typeError: String) {
        let ac = UIAlertController(title: "Error", message: "Wrong \(typeError)", preferredStyle: .alert)
    
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
        present(ac, animated: true)
    }
}
