import Foundation

class Students {
    static var informationAboutStudent: [[String: String]] = []
    static var indexPathRow: Int = -1
    
    let informationAboutStudentKey = "informationAboutStudentKey"
    
    func saveData(name: String, secondName: String, raiting: String) {
        if Students.indexPathRow == -1 {
            Students.informationAboutStudent.append(["Name": name, "SecondName": secondName, "Raiting": raiting])
            
            UserDefaults.standard.set(Students.informationAboutStudent, forKey: informationAboutStudentKey)
            
            } else {
               
            Students.informationAboutStudent[Students.indexPathRow]["Name"] = name
            Students.informationAboutStudent[Students.indexPathRow]["SecondName"] = secondName
            Students.informationAboutStudent[Students.indexPathRow]["Raiting"] = raiting
            
            Students.indexPathRow = 0
        }
    }
}



