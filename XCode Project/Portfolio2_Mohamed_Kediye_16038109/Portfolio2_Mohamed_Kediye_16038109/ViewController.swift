//
//  ViewController.swift
//  Portfolio2_Mohamed_Kediye_16038109
//
//  Created by Mohamed kediye on 20/03/2019.
//  Copyright © 2019 Mohamed kediye. All rights reserved.
//
//imports
import UIKit //import UIKit
import CoreML //import coreML framework
import Vision //import vision
import AVKit //import AVKit
import MessageUI //import Message UI
import SafariServices //import safari Service

//view controllers
class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    MFMailComposeViewControllerDelegate,
    SFSafariViewControllerDelegate,
    AVCaptureVideoDataOutputSampleBufferDelegate
    
{
    
    
    //view image outlets
    @IBOutlet weak var viewImage: UIImageView!
    // image view
    @IBOutlet weak var descriptionLabel: UILabel!
    // label description for identifier
    @IBOutlet weak var faceDetectionLabel: UILabel! // face detection label. this checks for facial recognition
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let imagePath = Bundle.main.path (forResource: "Kediye" , ofType: "jpg") //this is the image name
        
        let imageURL = NSURL.fileURL(withPath: imagePath!)
        //this is the let function for imageURL with an image path
        
        let modelFile = MobileNet()
        
        let model =  try! VNCoreMLModel (for: modelFile.model)
        
        let handler = VNImageRequestHandler (url: imageURL)
        let request = VNCoreMLRequest(model: model, completionHandler: findResults)
        
        try! handler.perform([request])
    }


    // this is the photo library function
    @IBAction func photoLibrary(_ sender: UIBarButtonItem) { getPhoto()
    }
    
    //this function gets the photo from the photo library
    func getPhoto(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    // this is the function of picking an image that is within the cameraroll
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey : Any])
    {
        // URL information for the chosen image
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            guard let selectedImage =
                info[.originalImage] as? UIImage
                else { return }
            viewImage.image = selectedImage // select image from the camera roll
            identifyFacesWithLandmarks(image: selectedImage)
            
            dismiss(animated: true, completion: nil)
            
            let modelFile = MobileNet()
            let model =  try! VNCoreMLModel (for: modelFile.model)
            let handler = VNImageRequestHandler (url: imgUrl as URL)
            let request = VNCoreMLRequest(model: model, completionHandler: findResults)
            
            try! handler.perform([request])
        }
    }
    
    //results function
    func findResults(request: VNRequest, error: Error?)
    {
        guard let results = request.results as?
            [VNClassificationObservation] else{
                fatalError("Unable to get results") // if the recognition fails it will show this message
                
                
                // find method for handleFaceLandmarksRecognition
        }
        
        var bestGuess = ""
        var bestConfidence: VNConfidence = 100
        
        //Core ML applies a classification model to image. it also preprossess the images which makes the machine learning tasks more simple and more reliable.
        for classification in results {
            if (classification.confidence > bestConfidence) {
                bestConfidence = classification.confidence
                bestGuess = classification.identifier
            }
        }
        // the description label states what the image is.
        descriptionLabel.text = "the image is: \(bestGuess) with confidence \(bestConfidence) out of 1"
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    // identification function
    func identifyFacesWithLandmarks(image: UIImage) {
        
        let handler = VNImageRequestHandler(cgImage:
            image.cgImage!, options: [ : ])
        
        // the label for fave detection whilst it is analysing the photo
        faceDetectionLabel.text = "finding image..."
        
        let request =
            VNDetectFaceLandmarksRequest( completionHandler:
                handleFaceLandmarksRecognition)
        // request is performed
        try! handler.perform([request])
        
    }
    
    //function to find facial features
    func handleFaceLandmarksRecognition(request: VNRequest, error: Error?) {
        guard let foundFaces = request.results as? [VNFaceObservation] else {
            fatalError ("issue loading image to calculate the facial features ")
        }
        faceDetectionLabel.text = "Found \(foundFaces.count) faces in the picture"
        //anaysis face that is found within the rectangle
        for faceRectangle in foundFaces {
            
            guard let landmarks = faceRectangle.landmarks else {
                continue
            }
            
            var landmarkRegions: [VNFaceLandmarkRegion2D] = []
            
            if let faceContour = landmarks.faceContour {
                landmarkRegions.append(faceContour) //calculates the facial shades.
            }
            if let leftEye = landmarks.leftEye {
                landmarkRegions.append(leftEye)//calculates where the lefy eye is on the face for recognision.
            }
            if let rightEye = landmarks.rightEye {
                landmarkRegions.append(rightEye)//calculates where the right eye is on the face for recognision.
            }
            if let nose = landmarks.nose {
                landmarkRegions.append(nose)//calculates where the nose is on the face for recognision.
            }
            //image drawn.
            drawImage(source: viewImage.image!, boundary: faceRectangle.boundingBox, faceLandmarkRegions: landmarkRegions)
            
        }
        
    }
    
    // draw image function.
    func drawImage(source: UIImage, boundary: CGRect, faceLandmarkRegions: [VNFaceLandmarkRegion2D])  {
        
        
        UIGraphicsBeginImageContextWithOptions(source.size, false, 1)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: source.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setLineJoin(.round)
        context.setLineCap(.round)
        context.setShouldAntialias(true)
        context.setAllowsAntialiasing(true)
        
        // rectangle is created for facial recognision.
        let rect = CGRect(x: 0, y:0, width: source.size.width, height: source.size.height)
        context.draw(source.cgImage!, in: rect)
        
        //this will draw rectangles around faces that it detects facial features and it will draw a rectangle around the face.
        var fillColor = UIColor.green
        fillColor.setStroke()
        
        //the rectangle width will change in width within proportion with the face
        let rectangleWidth = source.size.width * boundary.size.width
        //the rectangle width will change in height within proportion with the face
        let rectangleHeight = source.size.height * boundary.size.height
        //add rectangle to adjusted with and height.
        context.addRect(CGRect(x: boundary.origin.x * source.size.width, y:boundary.origin.y * source.size.height, width: rectangleWidth, height: rectangleHeight))
        context.drawPath(using: CGPathDrawingMode.stroke)
        
        //this draws the facial features such as nose and eyes with a red colour
        fillColor = UIColor.red
        
        fillColor.setStroke()// this Sets the color of subsequent stroke operations to the color that the receiver represents.
        
        context.setLineWidth(2.0) //Sets the current line width to 2.0.
        
        for faceLandmarkRegion in faceLandmarkRegions {
            var points: [CGPoint] = []
            for i in 0..<faceLandmarkRegion.pointCount {
                let point = faceLandmarkRegion.normalizedPoints[i]
                let p = CGPoint(x: CGFloat(point.x), y: CGFloat(point.y))
                points.append(p)
            }
            
            let facialPoints = points.map { CGPoint(x: boundary.origin.x * source.size.width + $0.x * rectangleWidth, y: boundary.origin.y * source.size.height + $0.y * rectangleHeight) }
            context.addLines(between: facialPoints)
            context.drawPath(using: CGPathDrawingMode.stroke)
        }
        
        //image modification
        let modifiedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        viewImage.image = modifiedImage
    }
    
    //access to the camera
    @IBAction func photoCameraAccess(_ sender: UIBarButtonItem)
    {
        
        let imagePicker = UIImagePickerController()
        // lthis lets the camera to put an image to the library
        
    imagePicker.delegate = self
        // this is where the image picker is given an object.
        
    let alertController = UIAlertController(title:nil, message: nil, preferredStyle:.actionSheet)
        // this is where an object that displays an alert message to the user.
        
    let cancelAction = UIAlertAction(title: "stopping", style: .cancel, handler:nil) // this is if the button acvnels and doesnt do anything. which is essentailly an action that can be taken when the user taps a button in an alert.
        
    alertController.addAction(cancelAction) // this is where it attaches an action object to the alert or action sheet.
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
        // a certain view controller that deals with the framework interfaces of  pictures, recording, and chosing objects from the media library of the client.
    let cameraAction = UIAlertAction(title:"take image access from  the Camera", style:.default, handler:{(_) in imagePicker.sourceType = .camera //action for taking a picture from the camera
        
    self.present(imagePicker,animated: true,completion:nil)
    })
    
        
    alertController.addAction(cameraAction)
        // this is where it attaches an action object to the alert or action sheet.
}
        
    present(alertController, animated: true, completion:nil)
        // this is where the code presents a view controller modally.
    }
    

}
