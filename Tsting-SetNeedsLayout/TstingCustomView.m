//
//  MarlServiceChatingFinishConversationView.m
//  ECAME
//  Created by dasui on 2018/12/5 3:47 PM.
//  Copyright © 2018 Fordeal. All rights reserved.
//

#import "TstingCustomView.h"
#import "Masonry/Masonry.h"
#import "UIColor+MarKit.h"

typedef NS_ENUM(NSInteger, MarlServiceChatingFinishConversationViewButtonsType) {
    MarlServiceChatingFinishConversationViewButtonsTypeConfirm = 1 << 10,
    MarlServiceChatingFinishConversationViewButtonsTypeCancel = 1 << 11,
};

@interface TstingCustomView ()

/** description */
@property (nonatomic, strong) UILabel *descLabel;

/** buttons containerView */
@property (nonatomic, strong) UIView *buttonsContainerView;
/** confirm */
@property (nonatomic, strong) UIButton *confirmButton;
/** cancel */
@property (nonatomic, strong) UIButton *cancelButton;

/** input view */
@property (nonatomic, strong) UIView *inputContainerView;
/** desc  */
@property (nonatomic, strong) UILabel *phoneDescLabel;
/** input textfield */
@property (nonatomic, strong) UITextField *phoneTextField;
/** confirm */
@property (nonatomic, strong) UIButton *phoneConfirmButton;
/** wrong warning */
@property (nonatomic, strong) UILabel *warningLabel;

/** type */
@property (nonatomic, assign) MarlServiceChatingFinishConversationViewType type;

@end

@implementation TstingCustomView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL result = [super pointInside:point withEvent:event];
    NSLog(@"result: %d", result);
    if (!result) {
        [self.phoneTextField resignFirstResponder];
    }
    return result;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"layout subViews");
    
}


- (instancetype)initWithFrame:(CGRect)frame
                         type:(MarlServiceChatingFinishConversationViewType)type
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.type = type;
        [self setupViews];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

// MARK: -
- (void)setupDefaultConfigration
{
    //监听键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

// MARK: - 移除通知
- (void)dealloc {
    if (self.type == MarlServiceChatingFinishConversationViewTypeInputPhone) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

// MARK: - UI
- (void)setupViews
{
    [self addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(24.f);
        make.leading.equalTo(self).offset(32.f);
        make.trailing.equalTo(self).offset(-32.f);
    }];
    
    if (self.type == MarlServiceChatingFinishConversationViewTypeFinish) {
        [self addButtonsContainerView];
    }
    else if (self.type == MarlServiceChatingFinishConversationViewTypeInputPhone) {
        // 添加监听
        [self setupDefaultConfigration];
        [self addPhoneInputView];
    }else {
        //
    }
}

// MARK: yes or no button
-(void)addButtonsContainerView
{
    //
    [self addSubview:self.buttonsContainerView];
    [self.buttonsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel.mas_bottom).offset(48.f);
        make.leading.equalTo(self).offset(12.f);
        make.trailing.equalTo(self).offset(-12.f);
        make.height.equalTo(@(36.f));
        make.bottom.equalTo(self).offset(-40.f);
    }];
    
    // confirm
    [self.buttonsContainerView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self.buttonsContainerView);
        make.height.equalTo(self.buttonsContainerView);
        make.width.equalTo(self.buttonsContainerView).multipliedBy(0.5).offset(-6.f);
    }];
    
    // cancel
    [self.buttonsContainerView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.equalTo(self.buttonsContainerView);
        make.height.equalTo(self.buttonsContainerView);
        make.width.equalTo(self.buttonsContainerView).multipliedBy(0.5).offset(-6.f);
    }];
    
}

// MARK: add phone input view
- (void)addPhoneInputView
{
    [self addSubview:self.inputContainerView];
    [self.inputContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel.mas_bottom).offset(16.f);
        make.leading.equalTo(self).offset(12.f);
        make.trailing.equalTo(self).offset(-12.f);
        make.bottom.equalTo(self).offset(-40.f);
    }];
    
    //
    [self.inputContainerView addSubview:self.phoneDescLabel];
    [self.phoneDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputContainerView);
        make.leading.equalTo(self.inputContainerView);
    }];
    
    //
    [self.inputContainerView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneDescLabel.mas_bottom).offset(4.f);
        make.leading.equalTo(self.inputContainerView);
        make.height.equalTo(@(36.f));
    }];
    
    //
    [self.inputContainerView addSubview:self.phoneConfirmButton];
    [self.phoneConfirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField);
        make.leading.equalTo(self.phoneTextField.mas_trailing).offset(8.f);
        make.trailing.equalTo(self.inputContainerView);
        make.width.equalTo(@(83.f));
        make.height.equalTo(self.phoneTextField);
    }];
    
    // wrong warning
    [self.inputContainerView addSubview:self.warningLabel];
    [self.warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(4.f);
        make.leading.equalTo(self.phoneTextField);
        make.trailing.equalTo(self.phoneConfirmButton);
        make.bottom.equalTo(self.inputContainerView);
    }];
}

// MARK: - 设置数据
- (void)setDataSource:(id)dataSource
{
    _dataSource = dataSource;
    
    self.descLabel.text = @"默认文案";
    self.warningLabel.text = @"等待文案or数据";
}

// MARK: - handler
- (void)actionFinishConversation:(UIButton *)button
{
    NSLog(@"button.tag: %ld", button.tag);
}

- (void)actionConfirmPhone
{
    [self.phoneTextField endEditing:YES];
    NSLog(@"Confirm phone number!");
}

// MARK: Text Field Content
- (void)textDidChange:(UITextField *)textField
{
    NSLog(@"notify: %@", textField.text);
}

// MARK: - 键盘相关
// MARK: 接收键盘将要显示的通知
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (_positionYChangedHandler) {
        _positionYChangedHandler(notification, YES);
    }
}

// MARK: 接收键盘即将消失的通知
- (void)keyboardWillHide:(NSNotification *)notification {
    if (_positionYChangedHandler) {
        _positionYChangedHandler(notification, NO);
    }
}

// MARK: lazy load
- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.numberOfLines = 0;
        _descLabel.font = [UIFont systemFontOfSize:16];
        _descLabel.textColor = [UIColor blackColor];
        _descLabel.text = @"Dear customer,thank you for contacting us. Hope your problem already resolved.";
    }
    return _descLabel;
}

- (UIView *)buttonsContainerView
{
    if (!_buttonsContainerView) {
        _buttonsContainerView = [UIView new];
    }
    return _buttonsContainerView;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        // FIXME: - 多国语言
        [_confirmButton setTitle:NSLocalizedString(@"YES", @"确定") forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _confirmButton.backgroundColor = [UIColor colorWithHexString:@"#FEDB43"];
        _confirmButton.layer.cornerRadius = 3.f;
        _confirmButton.tag = MarlServiceChatingFinishConversationViewButtonsTypeConfirm;
        
        [_confirmButton addTarget:self action:@selector(actionFinishConversation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        // FIXME: - 多国语言
        [_cancelButton setTitle:NSLocalizedString(@"NO", @"取消") forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithHexString:@"#FAA316"] forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        _cancelButton.layer.cornerRadius = 3.f;
        _cancelButton.layer.borderWidth = 1.f;
        _cancelButton.layer.borderColor = [UIColor colorWithHexString:@"#FAA316"].CGColor;
        _cancelButton.tag = MarlServiceChatingFinishConversationViewButtonsTypeCancel;
        
        [_cancelButton addTarget:self action:@selector(actionFinishConversation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

// MARK: input
- (UIView *)inputContainerView
{
    if (!_inputContainerView) {
        _inputContainerView = [UIView new];
    }
    return _inputContainerView;
}

- (UILabel *)phoneDescLabel
{
    if (!_phoneDescLabel) {
        _phoneDescLabel = [UILabel new];
        _phoneDescLabel.font = [UIFont systemFontOfSize:12];
        _phoneDescLabel.textColor = [UIColor colorWithHexString:@"#666"];
        // FIXME: - 多国语言
        _phoneDescLabel.text = NSLocalizedString(@"You Phone Number", @"你的电话号");
    }
    return _phoneDescLabel;
}

- (UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.backgroundColor = [UIColor colorWithHexString:@"#FAFBFC"];
        _phoneTextField.layer.cornerRadius = 2.f;
        _phoneTextField.layer.borderColor = [UIColor colorWithHexString:@"#E1E7EB"].CGColor;
        _phoneTextField.layer.borderWidth = 1.f;
        _phoneTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        //        _phoneTextField.borderStyle = UITextBorderStyleLine;
        _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
        
        [_phoneTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTextField;
}

- (UIButton *)phoneConfirmButton
{
    if (!_phoneConfirmButton) {
        _phoneConfirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        // FIXME: - 多国语言
        [_phoneConfirmButton setTitle:NSLocalizedString(@"Confirm", @"确定") forState:UIControlStateNormal];
        [_phoneConfirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _phoneConfirmButton.backgroundColor = [UIColor colorWithHexString:@"#FEDB43"];
        _phoneConfirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _phoneConfirmButton.layer.cornerRadius = 3.f;
        
        [_phoneConfirmButton addTarget:self action:@selector(actionConfirmPhone) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneConfirmButton;
}

- (UILabel *)warningLabel
{
    if (!_warningLabel) {
        _warningLabel = [UILabel new];
        _warningLabel.font = [UIFont systemFontOfSize:12];
        _warningLabel.textColor = [UIColor colorWithHexString:@"#FF4443"];
        // FIXME: - 多国语言
        _warningLabel.text = NSLocalizedString(@"Waring", @"提醒");
    }
    return _warningLabel;
}

@end
