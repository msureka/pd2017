//
//  ContactModel.h
//  LCNContactPicker
//
//  Created by 黄春涛 on 15/12/31.
//  Copyright © 2015年 黄春涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCNContactModel : NSObject

@property (nonatomic, strong) NSString *contactName;//ContactView显示的文字
@property (nonatomic, strong) id contact;//与ContactView绑定的数据源

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com