//
//  ImageDownloader.m
//  UI_lesson17_ImageDownLoader
//
//  Created by lanou on 15/10/14.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "JWImageDownloader.h"

@interface ImageDownloader () <NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate>

//  接受图片数据
@property (nonatomic, strong) NSMutableData *data;

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation ImageDownloader


+ (void)downloadImageWithURL:(NSString *)URLStr completionHandler:(void (^)(UIImage *))imageBlock
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    //  利用参数中的网址,创建一个URL对象
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:URLStr] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //  将下载好德数据转成对应的图片
        UIImage *image = [UIImage imageWithData:data];
        
        //  回到主线程,将image作为block的参数传递出去
        dispatch_async(dispatch_get_main_queue(), ^{
            imageBlock(image);
        });
        
    }];
    [dataTask resume];
}


//  图片渐渐显示
- (void) image:(UIImageView *)imageView AppearStepByStepWithURL:(NSString *)URLStr
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    [[session dataTaskWithURL:[NSURL URLWithString:URLStr]] resume];
    self.imageView = imageView;
}


//  图片下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    
    NSData *data = [NSData dataWithContentsOfURL:location];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = [UIImage imageWithData:data];
    });
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [self.data appendData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = [UIImage imageWithData:self.data];
    });
}

- (NSMutableData *)data
{
    if (!_data) {
        self.data = [NSMutableData data];
    }
    return _data;
}


@end
