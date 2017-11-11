//
//  ViewController.m
//  DZ 21 - Obj_Skut_Anamation
//
//  Created by mac on 05.11.17.
//  Copyright © 2017 Dima Zgera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView* viewRed;
@property (weak, nonatomic) UIView* viewYellow;
@property (weak, nonatomic) UIView* viewGreen;
@property (weak, nonatomic) UIView* viewBlue;

@property (weak, nonatomic) UIImageView* helicopter;

@property (strong, nonatomic) NSMutableArray* viewArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.viewArray = [[NSMutableArray alloc] init];
    
    CGFloat sizeView = CGRectGetHeight(self.view.bounds) / 9;
    CGFloat x = sizeView;
    CGFloat y = sizeView;
    
    for (NSInteger i = 0; i < 4; i++) {
        UIColor* color = [self randomColor];
        UIView* view = [self createViewWithSize:sizeView coordinateX:x coordinateY:y andColor:color forParentView:self.view];
        [self.viewArray addObject:view];
        y += 2 * sizeView;
    }
    
    self.viewRed = [self createViewWithSize:sizeView
                                coordinateX:0
                                coordinateY:0
                                   andColor:[UIColor redColor]
                              forParentView:self.view];
    
    self.viewGreen = [self createViewWithSize:sizeView
                                coordinateX:CGRectGetWidth(self.view.bounds) - sizeView
                                coordinateY:0
                                   andColor:[UIColor greenColor]
                              forParentView:self.view];
    
    self.viewBlue = [self createViewWithSize:sizeView
                                coordinateX:0
                                coordinateY:CGRectGetHeight(self.view.bounds) - sizeView                                   andColor:[UIColor blueColor]
                              forParentView:self.view];
    
    self.viewYellow = [self createViewWithSize:sizeView
                                coordinateX:CGRectGetWidth(self.view.bounds) - sizeView
                                coordinateY:CGRectGetHeight(self.view.bounds) - sizeView
                                   andColor:[UIColor yellowColor]
                              forParentView:self.view];
    
    UIImage* imageHelicopter1 = [UIImage imageNamed:@"64x64.png"];
    UIImage* imageHelicopter2 = [UIImage imageNamed:@"1.png"];
    UIImage* imageHelicopter3 = [UIImage imageNamed:@"2.png"];
    UIImage* imageHelicopter4 = [UIImage imageNamed:@"3.png"];
    
    NSArray* imageArray = [NSArray arrayWithObjects: imageHelicopter1, imageHelicopter2, imageHelicopter3, imageHelicopter4, nil];
    
    UIImageView* helicopterView = [self createImageWithSize:sizeView coordinateX:0 - sizeView coordinateY:sizeView * 2 andColor:[UIColor clearColor] withImages:imageArray animationDuration:.5f forParentView:self.view];
    
    [self.view sendSubviewToBack: helicopterView];
    [self moveHelicopterView:helicopterView];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    for (UIView* view in self.viewArray) {
        UIViewAnimationOptions option = [self randomAnimationOptionsWithReapeat:YES andAutoreverse:YES];
        [self moveView:view withOption:option];
    }
    
    [self circularMovementView];
}

#pragma mark - Moves Views

- (void) moveHelicopterView: (UIImageView*) helicopterView {
    [UIView animateWithDuration:13
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionRepeat
                     animations:^{
                         helicopterView.center = CGPointMake(CGRectGetWidth(self.view.bounds) + CGRectGetWidth(helicopterView.frame), CGRectGetMidY(helicopterView.frame));
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}



- (void) circularMovementView {
    [UIView animateWithDuration:7
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CGRect tempFrame = self.viewRed.frame;
                         self.viewRed.frame = self.viewGreen.frame;
                         self.viewGreen.frame = self.viewYellow.frame;
                         self.viewYellow.frame = self.viewBlue.frame;
                         self.viewBlue.frame = tempFrame;
                     }
                     completion:^(BOOL finished) {
                         [self circularMovementView];
                         
                     }];
}

-(void) moveView:(UIView*) view withOption:(UIViewAnimationOptions) option {
    [UIView animateWithDuration:5
                          delay:0
                        options:option
                     animations:^{
                         view.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(view.frame) * 1.5, CGRectGetMidY(view.frame));
                         view.backgroundColor = [self randomColor];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - Create Views

- (UIView*) createViewWithSize:(CGFloat) size coordinateX:(CGFloat) xCoord coordinateY: (CGFloat) yCoord andColor:(UIColor*) color forParentView: (UIView*) parentView {
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(xCoord, yCoord, size, size)];
    view.backgroundColor = color;
    [parentView addSubview:view];
    
    return view;
}

- (UITableView*) createImageWithSize:(CGFloat) size coordinateX:(CGFloat) xCoord coordinateY: (CGFloat) yCoord andColor:(UIColor*) color withImages:(NSArray*) imageArray animationDuration:(CGFloat) duration forParentView:(UIView*) parentView {
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xCoord, yCoord, size, size)];
    imageView.backgroundColor = color;
    
    imageView.animationImages = imageArray;
    imageView.animationDuration = duration;
    [imageView startAnimating];
    
    [self.view addSubview:imageView];
    
    return imageView;
    
}

#pragma mark - Random Values

- (UIViewAnimationOptions) randomAnimationOptionsWithReapeat:(BOOL) reapeat andAutoreverse:(BOOL) autoreverse {
    
    NSMutableArray* optionCurveArray = [NSMutableArray arrayWithObjects:
                                        [NSNumber numberWithUnsignedInteger:UIViewAnimationCurveEaseInOut],
                                        [NSNumber numberWithUnsignedInteger:UIViewAnimationCurveEaseIn],
                                        [NSNumber numberWithUnsignedInteger:UIViewAnimationCurveEaseOut],
                                        [NSNumber numberWithUnsignedInteger:UIViewAnimationCurveLinear],
                                        nil];
    
    UIViewAnimationOptions optionCurve = [[optionCurveArray objectAtIndex:(int)arc4random() % 2 + 1] unsignedIntegerValue];
    
    if (reapeat && autoreverse) {
        UIViewAnimationOptions optionAnimation = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | optionCurve;
        return optionAnimation;
    } else if (reapeat) {
        UIViewAnimationOptions optionAnimation = UIViewAnimationOptionRepeat | optionCurve;
        return optionAnimation;
    } else {
        UIViewAnimationOptions optionAnimation = UIViewAnimationOptionAutoreverse | optionCurve;
        return optionAnimation;
    }
    
    return UIViewAnimationCurveEaseInOut;
}


- (UIColor*) randomColor {
    CGFloat red = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat green = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat blue = (CGFloat)(arc4random() % 256) / 255.f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
