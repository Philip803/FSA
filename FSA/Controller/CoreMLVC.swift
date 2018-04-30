//
//  CoreMLVC.swift
//  FSA
//
//  Created by Philip Leung on 4/29/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit
import AVFoundation
import CoreML
import Vision

class CoreMLVC: UIViewController {

    var captureSession: AVCaptureSession!
    var cameraOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var photoData: Data?
    
    var speechSynthesizer = AVSpeechSynthesizer()
    
    @IBOutlet weak var captureImageView: RoundedShadowImageView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var flashBtn: RoundedShowButton!
    @IBOutlet weak var identificationLbl: UILabel!
    @IBOutlet weak var confidenceLbl: UILabel!
    @IBOutlet weak var roundedLblView: RoundedShadowView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func goBackTapped(_ sender: Any) {
        captureSession.stopRunning()
        self.navigationController?.popViewController(animated: true)    //need nav
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer.frame = cameraView.bounds
        speechSynthesizer.delegate = self
        spinner.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCameraView))
        tap.numberOfTapsRequired = 1
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080  //quality of capture
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            //input
            let input = try AVCaptureDeviceInput(device: backCamera!)
            if captureSession.canAddInput(input) == true {
                captureSession.addInput(input)
            }
            
            //output
            cameraOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddOutput(cameraOutput) == true {
                captureSession.addOutput(cameraOutput!)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                
                cameraView.layer.addSublayer(previewLayer!)
                cameraView.addGestureRecognizer(tap)
                captureSession.startRunning()
            }
        } catch {
            debugPrint(error)
        }
    }
    
    @objc func didTapCameraView(){
        self.cameraView.isUserInteractionEnabled = false
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType, kCVPixelBufferWidthKey as String: 160, kCVPixelBufferHeightKey as String: 160]
        
        settings.previewPhotoFormat = previewFormat
        
        cameraOutput.capturePhoto(with: settings , delegate: self)
        
    }
    
    func resultsMethod(request: VNRequest, error: Error?) {
        //if no result then return to prevent vrash
        guard let results = request.results as? [VNClassificationObservation] else { return }
        
        for classification in results {
            if classification.confidence < 0.5 {
                let unknownObjectMessage = "I'm not sure what this is. Please try again."
                self.identificationLbl.text = unknownObjectMessage
                synthesizeSpeech(fromString: unknownObjectMessage)
                self.confidenceLbl.text = ""
                break   //need break otherwise infinite loop until hit not sure
            } else {
                let identification = classification.identifier
                let confidence = Int(classification.confidence * 100)
                
                //change the text here
                
                let translator = ROGoogleTranslate()
                translator.apiKey = "YOUR GOOGLE API KEY" // Add your API Key here
                
                var params = ROGoogleTranslateParams(source: "en",
                                                     target: "es",
                                                     text:   identification)
                
                translator.translate(params: params) { (result) in
                    DispatchQueue.main.async {
                        print(result)
                        self.identificationLbl.text = "English: \(identification) | Spanish: \(result)"
                    }
                }
                
                self.confidenceLbl.text = "CONFIDENCE: \(confidence)%"
                
                //call api to transaction here
                // "identification"
                
                let completeSentence = "This looks like a \(identification) and I'm \(confidence) percent sure."
                synthesizeSpeech(fromString: completeSentence)
                break
            }
        }
    }
    
    //any sting pass it will speak it for us
    func synthesizeSpeech(fromString string: String) {
        //pass in the string
        let speechUtterance = AVSpeechUtterance(string: string)
        
        //change the voice of the language
        //https://stackoverflow.com/questions/23827145/how-to-get-difference-language-code-for-ios-7-avspeechutterance-text-to-speech
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(speechUtterance)
    }
    
    
}

extension CoreMLVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            debugPrint(error)
        } else {
            photoData = photo.fileDataRepresentation()
            
            do {
                let model = try VNCoreMLModel(for: SqueezeNet().model)  //model from apple website
                let request = VNCoreMLRequest(model: model, completionHandler: resultsMethod)   //setup a human brain for iphone ;)
                let handler = VNImageRequestHandler(data: photoData!)   //compare
                try handler.perform([request])  //perform
            } catch {
                // handle erroes
                debugPrint(error)
            }
            
            let image = UIImage(data: photoData!)
            self.captureImageView.image = image
        }
    }
}


extension CoreMLVC: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        //once done speaking restart anim
        self.cameraView.isUserInteractionEnabled = true
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
    }
}
