import SwiftUI

struct SleepView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "arrowshape.turn.up.backward")
                    .imageScale(.large)
                    .foregroundColor(.white)
                Text("School Logo")
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    
                    
                NavigationLink(destination: SleepView(),label: {
                    Text("Back?")
                        .bold()
                        .frame(width: 120,height: 25)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    
                })
                Form {
                    
                    Text("Sleep Mode")
                }
            }
            Button(action: 
                    {print("Button action")
            }) {
                HStack {
                    Image(systemName: "moon.fill")
                    Text("Sleep Mode")
                }
            }
        }
    }
}

struct SleepView_Preview: PreviewProvider {
    static var previews: some View {
        SleepView()
    }
}
