//
//  JLColumnTypeViewController.h
//  Jiluben
//
//  Created by Yue on 4/2/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JLColumnTypeViewControllerDelegate <NSObject>

- (void)cellDidTapOnType:(NSString *)type;

@end


@interface JLColumnTypeViewController : UIViewController

@property (nonatomic, weak) id <JLColumnTypeViewControllerDelegate> delegate;

@end
