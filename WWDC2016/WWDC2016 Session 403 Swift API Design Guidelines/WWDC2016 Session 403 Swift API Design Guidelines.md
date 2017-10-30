# WWDC2016 Session 403 WWDC2016 Session 403 Swift API Design Guidelines

## Roadmap

### Swift API Design Guidelines

*Clarity*


######  “ed”rule

`x.reverse()                            // mutating`

`let y = x.reversed()                   // non-mutating`


###### “ing” rule

`documentDirectory.appendPathComponent(".list")                        // mutating`

`let documentFile = documentDirectory.appendingPathComponent(".list")  // non-mutating`


### The Grand Renaming

```
extension MyController {
  @objc(handleDrag:forEvent:)
  func handleDrag(sender: UIControl, for event: UIEvent) { }  // handleDrag(sender:for:)
}
 
// Generated Objective-C
@interface MyController ()
- (void)handleDragWithSender:(UIControl *)sender for:(UIEvent *)event;
@end

// After adding @objc(handleDrag:forEvent:)
// Generated Objective-C
@interface MyController ()
- (void)handleDrag:(UIControl *)sender forEvent:(UIEvent *)event;
@end
```

### Mapping Objective-C APIs into Swift

```
// Objective-C
typedef NSString * NSCalendarIdentifier NS_EXTENSIBLE_STRING_ENUM; 
NSCalendarIdentifier NSCalendarIdentifierGregorian;

// Generated Swift Interface
struct NSCalendarIdentifier : RawRepresentable {
    init(_ rawValue: String);
    var rawValue: String { get }
    static let gregorian: NSCalendarIdentifier
}
```
