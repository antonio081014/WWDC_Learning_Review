# WWDC 2020 Session 10176 Master Picture in Picture on tvOS

## Add PIP feature on tvOS
1. Add capability in target -> background modes -> Audio, AirPlay, and PiP
2. Configure the audio session to .playback category
    ```swift
    let audioSession = AVAudioSession.sharedInstance()
    do {
        try audioSession.setCategory(.playback)
    } catch {
        print("Setting category to AVAudioSessionCategoryPlayback failed.")
    }
    ```
3. Using the standard playback UI
    - Enabled by default
    - Lifecycle AVPlayerViewControllerDelegate in tvOS 14
    ```swift
    _ = pipController.observe(\.canStopPictureInPicture) { controller, change in
        // Update your UI
        if controller.canStopPictureInPicture {
            pipActions = [.swap, .stop]
        } else {
            pipActions = [.start]
        }
    }
    ```