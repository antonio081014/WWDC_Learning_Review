# WWDC2014 Session 236 Building Interruptible and Responsive Interactions

### From Gesture to Animation
We have two options here to implement this:

- Using UIView animateWithDuration
> This actually executes in another process out of context of your application. The render server(like back end) at a higher priority will make sure not dropping any frame on that animation, even the main thread is running a heavy work or blocked by some tasks. It would be easy to have a smooth animation if offload animation onto the render server by using animateWithDuration method.

- UIDynamicAnimator
> Everything happening is in your process.
> Downside: it's easy to drop animate frame using this tech when thread is busy working on some task.

- CADisplayLink
> This is where UIDynamicAnimator built on.
> This calls you back once every frame.

- ~~NSTimer~~
> Not recommended, highly possible to drop frames.

### From Animation to Animation
**Absolute Animation**

Absolute Animation | Absolute Animation and Begin from Current State
------------------------- | -------------------------------
![Absolute Animation](vlcsnap-2015-08-24-11h53m27s246.png) | ![Absolute Animation and Begin from Current State](vlcsnap-2015-08-24-11h55m43s713.png)

**Additive Animation**
- Smoother transitions on iOS 8 by default 
- Still use BeginFromCurrentState if unsure
- Completion handlers may stack, since the change of animation would not stop or cancel the old animation, it actually create a new animation. Both of them would be finished.

|Additive Animation|Completion Handler|
|------------------|--------------|
|![Additive Animation](vlcsnap-2015-08-24-13h21m46s063.png) | ![](vlcsnap-2015-08-24-14h48m04s032.png)|


|Absolute Animation|Additive Animation|
|------------------|--------------|
|![](vlcsnap-2015-08-24-13h22m22s499.png) | ![](vlcsnap-2015-08-24-13h22m28s162.png)|

### From Animation to Gesture
Key part of thie section is converting CGPoint from one coordinate to another. One layer to another layer, or one view to another view.
