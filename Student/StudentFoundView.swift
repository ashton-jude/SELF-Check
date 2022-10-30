import SwiftUI

struct StudentFoundView: View {
    @State var emotionList = ["Happy","Sad","Depressed"]
    @State var userImage: Data = Data(count: 0)
    @State var student = Student(id: 0, firstName: "", lastName: "", grade: "", photo: "", isRegister: "") 
    @State var firstName = ""
    @State var lastName = ""
    @State var grade = ""
    var body: some View {
        VStack {
            HStack (alignment: .center){
                Image(uiImage: UIImage(data: self.userImage) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .frame( maxHeight: .infinity)
                    .clipped()
                VStack (alignment: .leading, spacing: 20){
                    ZStack(alignment: .center) { 
                        TextField("First Name", text: $firstName)
                            .frame(width: 275,height: 40)
                            .padding(.leading, 10)
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    
                    ZStack(alignment: .center) { 
                        TextField("Last Name", text: $lastName)
                            .frame(width: 275,height: 40)
                            .padding(.leading, 10)
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    
                    ZStack(alignment: .center) { 
                        TextField("Grade", text: $grade)
                            .frame(width: 275,height: 40)
                            .padding(.leading, 10)
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    
                    
                    
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
                            .padding()
                            .frame(width: 275, height: 40)
                            .background(Color(red: 0, green: 0.21, blue: 0.38))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width / 2)
                .frame( maxHeight: .infinity)                
            }
        }.navigationTitle(Text("Check In").font(.title3).fontWeight(.bold))
            .navigationBarTitleDisplayMode(.inline)
    }
    
    
        
}

struct StudentFoundView_Preview: PreviewProvider {
    static var previews: some View {
        StudentFoundView()
    }
}
