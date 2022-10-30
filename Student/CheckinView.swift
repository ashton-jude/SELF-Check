
import SwiftUI

struct CheckinView: View {
    @State var image = Data(count: 0)
    @State var showCameraView: Bool = false
    @State var sleepScreen: Bool = false
    @State var takePhoto: Bool = false
    @State var showRequestAccessView = false
    @State var showStudentFoundView = false
    @State var correctionList = [true,false]
    @State var student = Student(id: 0, firstName: "", lastName: "", grade: "", photo: "", isRegister: "") 
    @Environment(\.presentationMode) var presentation
    var body: some View {
        
            ZStack(alignment: .center) { 
                NavigationLink(destination: RequestAccessView(userImage: self.image), isActive: self.$showRequestAccessView) {
                    EmptyView()
                }
                NavigationLink(destination: StudentFoundView(userImage: self.image, student: self.student) , isActive: self.$showStudentFoundView) {
                    EmptyView()
                }
                VStack{
                    Text("Take your picture")
                        .font(.title)
                        .fontWeight(.bold)
                    ZStack{
                        
                    
                    if self.image.count > 0{
                        Image(uiImage: UIImage(data: self.image) ?? UIImage())
                            .resizable()
                            .frame(width: 300,height: 380)
                            .cornerRadius(10)
                            .clipped()
                    } else {
                        Image("Placeholder")
                            .resizable()
                            .frame(width: 300, height: 380)
                            .cornerRadius(10)
                            .clipped()
                    }
                    }
                    .padding(.bottom)
                    .onTapGesture {
                        self.showCameraView.toggle()
                    }
                    
                    Button { 
                        DispatchQueue.main.async {
                            if self.correctionList.randomElement() ?? false{
                                self.showStudentFoundView = true
                            } else {
                                SQLManager.shared.getStudentData(firstName: "Jude") { student in
                                    if let student = student{
                                        self.student = student
                                        self.showRequestAccessView = true
                                    }
                                }
                            }
                        }
                        
                    } label: { 
                        Text("Submit Photo")
                            .padding()
                            .frame(width: 300, height: 40)
                            .background(Color(red: 0, green: 0.21, blue: 0.38))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.vertical)
            }.opacity(0)
            .navigationBarHidden(true)
            .navigationBarTitle(Text(" "))
            .onAppear(){
                    showCameraView.toggle()
            }
            .fullScreenCover(isPresented: $showCameraView) {
                CustomCameraView(image: $image, showCameraView: $showCameraView) { 
                    self.presentation.wrappedValue.dismiss()
                } doneAction: { 
                    DispatchQueue.main.async {
                        if self.correctionList.randomElement() ?? false{
                            self.showStudentFoundView = true
                        } else {
                            SQLManager.shared.getStudentData(firstName: "Jude") { student in
                                if let student = student{
                                    self.student = student
                                    self.showRequestAccessView = true
                                }
                            }
                        }
                    }
                    
                }
            }
        /*.sheet(isPresented:$showCameraView, content: { 
                CustomCameraView(image: $image, showCameraView: $showCameraView) { 
                    self.presentation.wrappedValue.dismiss()
                } doneAction: { 
                    DispatchQueue.main.async {
                        if self.correctionList.randomElement() ?? false{
                            self.showStudentFoundView = true
                        } else {
                            SQLManager.shared.getStudentData(firstName: "Jude") { student in
                                if let student = student{
                                    self.student = student
                                    self.showRequestAccessView = true
                                }
                            }
                        }
                    }
                    
                }
         
            })*/
    }
}

struct CheckinView_Preview: PreviewProvider {
    static var previews: some View {
        CheckinView()
    }
}

