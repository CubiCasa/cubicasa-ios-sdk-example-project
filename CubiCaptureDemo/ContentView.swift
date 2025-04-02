//
//  ContentView.swift
//  CubiCaptureDemo
//

import SwiftUI
import CubiCapture

// Use a custom ColorSet to customize the UI colors
let warningBorder: [Color] = [.orange, .yellow]
let infoBorder: [Color] = [.blue, .gray]
let customColorSet = ColorSet(accent: .white,
                              text: .white,
                              buttonText: .black,
                              background: .black,
                              guideBackground: .gray.opacity(0.88),
                              warning: .orange,
                              warningBorder: warningBorder,
                              info: .black,
                              infoBorder: infoBorder,
                              record: .red,
                              positive: .green)

struct ContentView: View {
    @State var selectedPropertyType: CubiCapturePropertyType = .other
    @State var fileName: String = "temp"
    @State var shouldScan: Bool = false
    @State var shouldContinueScan: Bool = false
    @State var shouldPlayback: Bool = false
    @State var url: URL? = nil

    @State private var isShowingAlert = false
    @State private var errorMessage: String = ""

    private let coordinator = ScanCoordinator()

    private let address: CubiCaptureAddress = CubiCaptureAddress(street: "Place", city: "Holder", country: "Land")

    var body: some View {
        VStack(spacing: 16.0) {

            VStack {
                Text("SDK version: \(CubiCaptureInfo.sdkVersion)")
                Text("SDK build: \(CubiCaptureInfo.sdkBuild)")
            }

            VStack {
                Text("Select a property type")
                Picker("", selection: $selectedPropertyType) {
                    ForEach(CubiCapturePropertyType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
            }
            .padding(.top, 64.0)

            Text("File name")
                .padding(.top, 32.0)
            TextField("", text: $fileName)
                .foregroundColor(.blue)
                .padding(.vertical, 8.0)
                .padding(.horizontal, 8.0)
                .border(.gray)
                .padding(.horizontal, 32.0)

                .padding(.horizontal, 32.0)
                .padding(.top, 16.0)

            HStack(spacing: 32.0) {
                Button("Scan") {
                    guard !fileName.isEmpty else {
                        return
                    }
                    startScan()
                }

                if let url = url {
                    if CubiCaptureInfo.canContinueScan(fileName: self.fileName) {
                        Button("Continue") {
                            startScan(continueExistingScan: true)
                        }
                    }

                    Button("Show") {
                        shouldPlayback = true
                    }

                    ShareLink(item: url) {
                        Text("Share")
                    }
                }

            }
            .padding(.top, 32.0)

            Spacer()
        }
        .alert(errorMessage, isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) {
            }
        }
        .fullScreenCover(isPresented: $shouldScan) {
            CubiCaptureView(
                delegate: coordinator,
                fileName: fileName,
                shouldContinueScan: shouldContinueScan,
                address: address,
                propertyType: selectedPropertyType,
                usesRawDepth: false,
                options: .defaultOptions,
                colorSet: customColorSet)
        }
        .fullScreenCover(isPresented: $shouldPlayback) {
            if let url = url {
                CubiPlaybackView(projectLocation: url, colorSet: customColorSet)
            }
        }
        .onChange(of: self.fileName) { _, value in
            self.url = getUrl()
        }
        .onAppear {
            self.url = getUrl()
        }
    }

    private func startScan(continueExistingScan: Bool = false) {
#if targetEnvironment(simulator)
        errorMessage = "Scanning not supported on simulator"
        isShowingAlert = true
#else
        coordinator.completion = handleResult(result:)
        shouldContinueScan = continueExistingScan
        shouldScan = true
#endif
    }

    private func handleResult(result: Result<URL, CaptureError>) {
        shouldScan = false
        switch result {
        case .success(let url):
            print("Scan success: \(url)")
            self.url = getUrl()
        case .failure(let error):
            // Don't show an error alert in case of user cancel
            if case .userCancel = error {
                return
            }
            let message = "Scan failed: \(error.localizedDescription)"
            print(message)
            errorMessage = message
            isShowingAlert = true
        }
    }

    private func getUrl() -> URL? {
        let fm = FileManager.default
        guard !fileName.isEmpty,
              let documentDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }

        let projectLocation = documentDirectory.appendingPathComponent(fileName)
        guard let zipFile = try? fm.contentsOfDirectory(at: projectLocation, includingPropertiesForKeys: nil)
            .filter({ $0.absoluteString.contains(".zip")}).first
        else {
            return nil
        }

        return zipFile
    }
}

#Preview {
    ContentView()
}
