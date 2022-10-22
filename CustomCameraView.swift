import SwiftUI
import UIKit


struct CustomCameraView: UIViewControllerRepresentable {
    @Binding var image: Data
    @Binding var showCameraView: Bool
    func makeCoordinator() -> CustomCameraView.Coordinator {
        Coordinator(cameraView: self)
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<CustomCameraView>) -> some UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        controller.sourceType = .camera
        return controller
        
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<CustomCameraView>) {
        
    }
    
    class Coordinator: 
        NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        var parent: CustomCameraView
        init(cameraView: CustomCameraView) {
            self.parent = cameraView
            
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.parent.image = image.pngData() ?? Data(count: 0)
            self.parent.showCameraView = false
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.showCameraView = false
        }
    }
}


