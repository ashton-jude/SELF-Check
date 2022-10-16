
import SwiftUI

struct CheckinView: View {
    @State var image: Image = Image("")
    @State var showCameraView: Bool = false
    @State var sleepScreen: Bool = false
    @State var takePhoto: Bool = false
    
    var body: some View {
        
            ZStack(alignment: .center) { 
                VStack{
                    Text("S.E.L.F Check In Screen")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    VStack(spacing: 8) {
                        VStack(alignment: .leading, spacing: 5) { 
                            
                        }
                        
                    }
                    .frame(width: 250)
                    Spacer()
                    self.image
                        .resizable()
                        .frame(width: 250,height: 250)
                        .cornerRadius(10)
                        .clipped()
                    Button { 
                        self.showCameraView.toggle()
                    } label: { 
                        Text("Take Photo")
                            .frame(width: 250, height: 40)
                            .background(Color.white)
                            .cornerRadius(8)
                            .foregroundColor(Color.black)
                    }
                    
                    NavigationLink(  destination: SleepView(userImage: self.image) , isActive: self.$sleepScreen) { 
                        Text("Submit Photo")
                            .frame(width: 250, height: 40)
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

