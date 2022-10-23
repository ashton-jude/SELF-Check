import SwiftUI

struct AdiministratorView: View {
    @State var gradeText = ""
    @State var studentList = [Student]()
    @State var widthSize: CGFloat = 0
    var body: some View {
        ZStack { 
            VStack(alignment: .leading, spacing: 20) { 
                HStack(alignment: .center, spacing: 15) { 
                    Text("Grade")
                    HStack(alignment: .center, spacing: 10) { 
                        TextField("Search Grade", text: $gradeText)
                            .frame(width: 250)
                        Button { 
                            //
                        } label: { 
                            ZStack(alignment: .center) { 
                                Color.blue
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            .frame(width: 30, height: 30)
                        }
                        
                    }
                    .frame(height: 30)
                }
                ZStack (alignment: .center){
                    Color.gray.opacity(0.2)
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
                .padding()
                .frame(height: 30)
                .cornerRadius(8)
                
                ScrollView(.vertical, showsIndicators: false) { 
                    VStack(spacing: 15) { 
                        ForEach(0..<self.studentList.count, id: \.self){ i in 
                            let student = studentList[i]
                            ZStack{
                                Color.gray.opacity(0.2)
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
                            .padding(.horizontal)
                            .cornerRadius(8)
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
