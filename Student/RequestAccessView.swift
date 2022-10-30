import SwiftUI

struct RequestAccessView: View {
    @State var userImage: Data = Data(count: 0)
    @State var studentFirstName: String = ""
    @State var studentLastName: String = ""
    @State var studentGrade: String = ""
    
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
                        TextField("First Name", text: $studentFirstName)
                            .frame(width: 275,height: 40)
                            .padding(.leading, 10)
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    
                    ZStack(alignment: .center) { 
                        TextField("Last Name", text: $studentLastName)
                            .frame(width: 275,height: 40)
                            .padding(.leading, 10)
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    
                    ZStack(alignment: .center) { 
                        TextField("Grade", text: $studentGrade)
                            .frame(width: 275,height: 40)
                            .padding(.leading, 10)
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    
                    
                    
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
        }
        
    .navigationTitle(Text("Request Access").font(.title3).fontWeight(.bold))
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct RequestAccessView_Previews: PreviewProvider {
    static var previews: some View {
        RequestAccessView()
    }
}

