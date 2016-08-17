# WWDC2016 Session 418 Using Time Profiler In Instruments

## Intro to profiling
How much and what kind of work is my app doing?

The Call Tree displays counter of each calls, it doesn't measure the duration of each calls, even ignore/lose some quick/short calls. So, it shows long running calls and the most repetitive calls.

## Going faster
- Focused on an area of high CPU usage
	> Zoom and Select area will help focus on the "Problems", which filters out all other unrelevent calls.
- Examined the call tree, looking for where the work was happening
- Walked back to our code
- Insepected our code
- Made it faster
- Verified the changes
- Saved the user's time

## Doing less
- Focused on low, but __unexpected__ CPU usage
- Examined the call tree
- Determined the frameworkds involved
- Stopped doing unnecessary work
- Verified the changes
- Improved battery life

## Improving responsiveness

###### Problem: The main thread does all the UI work
- Runloop waiting for events
- Sends events to your UIApplication instance
- Passes through the responder chain
- Your code gets invoked

###### Phenomenon: When busy, the main thread can't process events
- The queue backs up
- Stuttering and hiccups
- App becomes unresponsive

###### What to Do: Keep your main thread Free
- Examined the CPU spikes
- Focused on the main thread
- Identified non-UI work happening on the main thread
- Distributed the work across multiple threads
- Verified the changes
- Achieved a better user experience

## Tips
- Always profile release builds
- Always profile on the device
- Run with old devices
- Use large data sets where it makes sense
- Look for **poorly scaling code** (O(n^2), etc.)

## Summary
- Optimaize High CPU usage
- Remove Unexpected CPU usage
- Move heavy work away from main thread