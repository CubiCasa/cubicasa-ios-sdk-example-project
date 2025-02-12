# Table of Contents

   * [Table of Contents](#table-of-contents)
   * [CubiCaptureDemo](#cubicapturedemo)
      * [Description](#description)
   * [Cubicasa SDK](#cubicasa-sdk)
      * [Release Notes](#release-notes)
         * [3.0.5](#305)
         * [3.0.3](#303)
         * [2.13.4](#2134)
         * [2.10.1](#2101)
         * [2.10.0](#2100)
         * [2.9.7](#297)
         * [2.9.3](#293)
         * [2.8.1](#281)
         * [2.8.0](#280)
         * [2.7.0](#270)
         * [2.6.2](#262)
         * [2.5.2](#252)
         * [2.5.1](#251)
         * [2.5.0](#250)
         * [2.4.2](#242)
         * [2.4.1](#241)
         * [2.3.1](#231)
      * [Glossary](#glossary)
      * [Installation](#installation)
         * [Swift Package Manager](#swiftpackagemanager)
         * [Cocoapods](#cocoapods)
      * [Device Orientation](#device-orientation)
      * [CubiCapture Features](#cubicapture-features)
         * [Relocating After Loss of Tracking](#relocating-after-loss-of-tracking)
         * [Scan Playback](#scan-playback)
         * [Scene Reconstruction](#scene-reconstruction)
         * [Adaptive Lighting](#adaptive-lighting)
         * [Azimuth](#azimuth)
         * [Storage Warning](#storage-warning)
         * [Feedback Gathering](#feedback-gathering)
      * [Permissions](#permissions)
      * [Scan lifecycle](#scan-lifecycle)
         * [Setting up](#setting-up)
         * [Configuration](#configuration)
         * [Starting the Scan](#starting-the-scan)
         * [Adding the Address](#adding-the-address)
         * [During the Scan](#during-the-scan)
         * [Ending the Scan](#ending-the-scan)
         * [Events](#events)
         * [Errors](#errors)
         * [Scan Playback](#scan-playback)
      * [Customization and Localization](#customization-and-localization)
         * [Localization](#localization)
         * [Colors](#colors)
      * [Zip Archive Utilities](#zip-archive-utilities)
         * [Validating the zip](#zip-validation)
         * [Recreating the zip](#zip-recreation)

# CubiCaptureDemo

Is a simple project which demonstrates how to integrate the CubiCasa SDK.

## Description

The CubiCaptureDemo app has a single screen, where some scanning options are set (property type, file name). The Scan button starts the scanner, the Show button starts the scan playback (after a scan has been made) and the Share button shares the zip archive containing the scan data.

For your app the next step would be to upload the scan to your server and use [CubiCasa Conversion API](https://cubicasaconversionapi.docs.apiary.io/#).

# Cubicasa SDK

The Cubicasa SDK lets you add scanning to your app so you can start creating a floor plan with an iOS device. It saves the scan files into a zip file, which your app can upload to the CubiCasa back-end for processing.

## Release Notes

### 3.0.5
- Bug fixes and performance improvements

### 3.0.3
 - New UI written in SwiftUI
 - New delegate protocol with improved event messaging
 - Various fixed and improvements
 - Minimum supported iOS version is 17.0

### 2.13.4
- Added photo capturing option
- Added Swift Package Manager support
- Added vertical tilt warning
- Removed landscape scanning option (now only portrait is supported)
- Removed speech recognition option
- Improved battery warnings
- Proximity warning for non-LiDAR devices
- Several more optimizations and bug fixes
- Minimum supported iOS version is 16.0

### 2.10.1
- Rebuilt SDK with Xcode 15.2

### 2.10.0
- Minimum supported iOS version set to 15.0
- Setting property type required before scan
- Bug fixes

### 2.9.7
- Workaround for iOS 16 camera orientation problem after initial rotation of the view to landscape-right
- Bug fixes

### 2.9.3
- Added property type (string) to ARKitData.json, set as public var on CubiCapture view controller
- SDK version and build number in file, to prevent Apple from changing it during app submissions
- Ceiling warnings adjusted (off for LiDAR, more relaxed for non-LiDAR)
- Proximity warning overlay shown in scan playback
- Possible fix for disappearing buttons when using speech recognition
- Sideways walking reset bug fixed
- Updated to Swift 5
- bitcode symbol files now shipped in xcframework
- Updated 3rd party dependencies (Zip)
- Bug fixes

### 2.8.1
- Abort scan if ARKit camera transform freezes (rare ARKit bug, but it ruins the scan)
- Tracking flag in ARKitData.json only keeps track of SDK-initiated relocation (coming back from background, or drift detected), not ARKit-internal relocation
 
### 2.8.0
- New proximity warning visualisation
- Scanning features, data version and platform added to ARKitData.json
- Scan log and feedback items added to ARKitData.json
- Fixed depth confidence encoding in conversion to depth16
- UI fixes
- When speech recognition fails with an error, show message and stop recognizing
- SDK iOS minimum version requirement was raised to 12.0

### 2.7.0
- Performance optimisations: moved video frame scaling and depth data processing to the GPU
- New iOS device names added

### 2.6.2
- Zipping is done in the background, with a progress percentage on screen
- Proximity warnings for non-LiDAR devices
- Proper use of landscape mode for scanning (app needs to support landscape-right!)
- New detection for initial rotate to landscape at start of scanning
- New scan playback view controller available
- End of scan confirmation dialog
- English UI texts reviewed
- Show warning when thermal throttled, more sensitive to fast movement
- `CCCapture` function `endCaptureSession()` is deprecated, no longer necessary

### 2.5.2
- Bugfix: handling of CCCapture `fileName` when it contains a path instead of a single name.
 
### 2.5.1
- Deprecated `feedbackGathering` scanning option.
- Bugfix: video length mismatch was detected incorrectly.
- New status code 88, sent when proximity is back to normal.

### 2.5.0
- New Warning: Proximity Warning. A warning which will trigger if the user is scanning too close or too far from objects.
- New Warning: Fast Rotation Warning. A warning which will trigger if the user turns around too fast while scanning.
- New Warning: Display an warning if the device is running out of storage space
- Relocation will now trigger if the user mishandles the device.
- Fixed a retention cycle in the code which caused memory leak.
- SDK iOS minimum version requirement was lowered to 11.0. Please note that in order to scan you need to be have iOS version 13.0 or higher.
- Improved scan stability after relocation.
- New scanning options `storageWarnings` & `feedbackGathering`.
- New status codes: 78, 85, 86, 87
- New Image and text assests for new warnings and tracking lost condition.

### 2.4.2
- SDK keeps depth data collection enabled during relocating, to ensure continuous delivery of depth data

### 2.4.1
- SDK tries to relocate if tracking is lost during a scan, instead of terminating
- SDK tries to relocate and resume the scan when it is brought back to the foreground, instead of terminating
- New customizable colors, texts, and images for relocation
- New error codes for relocation (codes 80, 81, 82)
- Horizontal scanning messages fixed
- "Not walking sideways" bug fixed
- More informative error messages
- SDK can now be debugged in llvm (`couldn't IRGen expression` issue)
- SDK always calls delegate with first measured system monitor values
- SDK calls delegate when tracking is back to normal
- New status codes (code 31, 32), updated status code (80, 81)

### 2.3.1
- Recording true north/azimuth
- Zip file check (and re-zip)
- Localisation support (see [Localization](#localization))
- Thermal state and memory monitoring, auto safe-mode
- Scan UI improvements
- Scan log (extra information about the scanning session, included in the zip)
- Horizontal scanning warning
- New status codes (code 3, 5, 18, 27, 29, 30 and 40-49 and 57 to match Android SDK statuses)
- Updated dependencies
 - We start to utilize Bundle in all Customization. If you want to replace assets from the SDK
   you just define the value with the same key in your application and (main bundle) and Cubicasa SDK will automatically
   override the default values.
    - Removed all warning and guide images (e.g. `turn-screen.png`)
- We have replaced the old border images in CCCapture with an UIView. The reason is that with the new solution
    it is easier to match the curvature of the screen corner with newer iPhones.
 - Removed:
    - `status-ok.png` and `status-unsure.png`
    - Use `cc_scan_border_ok` and `cc_scan_border_warning` color definitions instead

## Glossary

Term | Description
-----|------------
Scan | The process of capturing the surroundings indoor space using the phone's camera
ARKit | Apple's Augmented Reality framework that is used in CubiCasa SDK for scanning
Tracking | The process of aligning the device to its surroundings properly. We use ARKit to track the device position and orientation in the scanned space.
Tracking lost | Sometimes ARKit's tracking can get confused and the tracking is lost, i.e., the device is confused about where it is. This can happen, for example, if a door is opened in front of the device while scanning.
Relocation | If the scan is interrupted or ARKit loses tracking, it attempts to realign the device's position and orientation by using previously scanned data.
Sideways walk | An error which occurs during a scan when the user walks sideways. Walking sideways makes it hard to track the position of the device and can affect the quality of the scan.
Scene Reconstruction | The process of building a 3D model (mesh) from a video stream (scan)
Mesh visualisation | Showing the reconstructed scene mesh on-screen, during scanning

## Installation

The CubiCapture SDK is distributed as an XCFramework. This framework can be copied directly into your Xcode project (remember to also include the 3rd party dependencies `Zip` and `ZIPFoundation`) but we recommend using the Swift Package Manager.

### Swift Package Manager
The recommended way to integrate the CubiCapture SDK is to use the Swift Package Manager (SPM). In Xcode, select your project and open the tab Project Dependencies. Hit the '+' button and paste the CubiCapture Github URL (`https://github.com/CubiCasa/ios-sdk-distribution/`) into the search box. 

Make sure the Xcode build target is set to 'Embed & Sign' the `CubiCaptureSDK` library (in 'General -> Frameworks, Libraries and Embedded Content'). In the target's Build Settings, your Runpath Search Paths setting needs to contain `@executable_path/Frameworks`.

### Cocoapods
Cocoapods support is available as well but will be phased out in the future. The folder `CubiCaptureDemo_CocoaPods` contains the Cocoapods version of the demo project.

## Device Orientation

Starting from version 2.13.4, the only supported scanning orientation is portrait. The option to scan in landscape has been removed completely and any attempts to scan in landscape will result in a warning shown on-screen and the scan being terminated after a short time.

## CubiCapture Features

### Relocating After Loss of Tracking
In cases where the scan is interrupted due to loss of tracking or the app going to the background, the SDK will attempt to relocate and continue the scan. This is achieved by prompting the user to return to a previously scanned area, so that the SDK can reestablish tracking. If the relocation is not successful in 60 seconds the scan is aborted.

### Scan Playback
After a successful scan, this scan can be reviewed using the `CubiPlaybackView`. It plays the recorded video and, if available, overlays the reconstructed scene mesh and the proximity warning pattern (only for scans made with LiDAR devices). It also shows any feedback warnings that were shown during scanning.

### Scene Reconstruction
On LiDAR-equiped devices, the reconstructed scene mesh is shown on-screen during the scan, to give the user an idea of which parts of the space have been scanned already. Scene reconstruction can be disabled by omitting it from the `.options` of `CCCapture`. Note that if the device thermal state reaches `critical` during scanning, scene reconstruction will be shut down automatically and the mesh will not be available. This does not affect the scan itself.

The reconstructed scene mesh can be viewed during playback using the `CubiPlaybackView`.

### Adaptive Lighting
CubiCapture SDK features the Adaptive Lighting technique. During the scan if the lighting is too dark, the SDK automatically lights up the torch/flashlight of the phone to illuminate the surroundings. The brightness level of the torch depends on the surrounding lightgning conditions. Less light, more torch and the other way around.

### Azimuth
CubiCapture SDK captures the heading relative to the "true north" and adds this information to the scan. This information can be used to add the information to your scanner's floor plan. In order for the azimuth data to be collected the user must have granted the app access to location services. No position data is gathered by the SDK.

### Storage Warning
Cubicapture SDK notifies the user if the device is running out of storage space. This feature is toggled with the `.storageWarnings` scanning option.

### Feedback Gathering
Cubicapture SDK keeps a separate log of warnings during the scan. This will be used in the future for improving the scanning technique. 

The warnings can be reviewed during playback using the `CubiPlaybackView`.

### Photo Capturing
The CubiCapture SDK has the option to enable users to take photos while scanning. These photos are included in the Zip archive of the scan. This option is disabled by default; to enable it you need to add the `.photoCapturing` option to the `CaptureOptions` (see "Configuration")

## Permissions
CubiCasa SDK uses the device camera to capture the surroundings so you need to add the "Privacy - Camera Usage Description" to your projects `Info.plist` if you already haven't done so. The camera permission is required for the CubiCasa SDK, it cannot function without it. 

The azimuth data gathering requires "Privacy - Location When In Use Usage Description" to be set.

## Scan lifecycle

### Setting up
You can specify where the scan will be placed in the app's documents directory with `CubiCaptureView`'s `fileName` field.

You can add the address of the property to be scanned by adding the address information to `CubiCaptureView` view. See "Adding the Address".

### Starting the Scan
The way to use `CubiCaptureView` is to show it as a full-screen cover on the view from where you want to start scanning:

```swift
import CubiCapture
...
YourStartView()
.fullScreenCover(isPresented: $shouldScan) {
            CubiCaptureView(
                delegate: coordinator,
                fileName: fileName,
                address: address,
                propertyType: selectedPropertyType,
                usesRawDepth: false,
                options: .defaultOptions,
                colorSet: customColorSet)
        }
```

When the user presses the record button the scan starts. The SDK will ask for the required permissions if your app hasn't already done so. We recommend doing it in your app before starting the scan, for a better user experience.

Remember to pass an object implementing `CubiCaptureDelegate` to `CubiCaptureView` to get messages about the scan progress.

See the example project's `CubiCaptureDemo` project for details.

### Configuration
CubiCasa capture session options can be configured by passing an option set to the `CubiCaptureView`:

```swift
let options: CaptureOptions = [
        .meshVisualisation,
        .azimuth,
        .storageWarnings,
        .photoCapturing
    ]
```

The following options can be set (or omitted):

Option name          | Description | Default
---------------------|-------------|--------
`.meshVisualisation` | Reconstruct the scene as a 3D mesh and visualise it (only on LiDAR-equiped devices) | enabled
`.azimuth` | The SDK will write the camera orientation (azimuth) in the captured data | enabled
`.storageWarnings` | The SDK will inform the app about remaining file system storage and warn the user when less than 10 minutes remain | enabled
`.photoCapturing` | Allows the user to take photos during scanning | disabled

If `CubiCapture.options` is not set, the default values will apply.

### Adding the Address
You can add addres information to your scan by passing a `CubiCaptureAddress` struct to `CubiCaptureView`. It has the following fields for the address:

* `number`
* `street`
* `postCode`
* `city`
* `state`
* `country`
* `suite`

All fields are of type `String`.

The property type enum `CubiCapturePropertyType` is passed separately to `CubiCaptureView`.

These fields will be added to your order configuration.

### During the Scan
A lot of things can happen during a scan and we use the `CubiCaptureDelegate` protocol to pass events and signal the completion or termination of the scan. See the list of event codes more details.

The user gets visual guides on-screen to ensure good scan quality. For example, warnings are shown if the user is turning too rapidly, or if the environment is too dark. 

Please read [our scanning tips](https://www.cubi.casa/support/scanning/best-scanning-technique/) on how the scan should be made.

### Ending the Scan
The scan is ended when the user presses the record button again. To prevent unintentionally ending the scan, a confirmation dialog is presented. After confirmation, the scan is completed and the `didCompleteScan(location: URL)` delegate function is called.

Please note that the scan may be aborted if the SDK encounters an unrecovable error. If that happens, the `didAbortScan(withEvent event: CubiCaptureEvent)` delegate function is called.

#### After the scan the data is stored to the passed filename
```
└── Documents
    ├── ExampleFileName
    │   ├── UID.zip
    │   ├── ARWorldMap.bin
    │   ├── ARWorldMap.jpg
    │   ├── UUID*.jpg <- 0 or more snapshot files
    │   ├── arkitData.json
    │   ├── config.json
    │   ├── video.mp4
    │   ├── scan.log
    │   ├── feedback.json
    │   ├── allDepthFrames.bin
    │   └── Mesh.scn
```
You can easily inspect the data but do not modify the zip file. Note that the `allDepthFrames.bin` and `Mesh.scn` will be present only for LiDAR devices.

### Capture Events
In the SDK the following events can be received by the `receiveEvent(_ event: CubiCaptureEvent)` delegate function (The event type is a Swift `enum`, numeric values are provided for backward compatibility with earlier versions of the CubiCapture SDK):


| Event type | Num |  Description |
|------------|-----|--------|
| `startedCapture`| `1` | Scanning has started |
| `finishedCapture`| `2` | Scanning completed |
| `notEnoughData`| `3` | The scanning duration is too short |
| `tooLongInWrongOrientation`| `4` | The device was held in landscape mode for too long |
| `zippingDone`| `7` | The zip file with the scan data was created successfully |
| `insufficientLight`| `8` | Tracking limited due to insufficient light |
| `excessiveMotion`| `9` | Tracking limited due to excessive device movement |
| `insufficientFeatures`| `10` | Tracking limited due to a lack of visual features |
| `invalidOrientation`| `17` | The device is being held in the wrong orientation |
| `tiltTooFarDown`| `21` | The device is tilted too far downward |
| `tiltTooFarUp`| `22` | The device is tilted too far upward |
| `tiltOptimal`| `23` | The devie tilt angle is within the acceptable range |
| `validOrientation`| `24` | The device is being held in the correct orientation |
| `notWalkingSideways`| `27` | The device is no longer moving sideways |
| `scanningStateNormal`| `28` | The scanning state is back to normal (after relocation) |
| `walkingSidewaysLeft`| `29` | The device is moving sideways to the left |
| `walkingSidewaysRight`| `30` | The device is moving sideways to the right|
| `failedToZip`| `51` | The zip archive could not be created |
| `invalidZipArchive`| `53` | The zip archive could not be read |
| `writeArkitDataFailed`| `54` | The position and orientation data file could not be written |
| `writeFeedbackFailed`| `55` | The feedback file could not be written |
| `writeConfigFailed`| `56` | The scan configuration file could not be written |
| `filePathNotFound`| `58` | The specified file path could not be opened |
| `notReceivingArFrames`| `62` | There are no frames arriving from ARKit |
| `tooManyFramesSkipped`| `63` | Too many frames were skipped because the device is overloaded |
| `fileSizeCheckFailed`| `84` | One or more files had an invalid file size |
| `thermalStateNominal`| `70` | The device temperature is normal |
| `thermalStateFair`| `71` | The device temperature is elevated but acceptable |
| `thermalStateSerious`| `72` | The device temperature is very high, scan quality will be compromised |
| `thermalStateCritical`| `73` | The device temperature is criticially high, the device may shut down |
| `activeProcessors`| `76` | The number of active processor cores available to the app |
| `lowMemory`| `77` | The app has received a low-memory warning |
| `storage`| `78` | There are X minutes of file system storage left |
| `battery`| `79` | There is X% of battery charge left |
| `relocationTimeout`| `80` | The relocation could not be completed in time |
| `noArSessionConfig`| `81` | There is no ARSession configuration (internal iOS error) |
| `noRelocationSnapshot`| `82` | There is no world map snapshot available for relocation |
| `tooClose`| `85` | The device is too close to the scene (walls, furniture) |
| `fastRotation`| `87` | The device is being turned too rapidly |
| `rangeNormal`| `88` | The device is not too close to the scene anymore |
| `scanLogWriteFailed`| `90` | The scan log file could not be written |
| `incompatibleDevice`| `106` | This device cannot be used for scanning |
| `deviceTooHot`| `107` | The device is too hot for scanning |
| `userAborted`| `110` | The user has aborted the scan |
| `photoCaptureFailed`| `112` | A photo could not be taken |
| `photoLogWriteFailed`| `113` | The photo log file could not be written |
| `sceneMeshWriteFailed`| `115` | The scene mesh file could not be written |
| `noCameraPermission`| `120` | The user has not given permission to use the camera |
| `cameraTranslationFrozen`| `126` | The device position is not being updated (internal iOS error) |
| `cameraOrientationFrozen`| `127` | The device orientation is not being updated (internal iOS error) |
| `cameraTranslationAndOrientationFrozen`| `128` | The device position and orientation are not being updated (internal iOS error) |
| `angularDriftDetected`| `129` | The device rotation is changing too fast, forcing a relocation |
| `positionDriftDetected`| `130` | The device position is changing too fast, forcing a relocation  |
| `startedForcedRelocation`| `131` | Starting a forced relocation from the previous worldmap snapshot |
| `startedAutomaticRelocation`| `132` | Starting an automatic relocation (triggered by iOS) |
| `relocationSuccessful`| `133` | Relocation was completed successfully |
| `arSessionInterrupted`| `134` | The session was interrupted (e.g., because the app was backgrounded) |
| `arSessionInterruptionEnded`| `135` | The session is resuming |
| `pauseFailedOnDrift`| `136` | The scan could not be paused when drift was detected |
| `pauseFailedOnBackground`| `137` | The scan could not be paused when the app was backgrounded |
| `pauseFailedOnRelocate`| `138` | The scan could not be paused when relocation started |
| `videoWriterSetupFailed`| `140` | The video file writing could not be started |
| `videoWriterPauseFailed`| `141` | The video file writing could not be paused |
| `videoWriterUnpauseFailed`| `142` | The video file writing could not be resumed |
| `videoWriterWriteFrameFailed`| `143` | The video frame could not be written |
| `videoWriterEndFailed`| `144` | The video file writing could not be completed |
| `depthWriterSetupFailed`| `150` | The depth data writing could not be started |
| `depthWriterWriteFrameFailed`| `151` | The depth data frame could not be written |
| `depthWriterEndFailed`| `152` | The depth data file writing could not be completed |
| `scanLogSetupFailed`| `155` | The scan log could not be started |
| `scanLogEndFailed`| `156` | The scan log could not be finished |
| `rezipFailed`| `160` | Repairing the zip file failed |
| `rezipValidationFailed`| `161` | The repaired zip was invalid |


### Errors
Events have a severity: `info`, `warning` or `error`. When an event of severity `error` happens, the scan is aborted and the SDK will remove all files it has created.

### Scan Playback
The CubiCasa SDK can play back previously made scans, allowing users to review their scans and feedback. On LiDAR devices, the reconstructed scene mesh is shown superimposed on the video (if the `.meshVisualisation` option was enabled for the scan and scene reconstruction was not shut down due to the thermal state reaching `critical`). Also on LiDAR devices only, the proximity warning pattern will be shown superimposed on the video.

Playback is done by instantiating a `CubiPlaybackView` as a full screen cover, as follows:

```swift
YourStartView()
.fullScreenCover(isPresented: $shouldPlayback) {
    CubiPlaybackView(projectLocation: url)
}
// See sample code for details
```

The scan playback view has five buttons controlling playback:

 - Jump to previous warning
 - Step back one frame
 - Play/pause
 - Step forward one frame
 - Jump to next warning

The timeline scrubber can also be used to seek through the scan.

## Customization and Localization

### Localization
The CubiCasa SDK is localizable to any language. At the moment we support only English translations but if your app has support for multiple languages you can easily also translate all texts in the SDK as well. If you want to use a different tone in the texts or something you can always define your own. See the `Localizable.strings` file in this project. By overriding the keys you can change the text as you please.

### ColorSet
In order to provide a consistent user experience, the CubiCasa SDK's colors can now be customized using a `ColorSet` object that is passed to `CubiCaptureView` (optional; if no colorSet is passed, the defaults are used). This is a set of colors that are used for the various UI elements. The available customization options are:

| Name | Type | Description |
|------|------|-------------|
|`accent`| `Color` | The foreground color on buttons and other small UI elements |
|`text`| `Color` | The text color on full-sceen warnings and the timer |
|`buttonText`| `Color` | The text color of buttons (e.g., on full-screen warnings) |
|`background`| `Color` | The background color of the main screen |
|`warning`| `Color` | The background color for warning messages |
|`warningBorder`| `[Color]` | The color gradient for the border of warning messages |
|`info`| `Color` | The background color for informational messages |
|`infoBorder`| `[Color]` | The color gradient for the border of informational messages |
|`record`| `Color` | The color of the record button and the background of the timer |

## Zip Archive Utilities
The CubiCasa SDK includes a public class utility that can be used to validate and recreate the zip archive containing the scan data. It can be useful to validate the zip archive before upload and recreating it if it is found to be damaged.

```
public class ZipUtilities {
    public static func validateZip(_ zipUrl: URL) async -> (any Error)?

    public static func reZip(_ zipUrl: URL, progressHandler: (@Sendable (Double) -> Void)?) async -> Result<URL, CubiCapture.ZippingError>
}

public enum ZippingError : Error {

    case archivingFailed(message: String)

    case invalidEOCDR

    case noFilesToZip

    case fileNotOnDisk(fileName: String)

    case sizeUnknown(fileName: String)

    case wrongSize(fileName: String)

    case numberOfFilesMismatched(inZip: Int, onDisk: Int)

    case unknown
}
```
### Validating the zip
To validate the zip archive on the file system, call `validateZip` passing it the file URL. Return value is `nil` if everything is ok and a `ZippingError` if it is not. Internally this function tries to open the zip archive, read its table of contents and match the uncompressed file size for each entry with the size of the corresponding original file on the file system. If there is a mismatch in the number of entries or their sizes, an error is returned.

### Recreating the zip
To recreate the zip archive, call `reZip` with the file URL of the original zip archive and an optional progress handling closure. It will return a result of `.success` with the file URL of the new zip (which may be a new file with the same name as the original) or a `.failure` with the `ZippingError`.
