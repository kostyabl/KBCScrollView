//
//  ViewController.m
//  KBCScrollView
//
//  Created by Konstantin Blokhin on 02.07.16.
//  Copyright © 2016 kostyabl. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+UIColorCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Scroll init
    self.scrollView.kbcScrollViewdelegate = self;
    self.scrollView.views = [self generateRandomViews];
    [self initPageControl];
    [self.scrollView setPagingEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)scrollToFrameButtonTouched:(id)sender {
    [self.scrollView scrollToPage:5];
}

- (IBAction)setPagingEnableButtonTouched:(id)sender {
    if (self.scrollView.isPagingEnabled == YES) {
        [self.scrollView setPagingEnabled:NO];
        [self.setPaggingEnableButton setTitle:@"Set pagging enable" forState:UIControlStateNormal];
    } else {
        [self.scrollView setPagingEnabled:YES];
        [self.setPaggingEnableButton setTitle:@"Set pagging disable" forState:UIControlStateNormal];
    }
}

- (IBAction)reloadDataButtonTouched:(id)sender {
    self.scrollView.views = [self generateRandomViews];
    [self initPageControl];
}

#pragma mark - Misc methods
//Generate Views Arr
- (NSMutableArray*) generateRandomViews {
    NSMutableArray* viewsArr = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<10; i++) {
        CGFloat rand = arc4random_uniform(90)+10;
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rand, rand)];
        view.backgroundColor = [UIColor randomColor];
        [viewsArr addObject:view];
    }
    return viewsArr;
}

//Init UIPageControl
-(void) initPageControl {
    [self.pageControlView setNumberOfPages:[self.scrollView.views count]];
    [self.pageControlView setCurrentPage:0];
}

#pragma mark - KBCScrollView delegate methods
-(void)currentPageDidChage:(NSUInteger)pageNumber {
    [self.pageControlView setCurrentPage:pageNumber];
}

-(void)didTappedToView:(UIView*)view onPage:(NSUInteger)pageNumber {
    //UIView tapped, show alert
    NSString* message = [NSString stringWithFormat:@"View page is: %i",pageNumber];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"View tapped" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:alertAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
