//
//  ViewController.swift
//  img2Text
//
//  Created by Mobile Programming  on 07/07/23.
//

import UIKit
import Vision
class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let image = UIImage(named: "ap") else { return  }
        imgView.image = image
        detectText(image: imgView.image!)


    }
    
    @IBAction func btnAct(_ sender: Any) {
        let picker = UIImagePickerController()
           picker.allowsEditing = true
           picker.delegate = self
           present(picker, animated: true)
    }
    
    func detectText(image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            print("Failed to create CIImage from UIImage")
            return
        }
        
        let textRequest = VNRecognizeTextRequest(completionHandler: { (request, error) in
            if let error = error {
                print("Text detection error: \(error.localizedDescription)")
                return
            }
            
            guard let results = request.results, !results.isEmpty else {
                print("No text found")
                self.textLabel.text = "No text found"
                return
            }
            var detectedText = ""
            // Process the text detection results
            for result in results {
                if let textObservation = result as? VNRecognizedTextObservation {
                    var lineText = ""
                    for text in textObservation.topCandidates(1) {
                        lineText += text.string + " "
                    }
                    detectedText += lineText.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
                    self.textLabel.text = detectedText
                }

            }
        })
        
        textRequest.recognitionLevel = .accurate  // Change to .fast for faster but less accurate results
        
        // Create a request handler and perform the text detection
        let textHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try textHandler.perform([textRequest])
        } catch {
            print("Text detection request failed: \(error.localizedDescription)")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        dismiss(animated: true)
        imgView.image = image
        detectText(image: imgView.image!)

    }

}

