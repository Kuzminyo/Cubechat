#import <Foundation/Foundation.h>
#import <WebRTC/WebRTC.h>

@protocol ExternalVideoProcessingDelegate
- (RTC_OBJC_TYPE(RTCVideoFrame) * _Nonnull)onFrame:(RTC_OBJC_TYPE(RTCVideoFrame) * _Nonnull)frame;
@end

@interface VideoProcessingAdapter : NSObject <RTCVideoCapturerDelegate>

- (_Nonnull instancetype)initWithRTCVideoSource:(RTCVideoSource* _Nonnull)source;

- (void)addProcessing:(_Nonnull id<ExternalVideoProcessingDelegate>)processor;

- (void)removeProcessing:(_Nonnull id<ExternalVideoProcessingDelegate>)processor;

- (RTCVideoSource* _Nonnull) source;

/// CubeChat: every camera frame leaves as portrait (RTCVideoRotation_90),
/// whatever the phone's physical tilt. See CUBECHAT_PATCH.md, "A call's
/// picture holds still when the phone tilts".
@property(nonatomic, assign) BOOL holdsPortrait;

@end
