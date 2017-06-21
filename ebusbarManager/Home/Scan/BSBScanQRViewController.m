//
//  BSBScanQRViewController.m
//  ebusbarManager
//
//  Created by 刘必红 on 2017/5/25.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "BSBScanQRViewController.h"
#import <AVFoundation/AVFoundation.h>

#define CROP_WIDTH ([UIScreen mainScreen].bounds.size.width-80)

typedef NS_ENUM(NSInteger, overlayState)
{
    overlayStateReady,
    overlayStateScanning,
    overlayStateEnd
};

@interface BSBScanQRViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    UIView *overlayView;
    
}
@property ( strong , nonatomic ) AVCaptureDevice * device;

@property ( strong , nonatomic ) AVCaptureDeviceInput * input;

@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;

@property ( strong , nonatomic ) AVCaptureSession * session;

@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * preview;

@property ( strong , nonatomic) NSString *result;
@end

@implementation BSBScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_type == 1) {
        self.navigationItem.title = @"租车确认";
    }else{
        self.navigationItem.title = @"还车确认";
    }
    
    self.view.backgroundColor = [UIColor blackColor];
    //权限判断
//    WS(weakSelf)
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        [MBProgressHUD showError:@"请开启相机权限"];
        return;
    }
    
    [self initOverlayView:overlayStateReady];
    //初始化二维码扫描
    [self initScanQRcode];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        [MBProgressHUD showError:@"请开启相机权限"];
        return;
    }
    [self initOverlayView:overlayStateReady];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self initOverlayView:overlayStateScanning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [_session stopRunning];
    [self initOverlayView:overlayStateReady];
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        self.view.backgroundColor = [UIColor blackColor];
    }
    //    [overlayView removeFromSuperview];
    //    overlayView = [self overlayView:];
    //    [self.view addSubview:overlayView];
}

#pragma mark - ---------------初始化二维码扫描--------------
- (void)initScanQRcode
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    // Output
    _output = [self output];
    // Session
    _session = [self session];
    // Preview
    _preview = [self previewLayer];
    
}

- (AVCaptureMetadataOutput *)output
{
    if (_output == nil) {
        //初始化输出设备
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //设置扫描区域
        //参照的是横屏左上角的比例，而不是竖屏
        [_output setRectOfInterest:CGRectMake (((( ScreenHeight-CROP_WIDTH)/2)-NavBarHeight)/ScreenHeight ,(( ScreenWidth - CROP_WIDTH)/ 2)/ScreenWidth , CROP_WIDTH /ScreenHeight , CROP_WIDTH /ScreenWidth)];
    }
    return _output;
}

- (AVCaptureSession *)session
{
    if (_session == nil) {
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPreset1920x1080];
        
        if ([_session canAddInput:self.input])
        {
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output])
        {
            [_session addOutput : self.output ];
            //                    NSArray *typeList = self.output.availableMetadataObjectTypes;
            // 条码类型 AVMetadataObjectTypeQRCode
            _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        }
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer
{
    if (_preview == nil) {
        //负责图像渲染出来
        _preview =[ AVCaptureVideoPreviewLayer layerWithSession:_session];
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _preview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self.view.layer insertSublayer:_preview atIndex:0];
        
    }
    return _preview;
}

- (void)initOverlayView:(overlayState)state
{
    if (state == overlayStateScanning) {
        [_session startRunning];
    }
    [overlayView removeFromSuperview];
    overlayView = [self overlayView:state];
    [self.view addSubview:overlayView];
    
}

- (UIView *)overlayView:(overlayState)state
{
    switch (state) {
        case overlayStateScanning:
        {
            CGSize size = CGSizeMake(ScreenWidth, ScreenHeight);
            UIGraphicsBeginImageContext(size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetRGBFillColor(context, 0, 0, 0, state==overlayStateScanning?0.3:0.9);
            CGContextFillRect(context, CGRectMake(0, -7, ScreenWidth, ScreenHeight-0));
            
            CGFloat   bottomHeight = (ScreenHeight-CROP_WIDTH)/2-NavBarHeight;
            CGFloat   leftWidth = ((( ScreenHeight-CROP_WIDTH)/2)-NavBarHeight) /ScreenHeight;
            CGFloat   originY = (ScreenHeight+CROP_WIDTH)/2-NavBarHeight;
            CGFloat   originX = (ScreenWidth+CROP_WIDTH)/2;
            
            CGFloat lineWidth = 2;
            UIColor *lineColor = [UIColor whiteColor];
            //扫描框4个脚的设置
            CGContextSetLineWidth(context, lineWidth);
            CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
            //左上角
            CGContextMoveToPoint(context, leftWidth+40, bottomHeight+15);
            CGContextAddLineToPoint(context, leftWidth+40, bottomHeight);
            CGContextAddLineToPoint(context, leftWidth+15+40, bottomHeight);
            CGContextStrokePath(context);
            //右上角
            CGContextMoveToPoint(context, originX-15, bottomHeight);
            CGContextAddLineToPoint(context, originX, bottomHeight);
            CGContextAddLineToPoint(context, originX, bottomHeight+15);
            CGContextStrokePath(context);
            //左下角
            CGContextMoveToPoint(context, leftWidth+40, originY-15);
            CGContextAddLineToPoint(context, leftWidth+40,  originY);
            CGContextAddLineToPoint(context, leftWidth+15+40, originY);
            CGContextStrokePath(context);
            //右下角
            CGContextMoveToPoint(context, originX-15, originY);
            CGContextAddLineToPoint(context,  originX,  originY);
            CGContextAddLineToPoint(context,  originX, originY-15);
            CGContextStrokePath(context);
            
            UIImageView *imageLine = [[UIImageView alloc] init];
            imageLine.frame = CGRectMake(ScreenWidth/2.f-CROP_WIDTH/2, (ScreenHeight-CROP_WIDTH)/2.f-NavBarHeight, CROP_WIDTH, 2);
            imageLine.backgroundColor = [UIColor greenColor];
            imageLine.alpha = 0.8;
            
            CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
            anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(ScreenWidth/2.f, (ScreenHeight-CROP_WIDTH)/2.f-NavBarHeight)];
            anim.toValue = [NSValue valueWithCGPoint:CGPointMake(ScreenWidth/2.f, (ScreenHeight+CROP_WIDTH)/2.f-NavBarHeight)];
            anim.repeatCount = HUGE_VALF;
            anim.autoreverses = YES;
            anim.duration = 1.5;
            [imageLine.layer addAnimation:anim forKey:nil];
            
            CGContextClearRect(context, CGRectMake(ScreenWidth/2.f-CROP_WIDTH/2.f, (ScreenHeight -CROP_WIDTH)/2.f-NavBarHeight, CROP_WIDTH, CROP_WIDTH));
            UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            imageView.image = img;
            UIGraphicsEndImageContext();
            
            [imageView addSubview:imageLine];
            
            UILabel *textLabel = [[UILabel alloc] init];
            textLabel.frame = CGRectMake(0, (ScreenHeight+CROP_WIDTH)/2.f-NavBarHeight+10, ScreenWidth, 30);
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.font = [UIFont systemFontOfSize:16];
            textLabel.textColor = [UIColor whiteColor];
            
            textLabel.textAlignment = YES;
            [imageView addSubview:textLabel];
            
            return imageView;
        }
            break;
        case overlayStateEnd:
        {
            //            [self.loadIndicator startAnimating];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, ScreenHeight/2.f-20-0, ScreenWidth-100, 80)];
            label.numberOfLines = 5;
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = 501;
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor whiteColor];
            
            UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            imageView.image = img;
            UIGraphicsEndImageContext();
            
            //            [imageView addSubview:self.loadIndicator];
            [imageView addSubview:label];
            
            return imageView;
        }
            break;
        case overlayStateReady:
        {
            //            [self.loadIndicator startAnimating];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, ScreenHeight/2.f-20-0, ScreenWidth-200, 40)];
            label.numberOfLines = 2;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"准备中...";
            label.tag = 501;
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor whiteColor];
            
            UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            imageView.image = img;
            UIGraphicsEndImageContext();
            
            //            [imageView addSubview:self.loadIndicator];
            [imageView addSubview:label];
            
            return imageView;
        }
            break;
        default:
            return nil;
            break;
            
    }
}

- ( void )captureOutput:( AVCaptureOutput *)captureOutput didOutputMetadataObjects:( NSArray *)metadataObjects fromConnection:( AVCaptureConnection *)connection
{
    if ([metadataObjects count ] > 0 )
    {
        // 停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        _result = metadataObject.stringValue ;
    }
    
    [overlayView removeFromSuperview];
    overlayView = [self overlayView:overlayStateEnd];
    [self.view addSubview:overlayView];

    if (_type == 1) {
        NSDictionary *paramsDic = @{@"request_id":_result,
                                    @"admin_id":[BSBSaveUserInfo getUserId],
                                    @"sessionKey":[BSBSaveUserInfo getSessionKey]};
        
        [self sendRequestWithMethod:GET interface:PLInterface_ConfirmOrder urlParams:paramsDic bodyParams:nil];
    }else{
        NSDictionary *paramsDic = @{@"request_id":_result,
                                    @"admin_id":[BSBSaveUserInfo getUserId],
                                    @"place_id":self.place_id,
                                    @"sessionKey":[BSBSaveUserInfo getSessionKey]};
        
         [self sendRequestWithMethod:GET interface:PLInterface_ReturnConfirmOrder urlParams:paramsDic bodyParams:nil];

    }
}

- (void)handleNetWorkResponseSuccess:(NSDictionary *)jsonDic
{
    [super handleNetWorkResponseSuccess:jsonDic];
    
    NSInteger interface = [jsonDic[@"interface"] integerValue];
    NSDictionary *responseDic = jsonDic[@"response"];
    BSBBaseModel *baseModel = [BSBBaseModel yy_modelWithDictionary:responseDic];
    
    switch (interface) {
        case PLInterface_ConfirmOrder:
        {
            if (baseModel.code == 1) {
               [self.navigationController popViewControllerAnimated:YES];
               [MBProgressHUD showSuccess:@"租车成功"];
            }
            
        }
            break;
        case PLInterface_ReturnConfirmOrder:
        {
            if (baseModel.code == 1) {
               [self.navigationController popViewControllerAnimated:YES];
               [MBProgressHUD showSuccess:@"还车成功"];
            }
            
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
