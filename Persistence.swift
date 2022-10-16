import SwiftUI
import CoreData

@objc(Users)
class Users: NSManagedObject {
    @NSManaged var email: String?
    @NSManaged var password: String?
    @NSManaged var id: String?
}
class Persistence {
    static let shared = Persistence()
    
    var container : NSPersistentContainer
        
    init(){
        let taskEntity = NSEntityDescription()
        taskEntity.name = "Users"
        taskEntity.managedObjectClassName = "Users"
        
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.type = .string
        taskEntity.properties.append(idAttribute)
        
        let emailAtribute = NSAttributeDescription()
        emailAtribute.name = "email"
        emailAtribute.type = .string
        taskEntity.properties.append(emailAtribute)
        
        let passwordAttribute = NSAttributeDescription()
        passwordAttribute.name = "password"
        passwordAttribute.type = .string
        taskEntity.properties.append(passwordAttribute)
        
        let model = NSManagedObjectModel()
        model.entities = [taskEntity]
        let container = NSPersistentContainer(name: "UsersModel", managedObjectModel: model)
        container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores { description, error in
            
            if let error = error{
                print("Failed with \(error.localizedDescription)")
            }
            
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        self.container = container
    }
    /*func getAllUsers() {
        var fetchRequest = NSFetchRequest(entityName: "Users")
        do{
            let result = try self.container.viewContext.execute(fetchRequest)
            let users = result as! [Users]
        } catch let error {
            print(error.localizedDescription)
        }
    }*/
}

