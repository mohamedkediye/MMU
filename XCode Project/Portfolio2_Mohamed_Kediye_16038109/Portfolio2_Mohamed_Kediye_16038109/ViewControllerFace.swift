//
//  ViewControllerFace.swift
//  Portfolio2_Mohamed_Kediye_16038109
//
//  Created by Mohamed kediye on 22/03/2019.
//  Copyright © 2019 Mohamed kediye. All rights reserved.
//

import UIKit //import uikit
import UIKit
import AVKit
import Vision
import CoreML //import core

class ViewControllerFace: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // this view will be called after the controller is loaded into memory.
        
        super.viewDidLoad()
        //this view will be Called after the controller is loaded into memory.
        
        let captureSession = AVCaptureSession()
        // this is the place an object that oversees capture action and coordinates the stream of information from the input devices to the capture outputs.
        
        captureSession.sessionPreset = .photo
        // this is the place a consistent value demonstrating the quality dimension or bitrate of the output given.
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        // this line is where the tool that gives out an input such as a video for the capture sessions and offers controls for capture highlights which are equipment fixed.
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice)
            // this is part is where a capture input that gives media from a capture device to a certain capture meeting
            else
        {
            return // returns the capture device
        }
        captureSession.addInput(input) // this will insert a given input to the capture session.
        
        captureSession.startRunning() // this tells the capture session to start running.
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //this show video as it is being caught in the captureSession.
        
        view.layer.addSublayer(previewLayer)
        
        previewLayer.frame = view.frame // this is where The frame rectangle, which describes the view’s location and size in its superview’s coordinate system.
        
        let dataOutput = AVCaptureVideoDataOutput() // this is where A capture output that records video and provides access to video frames for processing.
        
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoLineOutput")) // this sets the sample buffer delegate and the queue on which callbacks should be invoked.
        
        captureSession.addOutput(dataOutput)// this adds a given input to the session.
        
        setupIdentifierConfidenceLabel()// this sets up to the setupIdentifierConfidenceLabel
        
    }
    
    
    @IBAction func liveDetectionButton(_ sender: Any) { // this is the button for the liveDetectionButton fucntion
        
    }
    
    let identifierLabel: UILabel = {// this lets the display of one or more lines of read-only text, which is often used in combination with controls to portray their planned reason.
        
        let label = UILabel() // allows the label shown on the device
        
        label.backgroundColor = .white //  sets the background color.
        
        label.textAlignment = .center// aligninment of the text.
        
        label.translatesAutoresizingMaskIntoConstraints = false
        // decides if the view's autoresizing cover is converted into Auto Layout imperatives.
        
        return label
        //return
    }()
    
    
    fileprivate func setupIdentifierConfidenceLabel()
    { // private function for the setupIdentifierConfidenceLabel
        
        view.addSubview(identifierLabel) // this adds a view to the end of the receiver’s list of subviews.
        identifierLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        // this is the layout anchor which constitutes the bottom corner of the view frame.
        
        identifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
       // this is the layout anchor which constitutes the left anchor of the view frame.
        
        identifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        // this is the layout anchor which constitutes the right anchor of the view frame.
        
        identifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // this is the layout anchor which constitutes the height anchor of the view frame.
    }
    
    //output function
    func captureOutput
        (_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Notificstion that a new capture frame was written.
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        // tthis links to the Core Video pixel buffer object.
        
        
        guard let model = try? VNCoreMLModel(for: MobileNet().model) else { return }
        //  container for a Core ML model that is used with the Vision requests.
        
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            // image investigation request which uses a Core ML model in order to process images.
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            // The collection of VNObservation results generated by request processing.
            
            guard let firstObservation = results.first else { return }
            // this is the  first element of the collection.
            
            print(firstObservation.identifier, firstObservation.confidence)
            DispatchQueue.main.async {
                // this controls the implementation of the work objects. Each the items that are processed to a queue is sumitted on a number of threads that are managed by the system.
                
                self.identifierLabel.text = "\(firstObservation.identifier) \(firstObservation.confidence * 100)"
                //  label identification of the  type of inspection.
            }
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        // this is the place an item that forms at least one picture examination demands relating to a solitary picture.
    }
}
