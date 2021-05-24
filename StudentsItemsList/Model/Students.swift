import Foundation

class Students {
    static var informationAboutStudent: [[String: String]] = []
    static var indexPathRow: Int = -1
    
    enum StudentsDataLink {
        static let informationAboutStudentKey = "informationAboutStudentKey"
        static let name = "Name"
        static let secondName = "SecondName"
        static let raiting = "Raiting"
    }
    
    func saveData(name: String, secondName: String, raiting: String) {
        if Students.indexPathRow == -1 {
            Students.informationAboutStudent.append([StudentsDataLink.name: name, StudentsDataLink.secondName: secondName, StudentsDataLink.raiting: raiting])
            
            UserDefaults.standard.set(Students.informationAboutStudent, forKey: StudentsDataLink.informationAboutStudentKey)
            
            } else {
               
                Students.informationAboutStudent[Students.indexPathRow][StudentsDataLink.name] = name
                Students.informationAboutStudent[Students.indexPathRow][StudentsDataLink.secondName] = secondName
                Students.informationAboutStudent[Students.indexPathRow][StudentsDataLink.raiting] = raiting
            
            Students.indexPathRow = 0
        }
    }
    
    func editLoad(name: String, secondName: String, raiting: String){
        
    }
}



