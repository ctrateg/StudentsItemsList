import Foundation

let informationAboutStudentKey = "informationAboutStudent"
var informationAboutStudent: [[String: String]] = []

//загрузка данных
func loadData() {
    if let array = UserDefaults.standard.array(forKey: informationAboutStudentKey) as? [[String: String]] {
        informationAboutStudent = array
    } else {
        informationAboutStudent = []
    }
}
