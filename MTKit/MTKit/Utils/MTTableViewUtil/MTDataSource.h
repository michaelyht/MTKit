//
//  MTDataSource.h
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^MTConfigureCellBlock)(id cell, id model, NSIndexPath * indexPath);

@interface MTDataSource : NSObject

/**
 初始化数据源
 
 @param CellID CellID
 @param dataSource 数据源数组
 @param configureCellBlock 代理回调
 @return 返回数据源
 */
- (id)initWithCellIdentifier:(NSString *)CellID
                  dataSource:(NSArray *)dataSource
          configureCellBlock:(MTConfigureCellBlock)configureCellBlock;


/**
 设置新的数据源
 
 @param dataSource 数据源
 */
- (void)setNewDataSource:(NSArray *)dataSource;

/**
 添加数据源,用于分页
 
 @param dataSource 添加进来的数组
 */
- (void)addDataSource:(NSArray *)dataSource;


/**
 获取某一行cell的对象
 
 @param indexPath indexpath
 @return 对象
 */
- (id)dataAtIndexPath:(NSIndexPath *)indexPath;


@end
