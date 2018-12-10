//
//  TstingCustomView.h
//  Tsting-SetNeedsLayout
//
//  Created by 隋老大 on 2018/12/6.
//  Copyright © 2018 dasui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MarlServiceChatingFinishConversationViewType) {
    MarlServiceChatingFinishConversationViewTypeFinish,
    MarlServiceChatingFinishConversationViewTypeInputPhone,
};

@interface TstingCustomView : UIView

/** input textfield */
@property (nonatomic, strong, readonly) UITextField *phoneTextField;

/** DataSource */
@property (nonatomic, strong) id dataSource;
/** positon y changed handler */
@property (nonatomic, copy) void (^positionYChangedHandler)(NSNotification *notify, BOOL isShowing);

- (instancetype)initWithFrame:(CGRect)frame
                         type:(MarlServiceChatingFinishConversationViewType)type;



@end

NS_ASSUME_NONNULL_END
