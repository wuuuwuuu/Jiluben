//
//  JLAddDetailDataViewController.h
//  Jiluben
//
//  Created by Yue Wu on 4/12/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JLAddDetailDataViewControllerDelegate <NSObject>

- (void)cellDidaddData:(NSString *)data toRow:(NSInteger)row;

@end

@interface JLAddDetailDataViewController : UIViewController

@property (nonatomic) NSInteger indexPathRow;
@property (nonatomic, strong) NSString *dataTitle;
@property (nonatomic, weak) id <JLAddDetailDataViewControllerDelegate> delegate;

@end
