//
//  ViewController.h
//  ScanTest
//
//  Created by csdc-iMac on 15/9/11.
//  Copyright (c) 2015年 csdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) AVCaptureSession * session;//输入输出的中间桥梁
@property (strong, nonatomic) IBOutlet UILabel *scanResult;

- (IBAction)scan:(id)sender;
@end

