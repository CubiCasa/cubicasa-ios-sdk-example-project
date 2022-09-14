# Table of Contents

   * [Table of Contents](#table-of-contents)
   * [CubiCaptureDemo](#cubicapturedemo)
      * [Description](#description)
   * [Cubicasa SDK](#cubicasa-sdk)
      * [Release Notes](#release-notes)
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
         * [Cocoapods](#cocoapods)
      * [Device Orientation](#device-orientation)
      * [CubiCapture Features](#cubicapture-features)
         * [Relocating After Loss of Tracking](#relocating-after-loss-of-tracking)
         * [Scan Playback](#scan-playback)
         * [Scene Reconstruction](#scene-reconstruction)
         * [Adaptive Lighting](#adaptive-lighting)
         * [Azimuth](#azimuth)
         * [Speech Recognition for Room Labels](#speech-recognition-for-room-labels)
         * [Storage Warning](#storage-warning)
         * [Feedback Gathering](#feedback-gathering)
      * [Permissions](#permissions)
      * [Scan lifecycle](#scan-lifecycle)
         * [Setting up](#setting-up)
         * [Starting the Scan](#starting-the-scan)
         * [Configuration](#configuration)
         * [Adding the Address](#adding-the-address)
         * [During the Scan](#during-the-scan)
         * [Ending the Scan](#ending-the-scan)
         * [Errors](#errors)
         * [The event codes](#the-event-codes)
         * [Scan Playback](#scan-playback)
      * [Customization and Localization](#customization-and-localization)
         * [Localization](#localization)
         * [Colors](#colors)
         * [Images](#images)
         * [UI Elements](#ui-elements)

# CubiCaptureDemo

Is a simple project which has the CubiCasa SDK integrated.

## Description

The app has only one view controller that has the greetings label and two buttons. If the user presses the first button, the CubiCapture view controller is presented and you can start scanning. After the scan is complete the capture view is dissmissed. The 'Play back scan' button will now be enabled, pressing it will show the `CCScanPlaybackViewController` which allows you to review the scan.

For your app the next step would be to upload the scan to your server and use [CubiCasa Conversion API](https://cubicasaconversionapi.docs.apiary.io/#).

# Cubicasa SDK

The Cubicasa SDK lets you add scanning to your app so you can start creating a floor plan with an iOS device. It saves the scan files into a zip file, which your app can upload to the CubiCasa back-end for processing.

## Release Notes

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
ARKit | Apple Augemented Reality library that is used in CubiCasa SDK for scanning
Tracking | The process of aligning the device to it's surroundings properly. We use ARKit to track the device location in the scanned space.
Tracking lost | Sometimes ARKit's tracking can get confused and the tracking is lost i.e. the device is confused about where it is. This can happen for example if a door is opened in front of the device while scanning.
Relocation | If the scan is interrupted we can try to relocate the devices position by using previously scanned data.
Sideways walk | An error which occurs during a scan when the user walks sideways. Walking sideways makes it hard to tract the position of the device and can affect the quality of the scan.
Scene Reconstruction | The process of building a 3D model (mesh) from a video stream (scan)
Mesh visualisation | Showing the reconstructed scene mesh on-screen, during scanning

## Installation

### Cocoapods
The preferred (and easiest) way to install the CubiCapture SDK is with cocoapods. Add the following to your `Podfile`:

```
source 'https://github.com/CubiCasa/podspecs.git'
target 'YourTarget' do
  use_frameworks!
  pod 'CubiCapture'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end
```
Replace `YourTarget` with the name of your build target. Run `pod install`.

## Device Orientation

Starting from version 2.6, the CubiCasa SDK uses the landscape-right orientation (instead of locking the orientation to portrait). This means that your app needs to support (at least) landscape-right orientation.

### Auto-rotation on iPad OS
From iPad OS 15.2, iPhone apps running on iPad devices are auto-rotated to landscape mode if the app requires it, without the iPad device being physically in landscape mode. This can lead to problems when starting/ending a scan using the CubiCasa SDK. Auto-rotation cannot not be disabled. The best way to deal with this, [as suggested by Apple](https://discussions.apple.com/thread/253164656), is to make your app support iPad (not just iPhone) because iPad OS 15.2 will respect the required orientation of iPad apps. See the example project's `CubiCaptureDemo` target for details.

### iOS 16 camera orientation workaround
In iOS 16, the camera orientation behaves unpredictably when rotating the device immediately after presenting the `CCCapture` view controller, resulting in the camera view being rotated 90º relative to the floor. As a workaround, a helper class called `ScanHostViewController` is now available in the CubiCasa SDK. It forces screen rotation first and then presents the proper `CCCapture` view controller. The sample code illustrates how to use this helper class. Note that code has been added to the `SceneDelegate` class to respond to the screen orientation change, you will need to add this to your own `SceneDelegate`.

## CubiCapture Features

### Relocating After Loss of Tracking
In cases where the scan is interrupted due to loss of tracking or the app going to the background, the SDK will now attempt to relocate and continue the scan. This is achieved by prompting the user to return to a previously scanned area, so that the SDK can reestablish tracking. If the relocation is not successful in 60 seconds the scan is aborted.

### Scan Playback
After a successful scan, this scan can be reviewed using a new component: `CCScanPlaybackViewController`. It plays the recorded video and, if available, overlays the reconstructed scene mesh and the proximity warning pattern (only for scans made with LiDAR devices). It also shows any feedback warnings that were shown during scanning, as well as any room labels that were added.

### Scene Reconstruction
On LiDAR-equiped devices, the reconstructed scene mesh is shown on-screen during the scan, to give the user an idea of which parts of the space have been scanned already. Scene reconstruction can be disabled by omitting it from the `.options` of `CCCapture`. Note that if the device thermal state reaches `critical` during scanning, scene reconstruction will be shut down automatically and the mesh will not be available.

The color of the mesh is configurable you can define `cc_mesh` in your application bundle to overwrite the default value. 

The reconstructed scene mesh can be viewed during playback using the `CCScanPlaybackViewController`.

### Adaptive Lighting
CubiCapture SDK features the Adaptive Lighting technique. During the scan if the lighting is too dark `CCCapture` automatically lights up the torch/flashlight of the phone to illuminate the surroundings. The brightness level of the torch depends on the surrounding lightgning conditions. Less light, more torch and the other way around.

### Azimuth
CubiCapture SDK captures the heading relative to the "true north" and adds this information to the scan. This information can be used to add the information to your scanners floor plan. In order to the azimuth data to be collected the the user must have agreed to use the location data. No position data is gathered by the SDK.

### Speech Recognition for Room Labels
CubiCapture SDK utilizes speech recognition. During a scan your users can use the speech recognition to add room labels. If you don't want to use speech recognition you can omit `.speech_recognition` from the scanning options. 

The room labels can be reviewed during playback using the `CCScanPlaybackViewController`.

### Storage Warning
Cubicapture SDK notifies the user if the device is running out of storage space. This feature is toggled with the `.storageWarnings` scanning option.

### Feedback Gathering
Cubicapture SDK keeps a separate log of warnings during the scan. This will be used in the future for improving the scanning technique. 

The warnings can be reviewed during playback using the `CCScanPlaybackViewController`.

## Permissions
CubiCasa SDK uses the device camera to capture the surroundings so you need to add the "Privacy - Camera Usage Description" to your projects `Info.plist` if you already haven't done so. The camera permission is required for the CubiCasa SDK, it cannot function without it. 

If you want to use speech recognition (optional) add "Privacy - Microphone Usage Description" and the "Privacy - Speech Recognition Usage Description". 

The azimuth data gathering requires "Privacy - Location When In Use Usage Description" to be set.

## Scan lifecycle

### Setting up
You can specify where the scan will be placed in the app document directory with CCCapture `fileName` field.

### Starting the Scan
The way to use `CCCapture` is to present it as a `UIViewController`:

```swift
import CubiCapture
...
let cubiCapture = CCCapture()
cubiCapture.delegateCapture = self
present(cubiCapture, animated: true, completion: nil)
```

Note: the old method (using `cubiCapture(sceneToController: self)`) is no longer supported as of release 2.6.0.

You can add the address of the place to be scanned by adding the address information to `CCCapture` view. See "Adding the Address".

When the user has oriented the device to landscape and presses the record button the scan starts.

Remember to add CCCaptures delegate to controlling viewcontrollor to get messages about the scan progress. 

### Configuration
CubiCasa capture session features can be configured by assigning an option set:

```swift
ccCapture.options = [.speechRecognition, .meshVisualisation, .backgroundResume,
                     .azimuth, .storageWarnings]
present(cubiCapture, animated: true, completion: nil)
```

The following options can be set (or omitted):

Option name          | Description | Default
---------------------|-------------|--------
`.speechRecognition` | Use speech recognition for making room labels | enabled
`.meshVisualisation` | Reconstruct the scene as a 3D mesh and visualise it (only on LiDAR-equiped devices) | enabled
`.backgroundResume`	| The SDK will attempt to resume scanning if the app was backgrounded | enabled
`.azimuth` | The SDK will write the camera orientation (azimuth) in the captured data | enabled
`.storageWarnings` | The SDK will inform the app about remaining file system storage and warn the user when less than 10 minutes remain | enabled

If `CubiCapture.options` is not set, the default values will apply.

### Adding the Address
You can add addres information to your scan. `CCCapture` has the following fields for address:

* `number`
* `postCode`
* `city`
* `state`
* `country`
* `suite`
* `propertyType`

All fields are `String`s.

These will be added to your order configuration.

### During the Scan
A lot of things can happen during a scan and we use the `messenger(_ controller: CCCapture, errorCode: Int, message: String)` method to receive events to get information on what is the status of the scan. See the list of event codes more details.

The user gets visual guides to ensure good scan quality. For example if the environment is too dark an image is presented. CubiCasa SDK is very customizable, check the customization options for more details.

Please read [our scanning tips](https://www.cubi.casa/support/scanning/best-scanning-technique/) on how the scan should be made.

### Ending the Scan
The scan is ended when the user presses the record button again. To prevent unintentionally ending the scan, a confirmation dialog is presented. After confirmation, the scan is completed and the `processReadyDelegationFunc(_ controller: CCCapture)` and `zippedDataLocation(_ controller: CCCapture, location: URL)` delegate functions will be called.

Please note that the scan may be aborted if the SDK encounters an unrecovable error.

#### After the scan the data is stored to the passed filename
```
└── Documents
    ├── ExampleFileName
    │   ├── UID.zip
    │   ├── arkitData.json
    │   ├── config.json
    │   ├── video.mp4
    │   ├── scan.log
    │   ├── feedback.json
    │   ├── allDepthFrames.bin
    │   └── Mesh.scn
```
You can easily inspect the data but do not touch the zip file. Please note that the `allDepthFrames.bin` and `Mesh.scn` will be present for LiDAR devices (only).

### Errors
If the SDK encounters unrecovable errors during scanning the scan will be interrupted and the SDK will remove all files it has created.

### The event codes 
In the SDK the following codes can be received

| Code | Description |
| -------------|---|
| `0` | Received when the device is in landscape orientation. This is usually the first status code received when the device is turned to landscape orientation in order to start recording. The scanning cannot be started if the device is not in landscape orientation. |
| `1` | Received when the record button is pressed for the first time and scan is started. |
| `2`| Received when the record button is pressed for the second time and scan has enough data. The saving of the scan files begins after this. |
| `3` | Finished recording - Not enough data. |
| `5` | Finished recording - CubiCapture is finished. You can now finish your scanning controller. |
| `7` | Received when the zipping of the scan files is finished. The description will contain a path to the zip file. You also get the path from `zippedDataLocation(_ controller: CCCapture, location: URL)` delegate method. |
| `8` | ARKit tracking failure Insuffient light. Received when ARKit motion tracking is lost due to poor lighting conditions. |
| `9` | ARKit tracking failure excessive motion. Received when the device is moving excessively |
| `13` | Scan drifted! Position changed by over 10 meters during 2 second interval. The scan files **will be deleted** and CubiCapture will be finished. |
| `15` | Error, removing scan. Received when the scan is not successful. The scan files are deleted and CubiCapture will be finished. |
| `17` | Received when the device is in reverse-landscape orientation and if the device has been in landscape orientation at least once. |
| `18` | Playing error sound. |
| `21` | Received when the pitch of the camera has been too low for a certain amount of time (Scanning floor). |
| `22` | Scanning ceiling. |
| `23` | Not scanning ceiling or floor. Received when the pitch of the camera is valid again. |
| `24` | Not wrong orientation anymore.	|
| `26` | Not scanning ceiling.		|
| `27` | Not walking sideways anymore |
| `28` | Scanning state back to normal |	
| `29` | Walking sideways. Displaying left warning |	
| `30` | Walking sideways. Displaying right warning |
| `31` | Horizontal scanning |
| `32` | Not scanning horizontally anymore |
| `40` | Started listening for speech.		|
| `41` | Listening finished, displaying recognition results. |	
| `42` | Recognition result '<spaceLabel>' was chosen.		|
| `43` | Recognition results canceled.		|
| `44` | Speech recognition aborted.		|
| `45` | No speech recognition results.		|
| `46` | All recognition results over the max length of 40 characters.	|	
| `47` | Requesting RECORD_AUDIO permission.		|
| `48` | User granted RECORD_AUDIO permission.		|
| `49` | User denied RECORD_AUDIO permission.		|
| `51`| Zipping the scan failed. The scan files **will be deleted** and CubiCapture will be finished. |
| `53`| Invalid zip archive, attempting rezipping |
| `54` | Failed to write arkitdata to file. The scan files **will be deleted** and CubiCapture will be finished. | 
| `56` | Failed to write config to file |
| `57` | Failed to start write depth data to file |
| `58` | Could not find filepath. |
| `59` | Depth map or AVasset writer could not take frames in. Received when there was an error in writing the data to disk. |
| `66` | Unable to get correct values for the device's position.
| `70` | Thermal state nominal
| `71` | Thermal state fair
| `72` | Thermal state serious
| `73` | Thermal state critical
| `74` | Low power mode activated
| `75` | Low power mode deactivated
| `76` | Active processor count is X of Y
| `77` | Received memory warning
| `78` | Storage: [minutes] minutes left
| `80` | Relocation timed out.
| `81` | No configuration found!
| `82` | No snapshot for relocation. Cannot relocate.
| `83` | Scanning aborted due to App going to the background
| `85` | Scanning too close
| `86` | Scanning too far
| `87` | Too fast rotations. Showing fast movement warning.
| `88` | Scanning distance back in acceptable range (proximity warning not shown anymore)
| `90` | Failed to start writing scan log

### Scan Playback
The CubiCasa SDK can play back previously made scans, allowing users to review their scans and feedback. On LiDAR devices, the reconstructed scene mesh is shown superimposed on the video (if the `.meshVisualisation` option was enabled for the scan and scene reconstruction was not shut down due to the thermal state reaching `critical`). Also on LiDAR devices only, the proximity warning pattern will be shown superimposed on the video.

Playback is done by instantiating a `CCScanPlaybackViewController`, as follows:

```swift
// location is the URL that was received from the CCCaptureDelegate func
// zippedDataLocation(_ controller: CCCapture, location: URL) after scanning

let playbackVC = try CCScanPlaybackViewController(projectLocation: location)

// Now present playbackVC or push it onto a navigation controller
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
The CubiCasa SDK is localizable to any language. At the moment we support only English translations but if your app has support for multiple languages you can easily also translate all texts in the SDK as well. If you want to use a different tone in the texts or something you can always define your own.

The following is an excerpt from the SDK’s Localizable.strings; just define your own texts with the following. See the `Localizable.strings` file in this project. By overriding the keys you can change the text as you please.

### Colors
Variable name | Description
--------------|------------
`cc_speech_button_indicator`| The color of the animated circle behind speech recognition record button
`cc_speech_result_text` | The color of text in displayed result cells
`cc_speech_result_background`| The background color for speechrecognition result cells
`cc_speech_cancel_text` | The color of text for the cancel button in speech recognition result list
`cc_speech_cancel_background` | Background color for the cancel button in speech recognition result list
`cc_speech_label_text` | Text color for the label next to speech recognition record button. Displays the "Say room name" and "No results" texts.
`cc_speech_label_background` | Background color for the label next to speech recognition record button.
`cc_hint_label_text` | Text color for the arrowy labels next to buttons in initial view
`cc_hint_label_border` | The color of the border for the arrow view
`cc_hint_label_background` | Background color for the arrow labels
`cc_mesh` | The color used for mesh visualization.
`cc_scan_border_ok`| Color of the border view during scan when everything is ok
`cc_scan_border_warning` | Color of the border when the scanning environment is not optimal
`cc_guide_background` | Backgroundcolor of the view that guides the user to turn the phone to landscape orientation when the scanning view is opened
`cc_guide_info_text` |  Text color of the view that guides the user to turn the phone to landscape orientation when the scanning view is opened
`cc_timer_label_text` | Color of the timer label
`cc_warning_info_text` | Color of the info text in the warning view
`cc_warning_title_text` | Color of the title in the warning view
`cc_warning_view_background` | Background color of the warning view
`cc_warning_relocated_background` | Background color for the warning view when relocated
`cc_warning_relocating_background` | Background color for the warning view while relocating
`cc_warning_too_close_foreground` | Foreground color for the too-close warning
`cc_warning_too_close_background` | Background color for the too-close warning
`cc_warning_too_close_border` | Border color for the too-close warning

### Images
You can change the used images used in `CCCapture`. You can change the images by defining images with following keys in your apps main bundle:

 Image | Description 
-------|------------
`cc_microphone_disabled` | Used in the speech recognition button when it is in disabled state
`cc_microphone_ready` | Used in the speech recognition button when it is enabled
`cc_microphone_recording` | Used in the speech recognition when the speech recognition is recorning
`cc_not_recording` | Used in the record button when not scanning
`cc_recording` | Used in the record button while scanning
`cc_turn_device` | Used in the guide view that guides the user to turn the device to landscape orientation
`cc_warning_arrow` | An arrow that is used when warning the user not to scan too high
`cc_warning_rotate` | Used in the warning view when the scanning device us upside down
`cc_warning_tilt_down` | Used to guide the user tilt the phone down and not scan horizontally so much
`cc_broken_scan` | Used in warning view to indicate that tracking has been lost
`cc_go_back` | Used in warning view to guide the user back to a previous location before starting the relocation process
`cc_intact_scan` | Used in warning view to indicate that relocation is successful
`cc_warning_too_fast` | Used in warning view when scanner is turning around too fast

### UI Elements
You can change the appearance of some of the UI elements through the `overlayView` object of `CCCapture`. You can change the font of and label and images for a button etc. The following elements are accessible in `overlayView`:


 Object | Type | Description 
--------|------|-------------
`trackingLabel` | `UILabel` | The label in the middle of screen that guides the user
`progressSpinner`| `UIActivityIndicatorView` | The spinner displayed when the scan is processing
`recordButton` | `UIButton` | The record button on right hand side of the UI
`timerLabel` | `UILabel` | The label displaying scanning time on the top left-hand corder of the scanning view

Example:

~~~swift
cubiCapture.overlayView.timerLablel.font = UIFont.systemFont(ofSize: 20)
~~~
