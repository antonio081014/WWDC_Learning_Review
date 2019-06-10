# WWDC2015 Session 411 Swift in Practice
To find more issues during the compile time.

I was directed from Book _Core Data_ to the know the existence of this wonder talk, regarding how to make compiler work better for developer.

## Take advantage of new APIs while  deploying to older OS releases
__Problem__: Users on Different OS Releases

__Solution__: Adopt new features and support the older OS releases
- Always use the __Latest SDK__ to access complete set of APIs
- Use Deployment Target to set an application's minimum supported OS release

- [:x:]Manually check Framework, Class, etc.
  - Framework: mannually check framework as optional
  - Class: mannually check if a method/function available.
- [:heavy_check_mark:]Compile-Time API Availability Checking.

## Enforce expected application behavior using enums and protocols
### Use Case: Asset Catalog Identifiers
```
extension UIImage {
    enum AssetIdentifier: String {
        case isabella = "Isabella"
        case william = "William"
        case Olivia = "Olivia"
    }
    
    convenience init!(assertIdentifier: AssetIdentifier) {
        self.init(named: assertIdentifier.rawValue)
    }
}
```
- Centrally located constants
- Doesn't pollute global namespace
- Must use one of the enum cases
- Image initialization are not failable
### Use Case: Segue Identifiers
```
class ViewController: UIViewController {
    enum SegueIdentifier: String {
        case ShowImportUnicorn = "ShowImportUnicorn"
        case ShowCreateNewUnicore = "Show CreateNewUnicorn"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier, segueIdentifier = SegueIdentifier(rawValue: identifier)
        else { fatalError("Invalid segue identifier \(segue.identifier).")}
        
        switch segueIdentifier {
            case .ShowImportUnicorn:    // Config...
            case .ShowCreateUnicor:     // Config...
        }
    }
}
```
When new case added to enum, then the compiler will tell us switch is not exhausted.
```
class ViewController: UIViewController {
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }
}
```

### To avoid duplicate all of the smart solution showed above, use `Protocol`
```
protocol SegueHandlerType {
    typealias SegueIdentifier: RawRepresentable
}

// Shared Implementation.
extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier)
        else { fatalError("Unknown segue: \(segue))") }
        return segueIdentifier
    }
    
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }
}

class ViewController: UIViewController, SegueHandlerType {
    enum SegueIdentifier: String {
    // ...
    }
}
```
