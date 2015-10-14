###In this Session, four main topics are covered.
## 1. **Spring animations**
Spring Animation is the base of almost every animation in the iOS8 system, which means almost all of the animations in iOS8 are using spring animation. It was introduced from iOS7 via [one single function](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/index.html#//apple_ref/occ/clm/UIView/animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:):
```
+animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:
```

This function is very similar with ordinary animation function we used to using a lot. The only difference here is two additional parameters: Damping Ratio and Initial Spring Velocity. The damping ratio defines how much the oscillation oscillate at the end state of the animation, ranging from 0.0 to 1.0. 0.0 defines high frequency oscillation, while 1.0 defines no oscillation at all. This is place where can help us make a bouncing effect. The initial spring velocity defines how fast the animation starts. The smaller the volecity is, the sooner the animation object will move to the end state, verse vice.

The following demo code imitate the Animation of Opening Folder on iOS Home Screen.
```
const static CGFloat BOXSIZE = 100.f;
- (void)tapped:(UITapGestureRecognizer *)gesture
{
[self initBox];
[UIView animateWithDuration:1.f
delay:0.f
usingSpringWithDamping:.75f
initialSpringVelocity:.5f
options:0
animations:^{
[self endBox];
} completion:^(BOOL finished) {
//
}];
}

- (void)initBox
{
self.movingBox.frame = CGRectMake(0.f, self.view.bounds.size.height - BOXSIZE, BOXSIZE, BOXSIZE);
}

- (void)endBox
{
self.movingBox.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - BOXSIZE * 3.f / 2.f, CGRectGetMidY(self.view.bounds) - BOXSIZE * 3.f / 2.f, BOXSIZE * 3.f, BOXSIZE * 3.f);
}
```
## 2. **Vibrancy and blur**
In iOS8, [`UIBlurEffect`](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIBlurEffect_Ref/index.html#//apple_ref/occ/cl/UIBlurEffect) and [`UIVibrancyEffect`](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIVibrancyEffect/index.html#//apple_ref/occ/cl/UIVibrancyEffect) are introduced for developers have Dynamic Blur Effect more easily. In the talk, Apple Engineer still recommends using static blur effect code if dynamic blur effect views are not actually what you need, since dynamic blur effect takes a lot of computing power.

The `UIBlurEffect` gives blur effect to an associated `UIView`, while UIVibrancyEffect gives the clear part which is not blurred on the blurred view. So, this is a three layer structure. `UIView` at the bottom, then comes the `UIBlurEffect`, at last the UIVibrancyEffect comes. The UIVibrancyEffect consumes the computing power most. The `UIBlurEffect` gives three styles for the developer to use, `UIBlurEffectStyleExtraLight`, `UIBlurEffectStyleLight`, `UIBlurEffectStyleDark`.

The example could be found at Siri User Interface, where user could clearly see the app icons on the Home Screen of the iPhone.

## 3. **Shape layers**
In this section, the engineer talks about the CAShapeLayer. Several things should be mentioned here:

How to use CAShapeLayer back up the `UIView` as the base layer. In `UIView` subclass,
```
+ (Class)layerClass {
return [CAShapeLayer Class];
}

- (void)awakeFromNib {
CAShapeLayer *layer = (CAShapeLayer *)self.layer;
// init layer properties here.
// Also, everytime to update layer property, convert it to CAShaperLayer and use a local variable for it.
}
```
How to draw part of the path for CAShapeLayer, by setting strokeStart and strokeEnd.
## 4. **Dyanmic Core Animation behaviors**
This is probably the most challenging part for me, so many sample code on [`CABasicAnimation`](https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CABasicAnimation_class/index.html). I think have a good use of [`CAAction`](https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CAAction_protocol/index.html) Protocol and [`CALayerDelegate`](https://developer.apple.com/library/ios/documentation/QuartzCore/Reference/CALayerDelegate_protocol/) method could greatly help your custom `UIView` subclass have great animation effect when `UIView`’s properties are changed. Also, developer could define customized property, which could be very powerful. By using this technique, developer could not only customize animation behavior, but also disable system’s default animation behaviors.

Here is a simple piece of demo:
```
//
//  CustomAnimationView.m
//  Sample
//
//  Created by Antonio081014 on 8/9/15.
//  Copyright (c) 2015 antonio081014.com. All rights reserved.
//

#import "CustomAnimationView.h"

@interface CustomAnimationAction : NSObject <CAAction>
@end

@implementation CustomAnimationAction

- (void)runActionForKey:(NSString *)event object:(id)anObject arguments:(NSDictionary *)dict
{
if ([event isEqualToString:@"opacity"]) {
CALayer *layer = (CALayer *)anObject;
CFTimeInterval duration = .75;

CABasicAnimation *bgAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
bgAnimation.duration = duration;
bgAnimation.fromValue = (id)[layer.presentationLayer backgroundColor];
bgAnimation.toValue = (id)([UIColor colorWithHue:layer.opacity saturation:1.f brightness:1.f alpha:1.f].CGColor);
bgAnimation.fillMode = kCAFillModeForwards;
bgAnimation.removedOnCompletion = NO;
[layer addAnimation:bgAnimation forKey:@"bgColorAnim"];

CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
animation.duration = duration;
animation.fromValue = @([layer.presentationLayer opacity]);
animation.toValue = @(layer.opacity);
animation.removedOnCompletion = NO;
[layer addAnimation:animation forKey:@"customKey"];
}
}

@end

@implementation CustomAnimationView

+ (Class)layerClass
{
return [CAShapeLayer class];
}

- (void)awakeFromNib
{
[self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
if (self = [super initWithFrame:frame]) {
[self setup];
}
return self;
}

- (void)setup
{
CAShapeLayer *layer = (CAShapeLayer *)self.layer;

UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];

[layer setPath:path.CGPath];
[layer setStrokeColor:[UIColor purpleColor].CGColor];
[layer setLineWidth:6];
[layer setFillColor:nil];
[layer setLineCap:kCALineCapRound];
[layer setLineJoin:kCALineJoinBevel];

UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
[self addGestureRecognizer:gesture];
}

- (void)tapped:(UITapGestureRecognizer *)gesture
{
[UIView animateWithDuration:1.0 animations:^{
//        CGFloat dx = arc4random() % 100 - 50;
//        CGFloat dy = arc4random() % 100 - 50;
//        CGFloat x = self.frame.origin.x + dx;
//        CGFloat y = self.frame.origin.y + dy;
//        self.frame = CGRectMake(x, y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
[self setAlpha:(CGFloat)(arc4random() % 10) / 10.f];
}];
}

- (id<CAAction>)actionForLayer:(CALayer *)layer
forKey:(NSString *)key
{
if ([key isEqualToString:@"opacity"]) {
return [[CustomAnimationAction alloc] init];
}
return [super actionForLayer:layer forKey:key];
}

@end

```
**Worth to mention** here: when Custom View's frame origin changed, the Key for the change will be **"Position"**, rather than **"Frame"**. This is because `UIView` is backed by `CALayer`, where essentially all the animations added to. My guess would be: any animation of changing property of `UIView` will be "mirrored" to some action of changing property of `CALayer`.

For more information, here is a link to the [Apple Developer Official Page](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CoreAnimation_guide/ReactingtoLayerChanges/ReactingtoLayerChanges.html).


----------
