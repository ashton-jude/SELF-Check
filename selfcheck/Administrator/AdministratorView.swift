import SwiftUI

struct AdiministratorView: View {
    
    @State var gradeText = ""
    @State var studentList = [Student]()
    @State var widthSize: CGFloat = 0
    @State var showStudentDetailView = false
    @State var forRegister = false
    @State var showRegisterStudent = false
    @State var correctionList = [true,false]
    @State var student = Student(id: 0, firstName: "", lastName: "", grade: "", photo: "", isRegister: "")
    var body: some View {
        ZStack { 
            NavigationLink(destination: RegisterStudent(student: $student, forRegister: $forRegister), isActive: self.$showRegisterStudent) {
                EmptyView()
            }
            
            VStack(alignment: .leading, spacing: 20) { 
                HStack(alignment: .center, spacing: 15) { 
                    Text("Grade")
                        .font(.title3)
                        .fontWeight(.bold)
                    HStack(alignment: .center, spacing: 10) { 
                        ZStack(alignment: .center) { 
                            TextField("Search Grade", text: $gradeText)
                                .frame(width: 250,height: 40)
                                .padding(.leading, 10)
                        }
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                        Button { 
                            //
                        } label: { 
                            ZStack(alignment: .center) { 
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            .frame(width: 40, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.blue)
                                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 1, y: 1)
                            )
                        }
                        
                    }
                    .frame(height: 30)
                }
                .padding(.horizontal, 30)
                ZStack (alignment: .center){
                    
                    HStack (alignment: .center, spacing: 10) { 
                        Text("First Name ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.leading)
                            .frame(width: self.widthSize)
                        Text("Last Name ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(width: self.widthSize)
                        Text("Grade")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(width: self.widthSize)
                        Text("Is Student Registered")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(width: self.widthSize)
                        
                    }
                    .padding(.vertical,8)
                }    
                
                .frame(height: 45)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .shadow(color: Color.black.opacity(0.25), radius: 14, x: 0, y: 8)
                )
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) { 
                    VStack(spacing: 15) { 
                        ForEach(0..<self.studentList.count, id: \.self){ i in 
                            let student = studentList[i]
                            ZStack{
                                
                                HStack (alignment: .center, spacing: 10) { 
                                    Text("\(student.firstName)")
                                        .font(.headline)
                                        .padding(.leading)
                                        .frame(width: self.widthSize)
                                    Text("\(student.lastName)")
                                        .font(.headline)
                                        .frame(width: self.widthSize)
                                    Text("\(student.grade)")
                                        .font(.headline)
                                        .frame(width: self.widthSize)
                                    Text("\(student.isRegister)")
                                        .font(.headline)
                                        .frame(width: self.widthSize)
                                    
                                }
                                .padding(.vertical,8)
                            }
                            .onTapGesture {
                                self.student = student
                                if self.correctionList.randomElement() ?? false{
                                    self.forRegister = false
                                } else {
                                    self.forRegister = true
                                }
                                self.showRegisterStudent = true
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.2))
                                    .shadow(color: Color.black.opacity(0.25), radius: 14, x: 0, y: 8)
                            )
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .onAppear(){
            self.widthSize = (UIScreen.main.bounds.width - 70) / 4
            SQLManager.shared.getStudentList { students in
                if let students = students{
                    self.studentList = students
                }
            }
        }
    }
}

struct AdministratorView_Preview: PreviewProvider {
    static var previews: some View {
        AdiministratorView()
    }
}
