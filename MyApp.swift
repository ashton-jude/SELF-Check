
import SwiftUI

@main
struct MyApp: App {
    let persistence = Persistence()
    var body: some Scene {
        WindowGroup {
            
            LoginView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
            
            
        }
    }
}

