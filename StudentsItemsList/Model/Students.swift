import CoreData
import UIKit

class Students {
    
    static var informationAboutStudent: [StudentsEntity] = []
    
    // links
    let nameAttributeKey = "name"
    let secondNameAttributeKey = "secondName"
    let raitingAttributeKey = "raiting"
    
    //save function
    static func saveData(_ name: String, _ secondName: String, _ raiting: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = StudentsEntity(context: context)
        
        entity.name = name
        entity.secondName = secondName
        entity.raiting = raiting
       
        do {
            try context.save()
            
            Students.informationAboutStudent.append(entity)
            
        } catch let error as NSError {
            
            print("Ошибка при сохранении: \(error), \(error.userInfo)")
            
        }
    }
    
    static func loadItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<StudentsEntity>(entityName: "StudentsEntity")
        
        do {
            
            informationAboutStudent = try context.fetch(request)
            
        } catch let error as NSError {
            
            print("Ошибка при загрузке данных: \(error), \(error.userInfo)")
            
        }
    }
    
    // edit funcion
    static func editData(_ name: String, _ secondName: String, _ raiting: String, indexPathRow: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let studentData = Students.informationAboutStudent[indexPathRow]
        
        studentData.name = name
        studentData.secondName = secondName
        studentData.raiting = raiting
        
        do {
            
            try context.save()
            
        } catch let error as NSError {
            
            print("Ошибка при сохранении: \(error), \(error.userInfo)")
            
        }
    }
}
