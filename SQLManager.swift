import SwiftUI
import SQLite3


class SQLManager {
    static var shared = SQLManager()
    var db: SQLiteDatabase!
    init(){
        do {
            db = try SQLiteDatabase.open(path: part2DbPath!)
            print("Successfully opened connection to database.")
        } catch SQLiteError.OpenDatabase(_) {
            print("Unable to open database.")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createUser(table: SQLTable.Type){
        do {
            try db.createTable(table: table)
        } catch {
            print(db.errorMessage)
        }
    }
    
    func createStudentTable(table: SQLTable.Type){
        do{
            try db.createTable(table: Student.self)
        } catch{
            print(db.errorMessage)
        }
        
    }
    func createStudentCheckInTable(table: SQLTable.Type){
        do {
            try db.createTable(table: table)
        } catch {
            print(db.errorMessage)
        }
    }
    
        
        
        func insertData(user: User){
            do {
                try db.insertContact(user: user)
            } catch {
                print(db.errorMessage)
            }
        }
        func getUserData(email: String, completionHandler: @escaping (User?) -> Void){
            completionHandler(db.contact(email: email as NSString))
        }
        
        
        
        
    
}
