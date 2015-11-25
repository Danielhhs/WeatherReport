//
//  OBSpringyCollectionViewLayout.m
//  ourBills
//
//  Created by Huang Hongsen on 2/25/15.
//  Copyright (c) 2015 ourBills. All rights reserved.
//

#import "OBSpringyCollectionViewLayout.h"
@interface OBSpringyCollectionViewLayout()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) NSMutableSet *visibleIndices;
@property (nonatomic) CGFloat latestDelta;
@end

@implementation OBSpringyCollectionViewLayout

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        self.animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        self.visibleIndices = [NSMutableSet set];
        self.shouldAnimateScroll = YES;
    }
    return self;
}

- (void) prepareLayout
{
    [super prepareLayout];
    
    CGRect visibleRect = CGRectInset(CGRectMake(self.collectionView.bounds.origin.x, self.collectionView.bounds.origin.y, self.collectionView.frame.size.width, self.collectionView.frame.size.height), -100, -100);
    NSArray *itemsInVisibleRect = [super layoutAttributesForElementsInRect:visibleRect];
    
    NSSet *indexPathForItemsInVisibleRect = [NSSet setWithArray:[itemsInVisibleRect valueForKey:@"indexPath"]];
    
    NSArray *noLongerVisibleBehaviors = [self.animator.behaviors filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIAttachmentBehavior *behavior, NSDictionary *bindings) {
        BOOL currentlyVisible = [indexPathForItemsInVisibleRect member:[(UICollectionViewLayoutAttributes *)[[behavior items] firstObject] indexPath]] != nil;
        return !currentlyVisible;
    }]];
    
    [noLongerVisibleBehaviors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.animator removeBehavior:obj];
        [self.visibleIndices removeObject:[(UICollectionViewLayoutAttributes *)[[obj items] firstObject] indexPath]];
    }];
    
    NSArray *newlyVisibleItems = [itemsInVisibleRect filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *item, NSDictionary *bindings) {
        BOOL currentlyVisible = [self.visibleIndices member:item.indexPath] != nil;
        return !currentlyVisible;
    }]];
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    [newlyVisibleItems enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *item, NSUInteger idx, BOOL *stop) {
        CGPoint center = item.center;
        UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:center];
        springBehavior.length = 0.f;
        springBehavior.damping = 0.9f;
        springBehavior.frequency = 0.8f;
        
        if (!CGPointEqualToPoint(CGPointZero, touchLocation)) {
            CGFloat yDistanceFromTouch = fabs(touchLocation.y - springBehavior.anchorPoint.y);
            CGFloat scrollResistence = yDistanceFromTouch / 1500.f;
            
            if (self.latestDelta < 0) {
                center.y += MAX(self.latestDelta, self.latestDelta * scrollResistence);
            } else {
                center.y += MIN(self.latestDelta, self.latestDelta * scrollResistence);
            }
            item.center = center;
        }
        
        [self.animator addBehavior:springBehavior];
        [self.visibleIndices addObject:item.indexPath];
    }];
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.animator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.animator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    if (self.shouldAnimateScroll) {
        UIScrollView *scrollView = self.collectionView;
        CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
        self.latestDelta = delta;
        
        CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
        [self.animator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehavior, NSUInteger idx, BOOL *stop) {
            CGFloat yDistanceFromTouch = fabs(touchLocation.y - springBehavior.anchorPoint.y);
            CGFloat scrollResistence = yDistanceFromTouch / 1500.f;
            
            UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes *)[springBehavior.items firstObject];
            CGPoint center = item.center;
            if (delta < 0) {
                center.y += MAX(delta, delta * scrollResistence);
            } else {
                center.y += MIN(delta, delta * scrollResistence);
            }
            item.center = center;
            [self.animator updateItemUsingCurrentState:item];
        }];
    }
    return NO;
}

@end
