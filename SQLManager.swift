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
    
    
    func insertData(user: User){
        do {
            try db.insertContact(user: user)
        } catch {
            print(db.errorMessage)
        }
    }
    
    func getUserData(id: Int32){
        let user = db.contact(id: id)
        print("\(user?.id ?? 0) \(user?.email ?? "") \(user?.password ?? "")")
    }
    
}
