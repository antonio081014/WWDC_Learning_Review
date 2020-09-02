# Debugging in Xcode 11

## Device Conditions and Environment Overrides

### Device Conditions
- Thermal state condition:
    
    ProcessInfo.thermalStateDidChangeNotification

    ``` swift
    let state = ProcessInfo().thermalState
    ```

    - Select 'Debug Navigator -> Energy Impact' to view
    - 'Window -> Devices and Simulators' -> Target Device -> 'Device Conditions'

    To turn down the condition, three ways to do:    
    - Click stop button in Xcode under 'Device Conditions'.
    - Disconnect iPhone device from Xcode.
    - Click the top left of status bar to confirm and stop conditions.

- Network link condition

### Environment Overrides
- Interface Style
    Turn between light mode and dark mode.

- Dynamic Type
    Use system font is a better choice.

- Accessibility

## Debugging Live Previews


## Debugging SwiftUI View Hierarchies
