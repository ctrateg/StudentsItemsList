import Foundation

class Students {
    static var informationAboutStudent: [[String: String]] = []
    
    // links
    enum StudentsDataLink {
        static let informationAboutStudentKey = "informationAboutStudentKey"
        static let name = "Name"
        static let secondName = "SecondName"
        static let raiting = "Raiting"
    }
    //save function
    func saveData(name: String, secondName: String, raiting: String) {
            Students.informationAboutStudent.append([StudentsDataLink.name: name, StudentsDataLink.secondName: secondName, StudentsDataLink.raiting: raiting])
            
            UserDefaults.standard.set(Students.informationAboutStudent, forKey: StudentsDataLink.informationAboutStudentKey)
    }
    // edit funcion
    func editLoad(name: String, secondName: String, raiting: String, indexPathRow: Int){
        Students.informationAboutStudent[ViewController.indexPathRow ?? 0][StudentsDataLink.name] = name
        Students.informationAboutStudent[ViewController.indexPathRow ?? 0][StudentsDataLink.secondName] = secondName
        Students.informationAboutStudent[ViewController.indexPathRow ?? 0][StudentsDataLink.raiting] = raiting
    }
}



