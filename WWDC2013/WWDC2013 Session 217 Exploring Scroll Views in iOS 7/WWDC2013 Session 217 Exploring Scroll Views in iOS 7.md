# WWDC 2013 Session 217 Exploring Scroll Views in iOS 7

## Nested Scroll Views

At first, the session presents how to make nested scroll views working together by using a `UICollectionView` in `UIScrollView`, while each `UICollectionViewCell` has a `UIScrollView` as the subview.
Meanwhile, the `UICollectionView` is the subclass of `UIScrollView`.

```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     determine delta beyond catch point
     adjust parent contentOffset by delta
     translate child by delta
}
```
Key points in this part:
- When subview scroll, using a delegate call to scroll parent scrollview(set contentOffset).
- When subview scroll, avoiding double scroll by transforming itself, transform itself back when scroll ends.
- When `scrollViewWillEndDragging`, adjust scrollview contentOffset change ratio between sub-scrollview and parent-scrollview.

The demo code has been published in the [1st release](https://github.com/antonio081014/Demo2013/releases/tag/V1.0)

## Scrolling with UIKit Dynamics

In the second part, the session presents how to add special animation effect in the `UICollectionView` by customizing `UICollectionFlowLayout` with adding `UIDynamicBehavior` to `UICollectionViewLayoutAttributes`.

- Subclass UICollectionViewFlowLayout
- Create UIDynamicAnimator
- Create UIAttachmentBehavior for each item 
- Stretch the attachments when scrolling

```
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
     CGFloat delta = newBounds.origin.y - self.collectionView.bounds.origin.y
     shift layout attribute positions by delta
     notify UIDynamicAnimator
}
```
The demo code has been published in the [2nd release](https://github.com/antonio081014/Demo2013/releases/tag/V2.0)

Hope someone could help me make a gif file and add it here for the better demo purpose.