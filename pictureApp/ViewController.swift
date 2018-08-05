//
//  ViewController.swift
//  pictureApp
//
//  Created by 蒲生廣人 on 2018/03/25.
//  Copyright © 2018年 蒲生廣人. All rights reserved.
//

import UIKit
import CoreML
import Vision
import ImageIO

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var inputImage: CIImage!
    @IBOutlet weak var cameraView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func loadFromCamerarole(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
           // UIImagePickerControllerのインスタンスを生成
            let picker:UIImagePickerController = UIImagePickerController()
            //カメラロールから写真を読み込み
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.resultLabel.text = "Analyzing Image..."
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.cameraView.contentMode = .scaleAspectFit
            self.cameraView.image = pickedImage
        }
        
        imagePicker.dismiss(animated: true, completion: {
            guard let uiImage = info[UIImagePickerControllerOriginalImage] as? UIImage
                else { fatalError("no image from image picker") }
            guard let ciImage = CIImage(image: uiImage)
                else { fatalError("can't create CIImage from UIImage")}
            
            let orientation = CGImagePropertyOrientation(rawValue: UInt32(uiImage.imageOrientation.rawValue))
            self.inputImage = ciImage.oriented(forExifOrientation: Int32(orientation!.rawValue))
            
            let handler = VNImageRequestHandler(ciImage: self.inputImage)
            do {
                try handler.perform([self.classificationRequest_vgg])
            } catch {
                print(error)
            }
        })
    }
    
    lazy var classificationRequest_vgg: VNCoreMLRequest = {
        do {
            var model: VNCoreMLModel? = nil
            model = try! VNCoreMLModel(for:VGG16().model)
            return VNCoreMLRequest(model: model!, completionHandler: self.handleClassification)
        } catch {
            fatalError("can't load Vision ML model: \(error)")
        }
    }()
    
    func handleClassification(request: VNRequest, error: Error?){
        guard let observation = request.results as? [VNClassificationObservation] else {
            fatalError("unexpected result type from VNCoreMLRequest")
        }
        guard let best = observation.first else {
            fatalError("can't get best result")
        }
        
        DispatchQueue.main.async {
            var classification: String = (best.identifier);
            self.resultLabel.text = "Classification: \"\(classification)\" Confidence: \(best.confidence)"
        }
    }

    @IBAction func openCamera(_ sender: Any) {
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }else {
            print("ERROR")
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
}

