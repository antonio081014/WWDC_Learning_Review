# WWDC2015 Session 230 Performance on iOS and watchOS

## Why should I think about performance?
It's a feature in your app that you should have on your mind all the time.
- Responsiveness delights and engages users
- Be a good neighbor, especially in Multitasking on iPad
- Efficient apps extend battery life
- Supports the whole range of iOS 9 hardware

## Thinking About Performance
- Choosing technologies
	- Know the technologies
	- Pick the best ones for your app
	- Apple technologies are optimized (we use them)
	- Benifit from updating
- Taking measurements
	- Animations: Instruments: Core Animation
	- Responsiveness: Core instrumentation, Instruments: System Trace
        - Don't ship your instrumentation: Create a copy of release scheme in Xcode, and define one additional define, so you could build a release version of the app with performance instrumentation quickly and easily.
        - Collect start and end times: CFAbsoluteTimeGetCurrent
        - Taps and button presses: IBAction, touchesEnded, UIGestureRecognizer target
        - Tabs and modal views: viewWillAppear, viewDidAppear, will show how long it takes to display a the view.
	- Memory: Xcode debugger, Instruments Allocations, Instruments Leaks
		- Allocate, Reallocate memory takes time.	
			- Ref: iOS App Performance: Memory, WWDC12
			- Ref: Improving Your App with Instruments, WWDC14
			- Ref: Optimzing Your App Multitasking on iPad in iOS 9
- Setting goals
	- 60fps scrolling and animations. 
		- Ref: Advanced Graphics and Animations for iOS Apps, WWDC14
	- Respond to user actiosn in 100ms

- Performance Workflow
	> Reproduce -> Profil -> Measure -> Change code -> Reproduce

	- Profiling vs Measuring
		- Profiling: Unsderstanding overall app activity
			- Xcode debugger
			- Instruments: Time Profiler
		- Measuring: Instrumenting a specific action
			- CGAbsoluteTimeGetCurrent
			- Instruments: System Trace

	- Avoid Using the Main Thread for
		- CPU-intensive work
		- Tasks that depend on external resource

	- Common Blocking Calls
		> Any code path that ends up making a syscall
		> 
		> Accessing resources not currently in memory: Disk I/O, Network access
		> 
        > Waiting for work to complete on another thread
		
		- Networking: NSURLConnection and frineds
			- Use asynchronous API
			- Use GCD, Ref: Building Responsive and Efficient Apps with GCD 
			- NSURLSession background session
		- Foundation initializers
			- contentsOfFile:
			- contentsOfURL:
		- Core Data
			- Move some Core Data work to different concurrency modes. Ref: What's New in Core Data, Mission.





