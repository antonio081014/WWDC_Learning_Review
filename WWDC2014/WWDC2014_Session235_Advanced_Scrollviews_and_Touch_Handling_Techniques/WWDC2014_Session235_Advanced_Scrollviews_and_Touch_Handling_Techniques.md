# WWDC2014 Session 235 Advanced Scrollviews and Touch Handling Techniques

This is one of the very technique session in WWDC 2014. I have made a duplicate demo from this session and published it [here](https://github.com/antonio081014/TouchDemo).

Here is a list of problems and solutions from the talk.

- When `UIScrollView` with DrawerView (`UIVisuallEffectView`) added to controller's view(AView),  AView's user interaction is blocked. How to keep AView unblocked from user?
> Set `UIScrollView`'s [`userInteractionEnabled`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/index.html#//apple_ref/occ/instp/UIView/userInteractionEnabled) to be `NO`.

- When `UIScrollView`'s userInteractionEnabled is false, how can we keep `UIScrollView`'s `panGestureRecognizer`, so the `UIScrollView` could be pulled up or down.
> Easy solution would be pass the UIScrollView's property [`panGestureRecognizer`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIScrollView_Class/#//apple_ref/occ/instp/UIScrollView/panGestureRecognizer) to its superview, so the superview could recognize the pan gesture, while not being blocked.

- How to add subviews to `UIVisualEffectView`?
> Since `UIVisualEffectView` would do tons of work for the blurring effect on the view, it's best to add any subview to its `contentView`, which is a `UIView` on top of it. Then these subviews would not interfere with the computation of visual effect.

- How does `- hitTest:withEvent:` work?
> This function is defined in `UIView`, the following is the pseudo code.
> ```
> - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event { 
		if (/* point is in our bounds */) {
	        for (/* each subview, in reverse order */) {
	            UIView *hitView = /* recursive call on subview */
	            if (hitView != nil) {
	                return hitView;
				}
			}
			return self; 
		}
		return nil; 
}
> ```

- How to reenable user interaction on `UIScrollView` without blocking its parent view?
> 1. Set `UIScrollView`'s `userInteractionEnabled` to `YES`.
> 2. Subclass `UIScrollView`, override `- hitTest:withEvent:` function, so this function either returns `UIScrollView`'s subview, or its superview, rather itself.

> ```
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    }
    return hitView;
}
> ```

- How to not cancel other touch event when `UILongPressGestureRecognizer` is triggered?
> Set `cancelsTouchesInView` of `UILongPressGestureRecognizer` to `NO`.

- How to make several `UIGestureRecognizer` recognize simultaneously?
> Implement `UIGestureRecognizer` delegate method: `- gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:`, and return `YES` when certain both of two `UIGestureRecognizer` could be triggered.
>   
> This way, `UIGestureRecognizer` could work simultaneously, between siblings and self, also between superview and self.
>  
>  Thank system for supporting resting touches.

- Good UX to implement:
> 1. When grab / drop a dot:
> Apply a simple animation could be very good choice. Just scale the transform and change the alpha of view.
> 2. When user does not click on the center of view, there might be a 'Jump' at first:
> This could be fixed simply move it to the user touch location when view is grabbed.
> 3. 

- Fastest Fix on conflict between `UIView`'s touch event and `UIScrollView`'s `panGestureRecognizer`.
> Just disable, then enable `UIScrollView`'s `panGestureRecognizer` when UIView's `UILongPressGestureRecognizer` triggered.
> This will disable `panGestureRecognizer` for current user touch, but reenable it will allow panGestureRecognizer to recognize new touches from user.

- How to apply the feature "Touch Delay Gesture Recognizer" from `UIScrollView` to `UIView`.
> 1. Subclass `UIGestureRecognizer`.
> 2. `#import <UIKit/UIGestureRecognizerSubclass.h>`
> 3. Introduce a `NSTimer` for the purpose of delay.
> 4. Set `delaysTouchesBegan` to `YES` in initializer.
> 5. Set `UIGestureRecognizer`'s State to **Failed** when timer expired, touch cancelled or touch ended.
> 6. Override `- reset` function to reset timer.
> 7. Add this customized UIGestureRecognizer to the view, which is a subclass of `UIView`.

- **One More Thing**: how to more easily recognize user's touch when subclass of UIView is pretty small for user to click on?
> Override method `- pointInside:withEvent:` of `UIView`, in the method, check bigger area instead, rather than the bounds of the view.
> 
> 44 is a very common number used in iOS system, so use it frequently and wisely.