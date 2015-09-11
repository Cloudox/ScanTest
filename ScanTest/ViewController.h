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
@property (strong, nonatomic) AVCaptureSession *session;//输入输出的中间桥梁
@property (strong, nonatomic) IBOutlet UILabel *scanResult;// 输出扫码结果
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *layer;// 扫描所在的层级
@property (nonatomic, retain) UIImageView *rectImage;// 扫描的方框
@property (strong, nonatomic) UILabel *explainLabel;// 说明文本
@property (nonatomic, retain) UIImageView *line;// 扫码区域的线条

// 用于扫码的线条动画
@property int num;
@property BOOL upOrdown;
@property NSTimer * timer;

- (IBAction)scan:(id)sender;
@end

