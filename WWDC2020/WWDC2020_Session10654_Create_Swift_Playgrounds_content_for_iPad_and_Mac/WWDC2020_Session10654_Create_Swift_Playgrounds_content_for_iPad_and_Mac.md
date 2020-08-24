# WWDC2020_Session10654_Create_Swift_Playgrounds_content_for_iPad_and_Mac

This session introduces the fundermental information about creating Swift Playground content on iPad and Mac.

## Take advantage of the UI differences

## Customizing content for each platform
### Specify the supported device type and capabilities
1. Use the `SupportedDevices` key in `Manifest.plist` and `supportedDeevices` in `feed.json` to show the supported device type, e.g. Mac or iPad or "iPad and Mac"
2. Use the `requiredCapabilities` to specify required capabilities. `RequiredCapabilities` in `manifest.plist` and `requiredCapabilities` in `feed.json`. Capabilities includes camera, microphone, and so on.
### Use target enviroment checks to customize content
```
#if targetEnvironment(macCatalyst)
// do something on mac
showTurtleInAR()
#else
// do something on iPad
showTurtleOnScreen()
#endif
```
## Respect the platform's settings
1. Try to use system color, and could specify customized colors in Asset catelog.
2. Use safe area layout guides.