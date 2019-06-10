In this session, Quinn  presents how to use right Data Structures to improve the app performance as much as possible.

## 1. When to focus on performance
![Steve Quote 1](p1.png)
![Steve Quote 2](p2.png)
Trying to improve the parts consume more execution time.

- **Premature optimization** leads to unnecessary complexity
   	- “If it ain’t broke, don’t fix it.”
   	- Use Instruments to focus on bottlenecks
- **Informed design** leads to elegant, efficient code
   	- Consider performance during design
   	- Intelligently avoid real performance pitfalls
   	- Why design in slowness you can easily avoid?

	
## 2. How to evaluate computational complexity
This part Quinn present Big-O notation, which presents the computational complexity of an Algorithm, or Operation.
Example Here:
`[NSArray -containsObject:]` vs `[NSSet -containsObject:]`

 - `[NSArray -containsObject:]` sends `-isEqual:` to each objects in the array, which will take O(N).
 - `[NSSet -containsObject:]` takes O(1) instead, because `NSSet` is a Hash-Based Organization, which trying the best to have all the objects uniform distributed.

`NSObject`'s `-isEqual:` and `-hash` are functionally equivalent to:
```
 - (BOOL) isEqual:(id)other {
	return self == other;
}
 - (NSUInteger) hash {
	return (NSUInteger)self;
}
```
To Identify the Custom NSObject Subclass object, at least `-isEqual:` and `-hash` needs to be implemented in the subclass. The better `-hash` function implemented, the better performance will be retrieved for searching/identifying involved operations.
```
@interface WWDCNews : NSObject <NSCopying>
@property (readonly, copy) NSString *title;
@property (readonly, copy) NSDate *timestamp;
@end
@implementation WWDCNews
 - (NSUInteger) hash {
	return [self.title hash];
}
 - (BOOL) isEqual:(id)object {
	return ([object isKindOfClass:[WWDCNews class]]
			 && [self.title isEqual:[object title]]
			 && [self.timestamp isEqual:[object timestamp]]);
}
@end
```
## 3. How to choose and use data structures
- Plan for scale when appropriate
- All data structures have tradeoffs
- A bad fit hurts performance
	- The wrong tool
	- The wrong approach

- Immutable vs Mutable
	- Immutable provides
		- Thread Safety
		- Memory  and Speed Optimization
- `NSArray` / `NSMutableArray`
	- Ordered, indexed, allows duplicates
	- Fast operations
		- Indexed access (e.g. `-objectAtIndex:`, `-firstObject`, `-lastObject`)
		- Add / remove at either end (e.g. `-addObject:`, `-removeLastObject:`)
	- Slower operations
		- Search (e.g. `-containsObject:`, `-indexOfObject:`, `-removeObject:`)
		- Add / remove, arbitrary index (e.g. `-insertObject:atIndex:`)
	- Specialty operations
		- Binary search (requires a sorted range of an array)
		- `-indexOfObject:inSortedRange:options:usingComparator:`
- `NSSet` / `NSMutableSet`
	- Unordered, no duplicates, hash lookup
	- Add, remove, and search are fast
		- (e.g. `-addObject:`, `-removeObject:`, `-containsObject:`)
	- Specialty operations
		- Set math: test overlap (e.g. `-intersectsSet:`, `-isSubsetOfSet:`)
		- Set math: modify (e.g. `-intersectSet:`, `-minusSet:`, `-unionSet:`)
	- Caveats
		- Converting array to set loses ordering and duplicates
		- Cannot be stored in a property list or JSON
- `NSCountedSet`
	- Unordered, no duplicates, hash lookup
	- Subclass of `NSMutableSet`, same operations and caveats
	- Tracks net insertion count for each object
		- Incremented on insert, decremented on remove
		- `-countForObject:` returns individual count
		- `-count` still returns number of objects, not sum of insertions
- `NSDictionary` / `NSMutableDictionary`
	- Unordered, key-value entries, unique keys, hash lookup
	- Add, remove, and search are fast
		- (e.g. `-objectForKey:`, `-setObject:forKey:`, `-removeObjectForKey:`)
	- Specialty operations
		- Property list file I/O
		- `+sharedKeySetForKeys:`, `+dictionaryWithSharedKeySet:` (10.8, iOS 6)
	- Caveats
		- Keys must conform to `NSCopying` (“copy in”)
		- NEVER mutate an object that is a dictionary key
- `NSOrderedSet` / `NSMutableOrderedSet`
	- Ordered, no duplicates, index / hash lookup (10.7, iOS 5)
	- Effectively a cross of `NSArray` and `NSSet`
		- Not a subclass of either one
		- Call `-array` or `-set` for immutable, live-updating representations
	- Caveats
		- Increased memory usage
		- Property list support requires conversions
- `NSIndexSet` / `NSMutableIndexSet`
	- Collection of unique `NSUInteger` values
	- Reference a subset of objects in `NSArray`
		- Avoid memory overhead of array copies
	- Efficient storage and coalescing
	- Set arithmetic (intersect, subset, difference)
	- Caveats
		- Use caution with indexes for mutable arrays
- `NSMapTable` / `NSHashTable`
	- Similar to `NSMutableDictionary` / `NSMutableSet`
	- More flexibility via `NSMapTableOptions` / `NSHashTableOptions`
		- May use pointer identity for equality and hashing
		- May contain any pointer (not just objects)
		- Optional weak references to keys and/or values (zeroing under ARC)
		- Optional copy on insert
	- Caveats
		- Can’t convert non-object contents to dictionary/set
		- Beware of premature optimization!
- `NSCache`
	- Similar to `NSMutableDictionary`
	- Thread-safe
	- Doesn’t copy keys
	- Auto-removal under memory pressure
	- Ideal for objects that can be regenerated on demand

## 4. How to design your code for performance

## Summary
- Complexity kills large-scale performance
- Know how much work your code does
- Avoid redundancy, strive for efficiency
- Focus on biggest performance wins
- Profile and analyze, don’t assume
- Prefer built-in collections and API
- Design according to your needs
- Think about performance early