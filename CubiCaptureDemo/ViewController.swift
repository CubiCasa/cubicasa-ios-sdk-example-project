//
//  ViewController.swift
//  CubiCaptureDemo
//
//  Created by Rauli Puuperä on 8.12.2020.
//

import UIKit

// Import the SDK
import CubiCapture

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        // Initiate CCCapture
        let ccCapture = CCCapture()
        ccCapture.delegateCapture = self
        ccCapture.options = [.speechRecognition, .meshVisualisation, .backgroundResume, .azimuth]
        present(ccCapture, animated: true, completion: nil)
    }

    private func endScan(_ controller: CCCapture) {
        // End the session
        controller.endCaptureSession()

        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension ViewController: CCCaptureDelegate {
    func dataZippedDelegationFunc(_ controller: CCCapture) {
        // The capture was completed succesfully
        print("Data zipped message received")
    }
    
    func zippedDataLocation(_ controller: CCCapture, location: URL) {
        // You can now upload the file in location to your server and use our server-to-server API to process the capture
        print("Location received \(location)")
    }
    
    func messenger(_ controller: CCCapture, errorCode: Int, message: String) {
        // This method is called whenever there is a change in the capture process
        print("Error code and message received \(errorCode) and \(message)")
        switch errorCode {
        case 0:
            // Device turned to landscape orientation
            break
        case 1:
            // Started recording
            break
        case 2:
            // Finished recording
            break
        case 3:
            // Recording was successfull but too short
            break
        case 5:
            endScan(controller)
        case 7:
            // Zipping is done.
            break
        case 23:
            // Not scanning ceiling or floor anymore
            break
        case 8:
            // ARKit TrackingFailureReason: Insuffient light
            break
        case 9:
            break
        // ARKit TrackingFailureReason: excessive motion
        case 17:
            // Device is in reverse-landscape orientation
            break
        case 21:
            // Scanning floor
            break
        case 22:
            // Scanning ceiling
            break
        case 13:
            // Scan drifted! Position changed by over 10 meters during 2 second interval
            endScan(controller)
        case 40 :
            // Started listening for speech.
            break
        case 41:
            // Listening finished, displaying recognition results.
            break
        case 42:
            // Recognition result '' was chosen.
            break
        case 43:
            // Recognition results canceled.
            break
        case 44:
            // Speech recognition aborted.
            break
        case 45:
            // No speech recognition results.
            break
        case 46:
            // All recognition results over the max length of 40 characters.
            break
        case 47:
            // Requesting RECORD_AUDIO permission.
            break
        case 48:
            // User granted RECORD_AUDIO permission.
            break
        case 49:
            // User denied RECORD_AUDIO permission.
            break
        case 51:
            // Zipping the scan failed
            fallthrough
        case 54:
            // Failed to write arkitdata to file
            fallthrough
        case 56:
            // Failed to write config to file
            fallthrough
        case 58:
            // Could not find filepath
            fallthrough
        case 59:
            // Depth map or AVasset writer could not take frames in
            fallthrough
        case 15:
            // Error, removing scan
            endScan(controller)
        default:
            break
        }
    }
    
    func processReadyDelegationFunc(_ controller: CCCapture) {
        print("processReady")
    }

    func scanTrackingFailed(_ controller: CCCapture) {
        print("tracking failed")
        endScan(controller)
    }
}

