import SwiftUI
import CoreData

@objc(Users)
class Users: NSManagedObject {
    @NSManaged var email: String?
    @NSManaged var password: String?

}
class Persistence {
    static let shared = Persistence()
    
    var container : NSPersistentContainer?
    init() {
        
    }
    func addLoginDetails(email: String,password: String){
        let taskEntity = NSEntityDescription()
        taskEntity.name = "Users"
        taskEntity.managedObjectClassName = "Users"
        
        let emailAtribute = NSAttributeDescription()
        emailAtribute.name = "email"
        emailAtribute.type = .string
        taskEntity.properties.append(emailAtribute)
    }
}

