//
//  LogoDetectViewController.swift
//  img2Text
//
//  Created by Mobile Programming  on 10/07/23.
//

import UIKit
import Vision

class LogoDetectViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        



    }
    
    @IBAction func btnAct(_ sender: Any) {
        let picker = UIImagePickerController()
           picker.allowsEditing = true
           picker.delegate = self
           present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        dismiss(animated: true)
        imgView.image = image
//        detectLogo(image: image)

    }

//    func detectLogo(image: UIImage) {
//        guard let ciImage = CIImage(image: image) else {
//            print("Failed to create CIImage from UIImage")
//            return
//        }
//
//        guard let logoModel = try? YourLogoModel(configuration: MLModelConfiguration()) else {
//            print("Failed to load the Core ML model")
//            return
//        }
//
//        let logoDetectionRequest = VNCoreMLRequest(model: logoModel) { (request, error) in
//            if let error = error {
//                print("Logo detection error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let results = request.results as? [VNClassificationObservation], !results.isEmpty else {
//                print("No logo found")
//                return
//            }
//
//            // Process the logo detection results
//            for result in results {
//                let detectedLogo = result.identifier
//                let confidence = result.confidence
//
//                // Perform any further processing or display the results as needed
//                print("Detected logo: \(detectedLogo), Confidence: \(confidence)")
//            }
//        }
//
//        // Create a request handler and perform the logo detection
//        let logoDetectionHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
//        do {
//            try logoDetectionHandler.perform([logoDetectionRequest])
//        } catch {
//            print("Logo detection request failed: \(error.localizedDescription)")
//        }
//    }


}
