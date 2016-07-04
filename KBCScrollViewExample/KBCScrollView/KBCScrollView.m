//
//  KBCScrollView.m
//  KBCScrollView
//
//  Created by Konstantin Blokhin on 02.07.16.
//  Copyright © 2016 kostyabl. All rights reserved.
//

#import "KBCScrollView.h"

@implementation KBCScrollView {
    BOOL firstLayout;
    CGFloat visibleX;
    NSUInteger currentPage;
    NSInteger maxPageMinusOne;
    BOOL isForward;
    
}

#pragma mark - UIView methods
-(void) willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self setShowsHorizontalScrollIndicator:NO];
    self.delegate = self;
    
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    [self addGestureRecognizer:tapRecognizer];
    
    [self setPagingEnabled:YES];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    if (firstLayout) {
        [self initSubViews];
        firstLayout = NO;
    }
}

#pragma mark - Init methods
-(void) scrollInit{
    firstLayout = YES;
    visibleX = 0;
    currentPage = 0;
    maxPageMinusOne = [self.views count]-1;
    [self setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
}

-(void) initSubViews {
    NSUInteger i=0;
    for (UIView* view in self.views) {
        //Align view to center
        CGFloat xView = ((self.frame.size.width - view.frame.size.width)/2) + (self.frame.size.width*i);
        CGFloat yView = (self.frame.size.height - view.frame.size.height)/2;
        [view setFrame:CGRectMake(xView, yView, view.frame.size.width, view.frame.size.height)];
        [self addSubview:view];
        i++;
    }
    [self setContentSize:CGSizeMake(self.frame.size.width*i, self.frame.size.height)];
}

#pragma mark - Computing methods
-(CGRect) calculateScrollPositionAfterDecelerating {
    CGFloat scrollViewWidth = self.frame.size.width;
    NSUInteger i=0;
    NSUInteger j=0;
    for (i=0; i<[self.views count]; i++) {
        j = i+1;
        if (self.contentOffset.x>=scrollViewWidth*i && self.contentOffset.x<=scrollViewWidth*j) {
            break;
        }
    }
    if (isForward) { i++; }
    currentPage = i;
    return CGRectMake(scrollViewWidth*i, 0, scrollViewWidth, self.frame.size.height);
    
}

-(CGRect) calculateScrollPosition {
    CGFloat scrollViewWidth = self.frame.size.width;
    if (self.contentOffset.x>visibleX) {
        if (currentPage<maxPageMinusOne) {
            currentPage++;
        }
    } else {
        if (currentPage>0) {
            currentPage--;
        }
    }
    return CGRectMake(scrollViewWidth*currentPage, 0, scrollViewWidth, self.frame.size.height);
}

-(CGRect) calculateScrollPositionWithPage:(NSUInteger)page {
    CGFloat scrollViewWidth = self.frame.size.width;
    currentPage = page;
    return CGRectMake(scrollViewWidth*page, 0, scrollViewWidth, self.frame.size.height);
}

-(void) setCurrentPageByScrollPosition {
    CGFloat pageFloat =self.bounds.origin.x/self.frame.size.width;
    currentPage = (NSInteger)pageFloat;
}


#pragma mark - Main methods
-(void) tapDetected {
    if ([self.kbcScrollViewdelegate respondsToSelector:@selector(didTappedToView:onPage:)]) {
        [self.kbcScrollViewdelegate didTappedToView:[self.views objectAtIndex:currentPage] onPage:currentPage];
    }
}

-(void) tellToDelegatePageChanged:(NSUInteger)page {
    if ([self.kbcScrollViewdelegate respondsToSelector:@selector(currentPageDidChage:)]) {
        [self.kbcScrollViewdelegate currentPageDidChage:page];
    }
}

-(void) scrollToPage:(NSUInteger)page {
    if (page>0 && page<=maxPageMinusOne) {
        [self scrollRectToVisible:[self calculateScrollPositionWithPage:page] animated:YES];
    }
}

-(void) setViews:(NSMutableArray<UIView *> *)views {
    [_views removeAllObjects];
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self scrollInit];
    _views = views;
}


#pragma mark - UIScrollView delegate methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    visibleX = self.bounds.origin.x;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.contentOffset.x>visibleX) {
        isForward = YES;
    } else {
        isForward = NO;
    }
    if (!decelerate) {
        if (!self.isPagingEnabled) {
            [self scrollRectToVisible:[self calculateScrollPosition] animated:YES];
        }
    }
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!self.isPagingEnabled) {
        CGRect scrollRect =[self calculateScrollPositionAfterDecelerating];
        [self scrollRectToVisible:scrollRect animated:YES];
        [self tellToDelegatePageChanged:currentPage];
        
    } else {
        [self setCurrentPageByScrollPosition];
        [self tellToDelegatePageChanged:currentPage];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self tellToDelegatePageChanged:currentPage];
}

@end
