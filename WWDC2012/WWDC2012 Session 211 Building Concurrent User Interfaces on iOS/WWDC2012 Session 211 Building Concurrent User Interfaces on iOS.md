In this session, Andy presents how to implement the following 3 features to make app UI more concurrent.

- **Concurrent Processing of Data intended using UI**
- **Concurrent Drawing for UI Graphics**
- **Canceling Concurrent Operations**

Bonus Part: present how to use Xcode Instrument Profile to identify the Problems.

### **1. Concurrent Processing of Data intended using UI**
![Data Flow Overview](https://raw.githubusercontent.com/antonio081014/WWDC_Learning_Review/master/WWDC2012/WWDC2012%20Session%20211%20Building%20Concurrent%20User%20Interfaces%20on%20iOS/Screen%20Shot%202015-08-09%20at%2011.46.39%20AM.png)
```
//1st, System events on the main queue
NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//2nd, Separate expensive processing with NSOperationQueue
[queue setName:@”Data Processing Queue”];
[queue addOperationWithBlock:^{ processStock(someStock); }];
[queue addOperationWithBlock:^{
    //3rd, Update data UIKit accesses on the main queue
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        updateUI(someStock);
}]; }];
```
![Step 1 & 2](https://raw.githubusercontent.com/antonio081014/WWDC_Learning_Review/master/WWDC2012/WWDC2012%20Session%20211%20Building%20Concurrent%20User%20Interfaces%20on%20iOS/Screen%20Shot%202015-08-09%20at%2011.51.53%20AM.png)
![Step 3](https://raw.githubusercontent.com/antonio081014/WWDC_Learning_Review/master/WWDC2012/WWDC2012%20Session%20211%20Building%20Concurrent%20User%20Interfaces%20on%20iOS/Screen%20Shot%202015-08-09%20at%2011.53.05%20AM.png)
### **2. Concurrent Drawing for UI Graphics**
- UIKit calls ``-drawRect:`` on the main queue
- You can draw an image for your view on another queue 
```
- (UIImage *)renderInImageOfSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [[UIColor greenColor] set];
    UIRectFill([self bounds]);
    [anImage drawAtPoint:CGPointZero];
    UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}
```
- Drawing APIs are safe to use from any queue
	- if they begin and end in the same operation!
- Must call ``-[UIImageView setImage:]`` on the main queue
### **3. Canceling Concurrent Operations**
Cancel Operation is necessary when user does not need operation to be done anymore, it is reasonable to cancel it before it took too much computing power of battery.

One way to cancel operations is calling: ``-[NSOperationQueue cancelAllOperations]``, but  canceling all the operations is not always the case. So, The other way is ``[operation cancel]``. In the demo, Andy created an `NSDictionary` to keep the operation for each renderer. When user screen in, then add corresponding operations, while if the user screen out, remove it from the `NSDictionary` and cancel it.
```
// 1st, Creating an NSOperationQueue
NSOperationQueue *queue = [[NSOperationQueue alloc] init];
// 2nd, Creating an NSOperation concrete class object.
// NSBlockOperation is a subclass of NSOperation(abstract class)
NSBlockOperation *op = [[NSBlockOperation alloc] init];
// 3rd, Create Weak Reference to the operation
__weak NSBlockOperation *weakOp = op;
// 4th, Adding work to the operation.
[op addExecutionBlock:^{
    for (int i = 0; i < 10000; i++) {
	    // 5th, for each step, check if operation is canceled.
        if ([weakOp isCancelled]) break;
        processData(data[i]);
    }
}];
// 6th, Add the operation to the queue.
[queue addOperation:op];
```
It's important to avoid retain strong reference cycle, by using a weak reference to the operation and used in the operation block.
![Step 3, Weak Reference to the operation](https://raw.githubusercontent.com/antonio081014/WWDC_Learning_Review/master/WWDC2012/WWDC2012%20Session%20211%20Building%20Concurrent%20User%20Interfaces%20on%20iOS/Screen%20Shot%202015-08-09%20at%201.16.21%20PM.png)