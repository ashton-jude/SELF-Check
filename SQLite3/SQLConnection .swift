import SwiftUI
import Foundation
import SQLite3


let tutorialDirectoryUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

private enum Database: String {
    case Part1
    case Part2
    
    var path: String? {
        return tutorialDirectoryUrl?.appendingPathComponent("\(self.rawValue).sqlite").relativePath
    }
}

public let part1DbPath = Database.Part1.path
public let part2DbPath = Database.Part2.path



//Making it Swift
enum SQLiteError: Error {
    case OpenDatabase(message: String)
    case Prepare(message: String)
    case Step(message: String)
    case Bind(message: String)
}


//The Database Connection
class SQLiteDatabase {
    private let dbPointer: OpaquePointer?
    private init(dbPointer: OpaquePointer?) {
        self.dbPointer = dbPointer
    }
    
    var errorMessage: String {
        if let errorPointer = sqlite3_errmsg(dbPointer) {
            let errorMessage = String(cString: errorPointer)
            return errorMessage
        } else {
            return "No error message provided from sqlite."
        }
    }
    
    deinit {
        sqlite3_close(dbPointer)
    }
    
    static func open(path: String) throws -> SQLiteDatabase {
        var db: OpaquePointer?
        // 1
        if sqlite3_open(path, &db) == SQLITE_OK {
            // 2
            return SQLiteDatabase(dbPointer: db)
        } else {
            // 3
            defer {
                if db != nil {
                    sqlite3_close(db)
                }
            }
            if let errorPointer = sqlite3_errmsg(db) {
                let message = String(cString: errorPointer)
                throw SQLiteError.OpenDatabase(message: message)
            } else {
                throw SQLiteError.OpenDatabase(message: "No error message provided from sqlite.")
            }
        }
    }
}

//Preparing Statements
extension SQLiteDatabase {
    func prepareStatement(sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.Prepare(message: errorMessage)
        }
        return statement
    }
}

//Create Table
struct User {
    let id: Int32
    let email: NSString
    let password: NSString
}

protocol SQLTable {
    static var createStatement: String { get }
}

extension User: SQLTable {
    static var createStatement: String {
        return """
    CREATE TABLE User(
      Id INT PRIMARY KEY NOT NULL,
      Email CHAR(255),
      Password CHAR(255)
    );
    """
    }
}

extension SQLiteDatabase {
    func createTable(table: SQLTable.Type) throws {
        // 1
        let createTableStatement = try prepareStatement(sql: table.createStatement)
        // 2
        defer {
            sqlite3_finalize(createTableStatement)
        }
        // 3
        guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
        print("\(table) table created.")
    }
}

//Insert
extension SQLiteDatabase {
    func insertContact(user: User) throws {
        let insertSql = "INSERT INTO User (Id, Email, Password) VALUES (?, ?, ?);"
        let insertStatement = try prepareStatement(sql: insertSql)
        defer {
            sqlite3_finalize(insertStatement)
        }
        let name: NSString = user.email
        let password: NSString = user.password
        guard
            sqlite3_bind_int(insertStatement, 1, user.id) == SQLITE_OK  &&
                sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil) == SQLITE_OK &&
                sqlite3_bind_text(insertStatement, 3, password.utf8String, -1, nil) == SQLITE_OK else {
            throw SQLiteError.Bind(message: errorMessage)
        }
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
        print("Successfully inserted row.")
    }
    
    func insertStudent(student: Student) throws {
        let insertSql = "INSERT INTO Student (Id, FirstName, LastName, Grade, Photo, IsRegister) VALUES (?, ?, ?, ?, ?, ?);"
        let insertStatement = try prepareStatement(sql: insertSql)
        defer {
            sqlite3_finalize(insertStatement)
        }
        let firstName: NSString = student.firstName
        let lastName: NSString = student.lastName
        let grade: NSString = student.grade
        let photo: NSString = student.photo
        let isRegister: NSString = student.isRegister
        guard
            sqlite3_bind_int(insertStatement, 1, student.id) == SQLITE_OK  &&
                sqlite3_bind_text(insertStatement, 2, firstName.utf8String, -1, nil) == SQLITE_OK &&
                sqlite3_bind_text(insertStatement, 3, lastName.utf8String, -1, nil) == SQLITE_OK  &&
                sqlite3_bind_text(insertStatement, 4, grade.utf8String, -1, nil) == SQLITE_OK  &&
                sqlite3_bind_text(insertStatement, 5, photo.utf8String, -1, nil) == SQLITE_OK  && sqlite3_bind_text(insertStatement, 6, isRegister.utf8String, -1, nil) == SQLITE_OK else {
                    throw SQLiteError.Bind(message: errorMessage)
                }
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
        print("Successfully inserted row.")
    }
    func insertStudentDetail(student: StudentCheckIn) throws {
        let insertSql = "INSERT INTO StudentCheckIn (Id, StudentId, CheckInTime, Emotion) VALUES (?, ?, ?, ?);"
        let insertStatement = try prepareStatement(sql: insertSql)
        defer {
            sqlite3_finalize(insertStatement)
        }
        
        let checkInTime: NSString = student.checkInTime
        let emotion: NSString = student.emotion
        guard
            sqlite3_bind_int(insertStatement, 1, student.id) == SQLITE_OK  &&
                sqlite3_bind_int(insertStatement, 2, student.studentId) == SQLITE_OK  &&
                sqlite3_bind_text(insertStatement, 3, checkInTime.utf8String, -1, nil) == SQLITE_OK  &&
                sqlite3_bind_text(insertStatement, 4, emotion.utf8String, -1, nil) == SQLITE_OK  else {
            throw SQLiteError.Bind(message: errorMessage)
        }
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
        print("Successfully inserted row.")
    }
}

//Read
extension SQLiteDatabase {
    func contact(email: NSString) -> User? {
        let querySql = "SELECT * FROM User WHERE Email = ?;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            return nil
        }
        defer {
            sqlite3_finalize(queryStatement)
        }
        guard sqlite3_bind_text(queryStatement, 1, email.utf8String, -1, nil) == SQLITE_OK else {
         return nil
         }
        
        
        /*guard sqlite3_bind_int(queryStatement, 1, id) == SQLITE_OK else {
            return nil
        }*/
        
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            return nil
        }
        let id = sqlite3_column_int(queryStatement, 0)
        let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
        let name = String(cString: queryResultCol1!) as NSString
        let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
        let password = String(cString: queryResultCol2!) as NSString
        return User(id: id, email: name, password: password)
    }
    func getStudentData(firstName: NSString) -> Student? {
        let querySql = "SELECT * FROM Student WHERE FirstName = ?;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            return nil
        }
        defer {
            sqlite3_finalize(queryStatement)
        }
        guard sqlite3_bind_text(queryStatement, 1, firstName.utf8String, -1, nil) == SQLITE_OK else {
            return nil
        }
        
        
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            return nil
        }
        let id = sqlite3_column_int(queryStatement, 0)
        let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
        let firstName = String(cString: queryResultCol1!) as NSString
        let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
        let lastName = String(cString: queryResultCol2!) as NSString
        let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
        let grade = String(cString: queryResultCol3!) as NSString
        let queryResultCol4 = sqlite3_column_text(queryStatement, 4)
        let photo = String(cString: queryResultCol4!) as NSString
        let queryResultCol5 = sqlite3_column_text(queryStatement, 5)
        let isRegister = String(cString: queryResultCol5!) as NSString
        return Student(id: id, firstName: firstName, lastName: lastName, grade: grade, photo: photo, isRegister: isRegister)
    }
    func getStudentList() -> [Student]? {
        let querySql = "SELECT * FROM Student;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            return nil
        }
        defer {
            sqlite3_finalize(queryStatement)
        }
        var students = [Student]()
        while(sqlite3_step(queryStatement) == SQLITE_ROW){
            let id = sqlite3_column_int(queryStatement, 0)
            let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
            let firstName = String(cString: queryResultCol1!) as NSString
            let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
            let lastName = String(cString: queryResultCol2!) as NSString
            let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
            let grade = String(cString: queryResultCol3!) as NSString
            let queryResultCol4 = sqlite3_column_text(queryStatement, 4)
            let photo = String(cString: queryResultCol4!) as NSString
            let queryResultCol5 = sqlite3_column_text(queryStatement, 5)
            let isRegister = String(cString: queryResultCol5!) as NSString
            students.append(Student(id: id, firstName: firstName, lastName: lastName, grade: grade, photo: photo, isRegister: isRegister))
        }
        return students
    }
    func getStudentCheckInData(studentId: Int32) -> StudentCheckIn? {
        let querySql = "SELECT * FROM StudentCheckIn WHERE StudentId = ?;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            return nil
        }
        
        defer {
            sqlite3_finalize(queryStatement)
        }
        
        guard sqlite3_bind_int(queryStatement, 1, studentId) == SQLITE_OK else {
            return nil
        }
        
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            return nil
        }
        let id = sqlite3_column_int(queryStatement, 0)
        let studentId = sqlite3_column_int(queryStatement, 1)
        let queryResultCol1 = sqlite3_column_text(queryStatement, 2)
        let checkInTime = String(cString: queryResultCol1!) as NSString
        let queryResultCol2 = sqlite3_column_text(queryStatement, 3)
        let emotion = String(cString: queryResultCol2!) as NSString
        
        return StudentCheckIn(id: id, studentId: studentId, checkInTime: checkInTime, emotion: emotion)
    }
}
//Create User Table
struct StudentCheckIn {
    let id: Int32
    let studentId: Int32
    let checkInTime: NSString
    let emotion: NSString
}


extension StudentCheckIn: SQLTable {
    static var createStatement: String {
        return """
    CREATE TABLE StudentCheckIn(
      Id INT PRIMARY KEY NOT NULL,
      StudentId INT,
      CheckInTime TEXT,
      Emotion TEXT
    );
    """
    }
}
//Create Student Table
struct Student {
var id: Int32
var firstName: NSString
var lastName: NSString
var grade: NSString
var photo: NSString
var isRegister: NSString
}


extension Student: SQLTable {
    static var createStatement: String {
        return """
    CREATE TABLE Student(
      Id INT PRIMARY KEY NOT NULL,
      FirstName CHAR(255),
      LastName CHAR(255),
      Grade CHAR(255),
      Photo TEXT,
      IsRegister TEXT 
    );
    """
    }
}
