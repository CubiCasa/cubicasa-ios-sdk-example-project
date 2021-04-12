# Table of Contents

   * [CubiCaptureDemo](#cubicapturedemo)
      * [Description](#description)
   * [Cubicasa SDK](#cubicasa-sdk)
      * [Release Notes](#release-notes)
      * [Glossary](#glossary)
      * [Installation](#installation)
         * [Cocoapods](#cocoapods)
      * [Updating from CubiCapture 2.0 to CubiCapture 2.3](#updating-from-cubicapture-20-to-cubicapture-23)
         * [Adaptive Lighting](#adaptive-lighting)
         * [Speech Recognition for Room Labels](#speech-recognition-for-room-labels)
               * [Permissions](#permissions)
               * [UI Customization](#ui-customization)
                  * [Example](#example)
               * [New texts](#new-texts)
         * [Scene Reconstruction](#scene-reconstruction)
      * [Permissions](#permissions-1)
      * [Device Orientation](#device-orientation)
      * [Scan lifecycle](#scan-lifecycle)
         * [Setting up](#setting-up)
         * [Starting the scan](#starting-the-scan)
         * [Configuration](#configuration)
         * [During the scan](#during-the-scan)
         * [Ending the scan](#ending-the-scan)
            * [After scan the data is stored to the passed filename](#after-scan-the-data-is-stored-to-the-passed-filename)
         * [Errors](#errors)
      * [Adding the Address](#adding-the-address)
         * [The event codes](#the-event-codes)
      * [Customization Options](#customization-options)
         * [Visual](#visual)
            * [Warning and Guide Images](#warning-and-guide-images)
            * [UI Elements](#ui-elements)
         * [Strings](#strings)

# CubiCaptureDemo

Is a simple project which has the CubiCasa SDK integrated.

## Description

The app has only one view controller that has the greetings label and a button. If the user presses
the button CubiCapture view is displayed and you can start scanning. After the scan is complete the capture view is dissmissed.

For your app the next step would be to upload the scan to your server and use [CubiCasa Conversion API](https://cubicasaconversionapi.docs.apiary.io/#).

# Cubicasa SDK

Cubicasa SDK makes possible you to add scanning view to your app which then can use to scan a floor plan with an iOS device.

## Release Notes

- Can resume scanning after returning from background and can recover from drift
- System monitoring, will warn about thermal throttling and memory
- Depth capturing support for the following devices; iPhone 12 Pro, iPhone 12 Pro Max, iPad Pro 2020
- Mesh visualisation to show which spaces have been scanned (visualisation colours can be changed, visualisation can be turned off altogether)
- New status codes (code 3, 5, 18, 27, 29, 30 and 40-49 and 57 to match Android SDK statuses)
- Updated dependencies
- Speech recognition for room labels (Now you can directly say the labels you want to have in the finished floorplan, UI colours can be changed)
- Adjusted lighting for dark spaces (Camera flash will turn on in dark spaces to ensure tracking and data quality)
- UI adjustments for new features see #Updating from CubiCapture 2.0 to CubiCapture 2.2
- Debug symbols (`dSYM`) included in the `CubiCapture.xcframework`
- `CCCapture` is now a `UIViewController`, see #Starting the scan
- Various bugfixes


## Glossary

Term | Description
-----|------------
Scan | The process of capturing the surroundings indoor space using the phone's camera
ARKit | Apple Augementer Reality library that is used in CubiCasa SDK for scanning
Sideways walk | An error which occurs during a scan when the user walks sideways. Walking sideways makes it hard to tract the position of the device and can affect the quality of the scan.
Scene Reconstruction | The process of building a 3D model (mesh) from a video stream (scan)
Mesh visualisation | Showing the reconstructed scene mesh on-screen, during scanning
Drifting | An unrecovable event where the device loses tracking of its surroundings. Can happen if there is a conflict in the sensor data. The scan is lost if drifting occurs.

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
    target.deployment_target = '13.0'
    target.build_configurations.each do |config|
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end
```
Replace `YourTarget` with the name of your build target. Run `pod install`.

## Updating from CubiCapture 2.0 to CubiCapture 2.3

### Resume scan when returning from background

CubiCapture 2.3 adds support for resuming a scan when the app returns from being sent to the background during a scan. The user will be prompted to return to a previously scanned location and the SDK will attempt to relocate. If this succeeds, the scan is continued.

### Adaptive Lighting

CubiCapture SDK 2.2 features the new Adaptive Lighting technique. During the scan if the lighting is too dark `CCCapture`automatically lights up the torch/flashlight of the phone to illuminate the surroundings. The brightness level of the torch depends on the surrounding lightgning conditions. Less light, more torch and the other way around.

### Speech Recognition for Room Labels

CubiCapture SDK utilizes speech recognition. During a scan your users can use the speech recognition to add room labels. If you don't want to use speech recognition you can omit it from the options.

##### Permissions

If you plan to use speech recognition remember to add microphone and speech recognition privacy usages to your `Info.plist`.

##### UI Customization

Speech recognition feature introduces new UI elements: The speech recognition record button, speech recognition info label, and the result table view. The colors of these elements can be customized to your liking. All colors are members of the `overlayView` of `CCCapture` view you must change the values before calling the `setView` method or presenting `CCCapture`. Checkout the list below:

Variable name | Description
--------------|------------
`speechButtonIndicatorColor`| The color of the animated circle behind speech recognition record button
`speechResultTextColor` | The color of text in displayed result cells
`speechResultBackgroundColor`| The background color for speechrecognition result cells
`speechCancelTextColor` | The color of text for the cancel button in speech recognition result list
`speechCancelBackgroundColor` | Background color for the cancel button in speech recognition result list
`speechLabelTextColor` | Text color for the label next to speech recognition record button. Displays the "Say room name" and "No results" texts.
`speechLabelBackgroundColor` | Background color for the label next to speech recognition record button.
`hintTextColor` | Text color for the arrowy labels next to buttons in initial view
`hintBorderColor` | The color of the border for the arrow view
`hintBackgroundColor` | Background color for the arrow labels
`meshColor` | The `UIColor` to use for mesh visualization.

###### Example

To set the text color of the hint label to blue would be 
```swift
cubiCapture.overlay.hintTextColor = .blue
```

##### New texts

Speech recognition features the following new customizable texts:

Name | Description | Default value
-----|-------------|--------------
`speechHintInitialText` | Displayed on the arrowy button next to speech recording button before the scan is started | *2. Say the room name*
`speechHintText` | Displayed on the label next to speech recognition record button when the button is tapped |  *Say the room name*
`speechNoResults` | Displayed in the label next speech recording button if no results are found | *No results*

### Scene Reconstruction

On LiDAR-equiped devices, the reconstructed scene mesh is shown on-screen during the scan, to give the user an idea of which parts of the space have been scanned already. Scene reconstruction can be disabled by omitting it from the `.options` of `CCCapture`.

The color of the mesh is configurable:

Variable name | Description
--------------|------------
`meshColor`   | The `UIColor` to use for mesh visualization.

## Permissions

CubiCasa SDK uses the device camera to capture the surroundings so you need to add the "Privacy - Camera Usage Description" to your projects `Info.plist` if you already haven't done so. The camera permission is required for the CubiCasa SDK, it cannot function without it. Also if you want to use speech recognition (optional) add "Privacy - Microphone Usage Description" and the "Privacy - Speech Recognition Usage Description". 

## Device Orientation

CubiCapture view only works when the view is locked to portrait orientation (even though it looks like a landscape view) If our app supports both portrait and landscape orientation make sure disable orientation change when you are displaying CubiCapture view.

## Scan lifecycle

### Setting up

You can specify where the scan will be placed in the app document directory with CCCapture `fileName` field.

### Starting the scan

The recommended way to use `CCCapture` is as a `UIViewController`:

```swift
import CubiCapture
...
let cubiCapture = CCCapture()
cubiCapture.delegateCapture = self
present(cubiCapture, animated: true, completion: nil)
```

For backward compatibility, the following method also still works:

```swift
import CubiCapture
...
private let cubiCapture = CCCapture()
...
cubiCapture.delegateCapture = self
cubiCapture(sceneToController: self)
```
Note that in this case, you need to assign `CCCapture()` to a property (`private let cubiCapture`) of your class, to retain it.

You can add the address of the place to be scanned by adding the address information to `CCCapture` view. See "Adding the Address".

When the user has oriented the device to landscape and presses the record button the scan starts.

Remember to add CCCaptures delegate to controlling viewcontrollor to get messages about the scan progress. 

### Configuration
CubiCasa capture session features can be configured by assigning an option set:

```swift
cubiCapture.options = [.speechRecognition, .meshVisualisation, .backgroundResume]
present(cubiCapture, animated: true, completion: nil)
```

The following options can be set:

Option name          | Description | Default
---------------------|-------------|--------
`.speechRecognition` | Use speech recognition for making room labels | enabled
`.meshVisualisation` | Reconstruct the scene as a 3D mesh and visualise it (only on LiDAR-equiped devices) | enabled
`.backgroundResume`  | Resume scan when returning from background (aborts scan if disabled) | disabled

### During the scan

A lot of things can happen during a scan and we use the `messenger(_ controller: CCCapture, errorCode: Int, message: String)` method to recive events to get information on what is the status of the scan. See the list of event codes more details.

The user gets visual guides to ensure good scan quality. For example if the environment is too dark an image is presented. CubiCasa SDK is very customizable check the customization options for more details.

Please read [our scanning tips](https://www.cubi.casa/support/scanning/best-scanning-technique/) on how the scan should be made.

### Ending the scan

The scan is ended when the user presses the record button again. After the scan is complete the `processReadyDelegationFunc(_ controller: CCCapture)` and `zippedDataLocation(_ controller: CCCapture, location: URL)`.

You should call the `endCaptureSession()` method
to end the capturing session when you have the data processed and make sure there is no dangling memory leak. 

Please note that the scan may end if the SDK encounters an unrecovable error.

#### After scan the data is stored to the passed filename
```
└── Documents
    ├── ExampleFileName
    │   ├── UID.zip
    │   ├── arkitData.json
    │   ├── config.json
    │   ├── video.mp4
    │   ├── scan.log
    │   └── allDepthFrames.bin
```
You can easily inspect the data but do not touch the zip file. Please note that the `allDepthFrames.bin` will be present for LiDAR devices (only).

### Errors

If the SDK encounters unrecovable errors during scanning the scan will be interrupted and CubiCasa SDK will remove all files it has created.

## Adding the Address

You can add addres information to your scan. `CCCapture` has the following fields for address:

* `number`
* `postCode`
* `city`
* `state`
* `country`
* `suite`

All fields are `String`s.

These will be added to your order configuration.

### The event codes 

In the SDK the following codes can be received

| Code | Description |
| -------------|---|
| `0` | Received when the device is in landscape orientation. This is usually the first status code received when the device is turned to landscape orientation in order to start recording. The scanning cannot be started if the device is not in landscape orientation. |
| `1` | Received when the record button is pressed for the first time and scan is started. |
| `2`| Received when the record button is pressed for the second time and scan has enough data. The saving of the scan files begins after this. |
| `3` | Finished recording - Not enough data. |
| `7` | Received when the zipping of the scan files is finished. The description will contain a path to the zip file. You also get the path from `zippedDataLocation(_ controller: CCCapture, location: URL)` delegate method. |
| `8` | ARKit tracking failure Insuffient light. Received when ARKit motion tracking is lost due to poor lighting conditions. |
| `9` | ARKit tracking failure excessive motion. Reveived when the device is moving excessively |
| `13` | Scan drifted! Position changed by over 10 meters during 2 second interval. The scan files **will be deleted** and CubiCapture will be finished. |
| `15` | Error, removing scan. Received when the scan is not successful. The scan files are deleted and CubiCapture will be finished. |
| `17` | Received when the device is in reverse-landscape orientation and if the device has been in landscape orientation at least once. |
| `21` | Received when the pitch of the camera has been too low for a certain amount of time. |
| `23` | Not scanning ceiling or floor. Received when the pitch of the camera is valid again. |
| `24` | Not wrong orientation anymore.	|
| `26` | Not scanning ceiling.		|
| `27` | Not walking sideways anymore |
| `28` | Scanning state back to normal |	
| `29` | Walking sideways. Displaying left warning |	
| `30` | Walking sideways. Displaying rigth warning	|
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
| `54` | Failed to write arkitdata to file. The scan files **will be deleted** and CubiCapture will be finished. | 
| `56` | Failed to write config to file |
| `57` | Failed to start write depth data to file |
| `58` | Could not find filepath. |
| `59` | Depth map or AVasset writer could not take frames in. Received when there was an error in writing the data to disk. |
| `70` |	Thermal state nominal
| `71` |	Thermal state fair
| `72` |	Thermal state serious
| `73` |	Thermal state critical
| `74` |	Low power mode activated
| `75` |	Low power mode deactivated
| `76` |	Active processor count is X of Y
| `77` |	Received memory warning
| `80` |	Scanning pause due to drift/user error
| `81` |	Resume scanning
| `82` |	No snapshot for relocation. Cannot relocate.
| `83` |	Scanning aborted due to App going to the background
| `90` |	Failed to start writing scan log

## Customization Options

### Visual 

#### Warning and Guide Images

You can change the used images and change texts by changing the in the `CCCapture`. The following items can be changed:

 Object | Type | Description 
--------|------|-------------
`warningTextMovement` | `String` | Displayed when exessive motion on the device is detected. Default value is `"You are moving too fast"`
`warningTextDark` | `String` | Displayed when the lighting condions are poor. Default value is `"Please move back few steps, there is too dark"`
`warningTextLost` | `String`| Displayed when tracking is lost. Default value is `"We are sorry but your tracking was lost"``
`sidewaysWalkImageRight` | `UIImage` | Displayed when user is walking sideways to the right 
`sidewaysWalkImageLeft` | `UIImage` | Displayed when user is walking sideways to the left 
`greendBorderImage`| `UIImage` | Displayed during the scan when the scan is proceeding normally. The default image is a green frame for the scanning view.
`orangeBorderImage`| `UIImage` | Displayed if something is affecting the quality of the scan (e.g. poor lighting). The default image is an orage frame for the scanning view
`ceilingWarningImage` | `UIImage` | Displayed when the device is pointing too much upwards.
`floorWarningImage` | `UIImage` | Displayed when the device is pointing too much downwars.
`rotatePhoneWarningImage` | `UIImage` | Displayed when the devices is rotated too much or the device is in wrong orientation.

Example:

~~~swift
cubiCapture.greenBorderImage = UIImage(named: "customized-status-ok.png")
~~~

#### UI Elements

You can change the appearance of some of the UI elements through the `overlayView` object of `CCCapture`. You can change the font of and label and images for a button etc. The following elements are accessible in `overlayView`:


 Object | Type | Description 
--------|------|-------------
`trackingLabel` | `UILabel` | The label in the middle of screen that guides the user
`progressSpinner`| `UIActivityIndicatorView` | The spinner displayed when the scan is processing
`recordButton` | `UIButton` | The record button on right hand side of the UI
`timerLabel` | `UILabel` | The label displaying scanning time on the top left-hand corder of the scanning view

Example:

~~~swift
cubiCapture.overlayView.recordButton.setImage(UIImage.init(named: "customized-record-button.png"), for: UIControl.State.normal)
~~~


### Strings

`CCCapture` displays informative lables to the user before and during a scan. The contents of these labels are customizable for localization or to change the "tone of voice" for the texts. Currently the following texts are used


Name | Description | Default value
-----|-------------|--------------
`warningTextMovement`| Displayed in when the the scanning device is moved to fast | *You are moving too fast*
`warningTextDark` | Displayed when there aren't enough features in the scanned area. | *Please move back few steps, there is too dark*
`warningTextLost`| Displayed if the scan is interrupted unrecoverably. All data is lost | *We are sorry but your tracking was lost*
`warningTextInitializing`| Displayed in the very beginning of the scan. Guides the user to be the device around for `CCCapture` to get bearings on the surrounding space | *Move your device to start tracking*
`recordHintText`| Displayed on the arrowy button next to record button before the scan is started | *1. Start scanning*
`speechHintInitialText` | Displayed on the arrowy button next to speech recording button before the scan is started | *2. Say the room name*
`speechHintText` | Displayed on the label next to speech recognition record button when the button is tapped |  *Say the room name*
`speechNoResults` | Displayed in the label next speech recording button if no results are found | *No results*
`scanEnded`| Displayed after the user has stopped the scans. Informs the user not to close the application while the scan is being processed | *Finalizing scan. Please do not exit the application.*