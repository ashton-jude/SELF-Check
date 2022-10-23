import SwiftUI

struct StudentFoundView: View {
    @State var emotionList = ["Happy","Sad","Depressed"]
    @State var userImage: Data = Data(count: 0)
    @State var student = Student(id: 0, firstName: "", lastName: "", grade: "", photo: "", isRegister: "") 
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 250) { 
                Text("Check In")
                    .fontWeight(.bold)
                    .font(.system(size: 40))
            }
            
            
            HStack (alignment: .center, spacing: 100){
                Image(uiImage: UIImage(data: self.userImage) ?? UIImage())
                    .resizable()
                    .frame(width: 450, height: 400)
                VStack (alignment: .leading, spacing: 30){
                    
                    Text("First Name: \(self.student.firstName)")
                        .foregroundColor(.black)
                        .padding()
                    
                    Text("Last Name: \(self.student.lastName)")
                        .padding()
                    
                    Text("Grade: \(self.student.grade)") 
                        .padding()
                    
                    
                    Button { 
                        SQLManager.shared.createStudentCheckInTable(table: StudentCheckIn.self)
                        let id = Int.random(in: 10000...99999)
                        let student = StudentCheckIn(id: Int32(id), studentId: self.student.id, checkInTime: SQLManager.shared.getTime() as NSString, emotion: (self.emotionList.randomElement() ?? "") as NSString)
                        SQLManager.shared.insertStudentCheckInData(student: student)
                        SQLManager.shared.getStudentCheckInData(studentId: self.student.id) { student in
                            if let student = student{
                                print(student.checkInTime)
                                print(student.emotion)
                            }
                        }
                    } label: { 
                        Text("Check In")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                    }
                    
                    
                }
                
            }
        }
    }
    
    
        
}

struct StudentFoundView_Preview: PreviewProvider {
    static var previews: some View {
        StudentFoundView()
    }
}
