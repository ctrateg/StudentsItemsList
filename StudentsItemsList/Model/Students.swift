import CoreData
import UIKit

class Students {
    var informationAboutStudent: [StudentsEntity] = []
    
    
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
            
            informationAboutStudent.append(entity)
            
        } catch let error as NSError {
            
            print("Ошибка при сохранении: \(error), \(error.userInfo)")
            
        }
    }
    
    
    func loadItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<StudentsEntity>(entityName: "StudentsEntity")
        
        do {
            
            self.informationAboutStudent = try context.fetch(request)
            informationAboutStudent.sort( by: < )
            
        } catch let error as NSError {
            
            print("Ошибка при загрузке данных: \(error), \(error.userInfo)")
            
        }
    }
    
    
    // edit funcion
    func editData(_ name: String, _ secondName: String, _ raiting: String, indexPathRow: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let studentData = informationAboutStudent[indexPathRow]
        
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
