
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
    var body: some View {
        
            ZStack(alignment: .center) { 
                NavigationLink(destination: RequestAccessView(userImage: self.image), isActive: self.$showRequestAccessView) {
                    EmptyView()
                }
                NavigationLink(destination: StudentFoundView(userImage: self.image, student: self.student) , isActive: self.$showStudentFoundView) {
                    EmptyView()
                }
                VStack{
                    Image(uiImage: UIImage(data: self.image) ?? UIImage())
                        .resizable()
                        .frame(width: 450,height: 400)
                        .cornerRadius(10)
                        .clipped()
                    Button { 
                        self.showCameraView.toggle()
                    } label: { 
                        Text("Take Photo")
                            .frame(width: 450, height: 40)
                            .background(Color.white)
                            .cornerRadius(8)
                            .foregroundColor(Color.black)
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
                            .frame(width: 450, height: 40)
                            .background(Color.white)
                            .cornerRadius(8)
                            .foregroundColor(Color.black)
                    }
                    
                    
                        
                    
                }
                .padding(.vertical)
                
            }
            
            .background(Image("Orange").ignoresSafeArea())
            .sheet(isPresented:$showCameraView, content: { 
                CustomCameraView(image: $image, showCameraView: $showCameraView)
            })
            
    }
}

struct CheckinView_Preview: PreviewProvider {
    static var previews: some View {
        CheckinView()
    }
}

