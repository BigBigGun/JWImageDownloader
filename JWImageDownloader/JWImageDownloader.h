//
//  ImageDownloader.h
//  UI_lesson17_ImageDownLoader
//
//  Created by lanou on 15/10/14.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//  UIImage是UIKit框架下得类,如果要使用需要导入对应的头文件

@interface ImageDownloader : NSObject 

//  block作为参数的写法
+ (void)downloadImageWithURL:(NSString *)URLStr completionHandler:(void (^)(UIImage *))imageBlock;


//  图片渐渐演示
- (void) image:(UIImageView *)imageView AppearStepByStepWithURL:(NSString *)URLStr;

@end
