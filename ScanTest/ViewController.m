//
//  ViewController.m
//  ScanTest
//
//  Created by csdc-iMac on 15/9/11.
//  Copyright (c) 2015年 csdc. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)scan:(id)sender {
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    self.session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [self.session addInput:input];
    [self.session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    self.layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    self.layer.frame=self.view.layer.bounds;
//    [self.view.layer insertSublayer:self.layer atIndex:2];// 设置层级，可以在扫码时显示一些文字
    [self.view.layer addSublayer:self.layer];
    //开始捕获
    [self.session startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        //[session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        NSLog(@"%@",metadataObject.stringValue);
        self.scanResult.text = metadataObject.stringValue;
        [self.session stopRunning];
        [self.layer removeFromSuperlayer];
        
        /*
        NSString *url = [NSString stringWithFormat:@"http://api.douban.com/book/subject/isbn/%@?alt=json", metadataObject.stringValue];
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        NSData *response = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
        NSString *str = [[NSString alloc] initWithBytes:[response bytes] length:[response length] encoding:NSUTF8StringEncoding];
        //    NSLog(@"%@", str);
        NSData *responseUTF = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *infoDic = [NSJSONSerialization JSONObjectWithData:responseUTF options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"error: %@", [error description]);
            return;
        }
        NSLog(@"%@", infoDic);
        */
    }
}


@end
