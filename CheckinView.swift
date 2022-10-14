
import SwiftUI

struct CheckinView: View {
    
    @State var active: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .center) { 
                VStack{
                    Text("S.E.L.F Check In Screen")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    VStack(spacing: 8) {
                        VStack(alignment: .leading, spacing: 5 ){ 
                            Text("need code to take picture..")
                                .font(.callout).bold()
                            
                        }
                        VStack(alignment: .leading, spacing: 5) { 
                            Image("EgPhoto")
                                .resizable()
                                .frame(width: 300, height: 300)
                            
                                
                        }
                        
                        
                    }
                    .frame(width: 250)
                    Spacer()
                    NavigationLink(  destination: CheckinView() , isActive: self.$active) { 
                        Text("Take Photo")
                            .frame(width: 250, height: 40)
                            .background(Color.white)
                            .cornerRadius(8)
                            .foregroundColor(Color.black)
                    }
                    NavigationLink(  destination: LoginView() , isActive: self.$active) { 
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
        }
        .navigationViewStyle(.stack)
    }
}

struct CheckinView_Preview: PreviewProvider {
    static var previews: some View {
        CheckinView()
    }
}

