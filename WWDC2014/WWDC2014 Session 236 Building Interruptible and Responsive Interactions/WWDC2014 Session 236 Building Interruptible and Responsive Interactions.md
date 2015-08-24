# WWDC2014 Session 236 Building Interruptible and Responsive Interactions

### From Gesture to Animation
We have two options here to implement this:
- 1. Using UIView animateWithDuration
This actually executes in another process out of context of your application. The render server(like back end) at a higher priority will make sure not dropping any frame on that animation, even the main thread is running a heavy work or blocked by some tasks. It would be easy to have a smooth animation if offload animation onto the render server by using animateWithDuration method.
- 2. UIDynamicAnimator

### From Animation to Animation

### From Animation to Gesture

 