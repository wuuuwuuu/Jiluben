//
//  JLAddColumnViewController.h
//  Jiluben
//
//  Created by Yue on 4/2/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JLAddColumnViewControllerDelegate <NSObject>

- (void)didAddColumnTitle:(NSString *)title withType:(NSString *)type;

@end

@interface JLAddColumnViewController : UIViewController

@property (nonatomic, weak) id <JLAddColumnViewControllerDelegate> delegate;

@end
