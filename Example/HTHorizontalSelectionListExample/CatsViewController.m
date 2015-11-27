//
//  CatsViewController.m
//  HTHorizontalSelectionList Example
//
//  Created by Erik Ackermann on 2/5/15.
//  Copyright (c) 2015 Hightower. All rights reserved.
//

#import "CatsViewController.h"
#import "HTHorizontalSelectionList.h"

@interface CatsViewController () <HTHorizontalSelectionListDelegate, HTHorizontalSelectionListDataSource>

@property (nonatomic, strong) HTHorizontalSelectionList *customViewSelectionList;
@property (nonatomic, strong) NSArray *spaceCats;

@property (nonatomic, strong) UIView *selectedSpaceCatView;

@property (nonatomic) BOOL filtered;

@end

@implementation CatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Cats";
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.customViewSelectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    self.customViewSelectionList.delegate = self;
    self.customViewSelectionList.dataSource = self;

    self.customViewSelectionList.selectionIndicatorStyle = HTHorizontalSelectionIndicatorStyleButtonBorder;
    self.customViewSelectionList.selectionIndicatorColor = [UIColor redColor];
    self.customViewSelectionList.bottomTrimHidden = YES;
    self.customViewSelectionList.showsEdgeFadeEffect = YES;

    self.customViewSelectionList.buttonInsets = UIEdgeInsetsMake(15, 10, 15, 10);

    self.spaceCats = @[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spacecat1.jpeg"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spacecat2.jpeg"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spacecat3.jpeg"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spacecat4.jpeg"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spacecat5.jpeg"]]];

    [self.view addSubview:self.customViewSelectionList];

    self.selectedSpaceCatView = [[UIView alloc] init];
    UIImage *selectedImage = ((UIImageView *)self.spaceCats[self.customViewSelectionList.selectedButtonIndex]).image;
    self.selectedSpaceCatView.backgroundColor = [UIColor colorWithPatternImage:selectedImage];
    self.selectedSpaceCatView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.selectedSpaceCatView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_selectedSpaceCatView]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_selectedSpaceCatView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_customViewSelectionList][_selectedSpaceCatView]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_customViewSelectionList, _selectedSpaceCatView)]];

    UIButton *filterToggleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    filterToggleButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [filterToggleButton setTitle:@"Filter Selection List" forState:UIControlStateNormal];
    
    filterToggleButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    filterToggleButton.backgroundColor = [UIColor whiteColor];
    filterToggleButton.layer.cornerRadius = 3.0;
    
    [filterToggleButton addTarget:self
                           action:@selector(filterToggleButtonTapped:)
                 forControlEvents:UIControlEventTouchUpInside];

    filterToggleButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:filterToggleButton];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:filterToggleButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:filterToggleButton
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-20.0]];
}

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.spaceCats.count;
}

- (UIView *)selectionList:(HTHorizontalSelectionList *)selectionList viewForItemWithIndex:(NSInteger)index {
    return self.spaceCats[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    // update the view for the corresponding index
    UIImage *selectedImage = ((UIImageView *)self.spaceCats[index]).image;
    self.selectedSpaceCatView.backgroundColor = [UIColor colorWithPatternImage:selectedImage];
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

#pragma mark - Action Handlers

- (void)filterToggleButtonTapped:(id)sender {
    self.filtered = !self.filtered;
    ((UIButton *)sender).selected = !((UIButton *)sender).selected;

    [self.customViewSelectionList reloadData];

    // NOTE: After changing the selection list data source and reloading,
    // it is up to the data source to reselect the correct button
    // (or do what is happening here: deselect everything by setting
    // |selectedButtonIndex| to -1)
    self.customViewSelectionList.selectedButtonIndex = -1;
}

#pragma mark - Custom Getters and Setters

- (NSArray *)spaceCats {
    if (self.filtered) {
        return [_spaceCats subarrayWithRange:NSMakeRange(_spaceCats.count/2, _spaceCats.count/2)];
    }

    return _spaceCats;
}

@end
