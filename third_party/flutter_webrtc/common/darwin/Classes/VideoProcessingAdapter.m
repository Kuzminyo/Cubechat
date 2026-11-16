#import "VideoProcessingAdapter.h"
#import <os/lock.h>

@implementation VideoProcessingAdapter {
  RTCVideoSource* _videoSource;
  CGSize _frameSize;
  NSArray<id<ExternalVideoProcessingDelegate>>* _processors;
  os_unfair_lock _lock;
}

- (instancetype)initWithRTCVideoSource:(RTCVideoSource*)source {
  self = [super init];
  if (self) {
    _lock = OS_UNFAIR_LOCK_INIT;
    _videoSource = source;
    _processors = [NSArray<id<ExternalVideoProcessingDelegate>> new];
  }
  return self;
}

- (RTCVideoSource* _Nonnull) source {
    return _videoSource;
}

- (void)addProcessing:(id<ExternalVideoProcessingDelegate>)processor {
  os_unfair_lock_lock(&_lock);
  _processors = [_processors arrayByAddingObject:processor];
  os_unfair_lock_unlock(&_lock);
}

- (void)removeProcessing:(id<ExternalVideoProcessingDelegate>)processor {
  os_unfair_lock_lock(&_lock);
  _processors = [_processors
      filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject,
                                                                        NSDictionary* bindings) {
        return evaluatedObject != processor;
      }]];
  os_unfair_lock_unlock(&_lock);
}

- (void)setSize:(CGSize)size {
  _frameSize = size;
}

- (void)capturer:(RTC_OBJC_TYPE(RTCVideoCapturer) *)capturer
    didCaptureVideoFrame:(RTC_OBJC_TYPE(RTCVideoFrame) *)frame {
#if TARGET_OS_IPHONE
  // CubeChat: RTCCameraVideoCapturer stamps each frame with a rotation taken
  // from UIDevice's *physical* orientation, though the app's interface is
  // locked to portrait. Tilting the phone past 45 degrees — leaning back,
  // reaching for something — turned the picture a quarter turn on both ends
  // and back again. The rotation is metadata only: re-stamping it copies no
  // pixels. Portrait is _90 for both lenses in the capturer's own table.
  if (_holdsPortrait && frame.rotation != RTCVideoRotation_90) {
    frame = [[RTC_OBJC_TYPE(RTCVideoFrame) alloc] initWithBuffer:frame.buffer
                                                        rotation:RTCVideoRotation_90
                                                     timeStampNs:frame.timeStampNs];
  }
#endif
  os_unfair_lock_lock(&_lock);
  for (id<ExternalVideoProcessingDelegate> processor in _processors) {
    frame = [processor onFrame:frame];
  }
  [_videoSource capturer:capturer didCaptureVideoFrame:frame];
  os_unfair_lock_unlock(&_lock);
}

@end
