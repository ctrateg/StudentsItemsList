import Foundation

let informationAboutStudentKey = "informationAboutStudent"
var informationAboutStudent: [[String: String]] = []

//Load UserDefaults data
func loadData() {
    if let array = UserDefaults.standard.array(forKey: informationAboutStudentKey) as? [[String: String]] {
        informationAboutStudent = array
    } else {
        informationAboutStudent = []
    }
}
