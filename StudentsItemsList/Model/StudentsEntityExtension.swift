import CoreData


extension StudentsEntity: Comparable {
    
    // 
    public static func < (lhs: StudentsEntity, rhs: StudentsEntity) -> Bool {
        if lhs.name != rhs.name {
            return (lhs.name ?? "") < (rhs.name ?? "")
        } else if lhs.secondName != rhs.secondName {
            return (lhs.secondName ?? "") < (rhs.secondName ?? "")
        } else {
            return (lhs.raiting ?? "") < (rhs.raiting ?? "")
        }
    }
    
    //
    public static func > (lhs: StudentsEntity, rhs: StudentsEntity) -> Bool {
            if lhs.name != rhs.name {
                return (lhs.name ?? "") > (rhs.name ?? "")
            } else if lhs.secondName != rhs.secondName {
                return (lhs.secondName ?? "") > (rhs.secondName ?? "")
            } else {
                return (lhs.raiting ?? "") > (rhs.raiting ?? "")
            }
    }
    
    
}
