//
//  CameraViewController.swift
//  EmojiHunter
//
//  Created by Lujain Almulaifi on 04/11/2026.
//

import UIKit
import AVFoundation
import Vision
import CoreML

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    // MARK: - Setup VC and video settings
    weak var delegate: EmojiFoundDelegate?
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    private let videoDataOutput = AVCaptureVideoDataOutput()
    var emojiString = ""

    // Saves the name of the object we are hunting for
    init(emoji: String) {
        self.emojiString = emoji
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Sets up the camera, the video output, and the preview layer
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            showCameraUnavailableMessage()
            return
        }

        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch { return }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        }

        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        self.captureSession.addOutput(self.videoDataOutput)

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = self.view.frame
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }

    // Shows a message instead of a black screen when there is no camera (simulator)
    private func showCameraUnavailableMessage() {
        let label = UILabel(frame: view.bounds)
        label.text = "📷 Camera not available\n(Run on a real device)"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        view.addSubview(label)
    }

    // Called for every camera frame; sends the frame to the classifier
    nonisolated func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection) {
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        Task { @MainActor in
            self.updateClassifications(in: frame)
        }
    }

    // Restarts the camera when the screen appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if captureSession?.isRunning == false {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        }
    }

    // Stops the camera when the screen goes away
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }

    // Hides the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // Keeps the camera screen in portrait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // MARK: - Setup ML Model
    // Loads MobileNetV2 and sets up the classification request
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: MobileNetV2().model)
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()

    // MARK: - Classification methods

    // Runs the ML model on one camera frame
    func updateClassifications(in image: CVPixelBuffer) {
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .right, options: [:])
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }

    // Checks the top result; if confident and it matches the target, tells the delegate
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results as? [VNClassificationObservation] else {
                return
            }
            guard let top = results.first, top.confidence > 0.5 else { return }
            print("Classification: Identifier \(top.identifier) ; Confidence \(top.confidence)")
            if top.identifier.contains(self.emojiString) {
                self.delegate?.emojiWasFound(result: true)
            }
        }
    }
}
