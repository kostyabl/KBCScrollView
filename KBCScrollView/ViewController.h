//
//  ViewController.h
//  KBCScrollView
//
//  Created by Konstantin Blokhin on 02.07.16.
//  Copyright © 2016 kostyabl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBCScrollView.h"

@interface ViewController : UIViewController<KBCScrollViewDelegate>

//Outlets
@property (weak, nonatomic) IBOutlet KBCScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *setPaggingEnableButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControlView;

//Actions
- (IBAction)scrollToFrameButtonTouched:(id)sender;
- (IBAction)setPagingEnableButtonTouched:(id)sender;
- (IBAction)reloadDataButtonTouched:(id)sender;

@end

