import SwiftUI

struct RequestAccessView: View {
    @State var userImage: Data = Data(count: 0)
    @State var studentFirstName: String = ""
    @State var studentLastName: String = ""
    @State var studentGrade: String = ""
    
    var body: some View {
        VStack {
            
            Text("Request Access from Administrator")
                .fontWeight(.bold)
                .font(.system(size: 40))
            
            HStack (alignment: .center, spacing: 100){
                Image(uiImage: UIImage(data: self.userImage) ?? UIImage())
                    .resizable()
                    .frame(width: 450, height: 400)
                VStack (alignment: .trailing, spacing: 30){
                    
                    TextField("First Name", text: $studentFirstName)
                        .buttonStyle(.bordered)
                        .padding()
                    
                    
                    TextField("Last Name", text: $studentLastName)
                        .buttonStyle(.bordered)
                        .padding()
                    TextField("Grade", text: $studentGrade) 
                        .buttonStyle(.bordered)
                        .padding()
                    
                    Button { 
                        SQLManager.shared.createStudentTable(table: Student.self)
                        let id = Int.random(in: 10000...99999)
                        let image = self.userImage.base64EncodedString()
                        let student = Student(id: Int32(id), firstName: self.studentFirstName as NSString, lastName: self.studentLastName as NSString, grade: self.studentGrade as NSString, photo: image as NSString, isRegister: "false")
                        SQLManager.shared.insertStudentData(student: student)
                        SQLManager.shared.getStudentData(firstName: self.studentFirstName) { student in
                            if let student = student{
                                print(student.firstName)
                                print(student.lastName)
                            }
                        }
                    } label: { 
                        Text("Request Access")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                    }
                    
                    
                }
                
            }
        }
        .padding(40)
        
    }
}

struct RequestAccessView_Previews: PreviewProvider {
    static var previews: some View {
        RequestAccessView()
    }
}

