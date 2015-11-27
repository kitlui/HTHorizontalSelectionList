//
//  ViewController.m
//  HTHorizontalSelectionList Example
//
//  Created by Erik Ackermann on 9/14/14.
//  Copyright (c) 2014 Hightower. All rights reserved.
//

#import "CarsViewController.h"
#import "HTHorizontalSelectionList.h"

@interface CarsViewController () <HTHorizontalSelectionListDelegate, HTHorizontalSelectionListDataSource>

@property (nonatomic, strong) HTHorizontalSelectionList *textSelectionList;
@property (nonatomic, strong) NSArray *carMakes;

@property (nonatomic, strong) UILabel *selectedCarLabel;

@end

@implementation CarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Cars";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.textSelectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    self.textSelectionList.delegate = self;
    self.textSelectionList.dataSource = self;
    
    self.textSelectionList.selectionIndicatorAnimationMode = HTHorizontalSelectionIndicatorAnimationModeLightBounce;
    self.textSelectionList.showsEdgeFadeEffect = YES;

    self.textSelectionList.selectionIndicatorColor = [UIColor redColor];
    [self.textSelectionList setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.textSelectionList setTitleFont:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
    [self.textSelectionList setTitleFont:[UIFont boldSystemFontOfSize:13] forState:UIControlStateSelected];
    [self.textSelectionList setTitleFont:[UIFont boldSystemFontOfSize:13] forState:UIControlStateHighlighted];

    self.carMakes = @[@"All cars",
                      @"Audi",
                      @"Bitter",
                      @"BMW",
                      @"Büssing",
                      @"Gumpert",
                      @"MAN",
                      @"Mercedes-Benz",
                      @"Multicar",
                      @"Neoplan",
                      @"NSU",
                      @"Opel",
                      @"Porsche",
                      @"Robur",
                      @"Volkswagen",
                      @"Wiesmann"];
    
    [self.view addSubview:self.textSelectionList];

    self.selectedCarLabel = [[UILabel alloc] init];
    self.selectedCarLabel.text = self.carMakes[self.textSelectionList.selectedButtonIndex];
    self.selectedCarLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.selectedCarLabel];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedCarLabel
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                          constant:0.0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedCarLabel
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0
                                                          constant:0.0]];

    self.textSelectionList.snapToCenter = YES;
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    HTHorizontalState state = [self.textSelectionList getHorizontalState];
    if (state == HTHorizontalStateHead) {
        NSLog(@"head");
    } else if (state == HTHorizontalStateTale) {
        NSLog(@"tale");
    } else {
        NSLog(@"mid");
    }
}

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.carMakes.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.carMakes[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    // update the view for the corresponding index
    self.selectedCarLabel.text = self.carMakes[index];
}

- (void)selectionList:(HTHorizontalSelectionList *)selectionList scrollState:(HTHorizontalState)state {
    if (state == HTHorizontalStateHead) {
        NSLog(@"head");
    } else if (state == HTHorizontalStateTale) {
        NSLog(@"tale");
    } else {
        NSLog(@"mid");
    }
}

@end
