//
//  KBCScrollView.h
//  KBCScrollView
//
//  Created by Konstantin Blokhin on 02.07.16.
//  Copyright © 2016 kostyabl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KBCScrollViewDelegate <NSObject>

@optional
-(void)currentPageDidChage:(NSUInteger)pageNumber;
-(void)didTappedToView:(UIView*)view onPage:(NSUInteger)pageNumber;
@end


@interface KBCScrollView : UIScrollView<UIScrollViewDelegate>

//Views array
@property (strong, nonatomic) NSMutableArray<UIView*>* views;
@property (weak, nonatomic) id<KBCScrollViewDelegate> kbcScrollViewdelegate;

-(void) scrollToPage:(NSUInteger)page;

@end
