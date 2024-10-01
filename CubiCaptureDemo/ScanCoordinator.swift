//
//  ScanCoordinator.swift
//  CubiCaptureExample
//

import Foundation
import SwiftUI
import CubiCapture

enum CaptureError: Error {
    case userCancel
    case scanFailed(String)
}

extension CaptureError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userCancel:
            return "User cancelled"
        case .scanFailed(let string):
            return string
        }
    }
}

class ScanCoordinator: NSObject, CubiCaptureDelegate {
    var completion: ((Result<URL, CaptureError>) -> Void)?

    func didCompleteScan(location: URL) {
        print("Location received \(location)")
        Task {
            if let error = await ZipUtilities.validateZip(location) {
                print("Zip validation failed with error: \(error.localizedDescription)")
            } else {
                print("Zip validated, no errors")
            }

            completion?(.success(location))
        }
    }

    func didAbortScan(withEvent event: CubiCaptureEvent) {
        print("scan aborted with event \(event.type), message: \"\(event.message)\"")
        let captureError: CaptureError = {
            if case .userAborted = event.type {
                return .userCancel
            } else {
                return .scanFailed(event.message)
            }
        }()
        completion?(.failure(captureError))
    }

    func receiveEvent(_ event: CubiCaptureEvent) {
//        print("\(Date()) Received event \(event.type), message: \"\(event.message)\"")
    }
}
