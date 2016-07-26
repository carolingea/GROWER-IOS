#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHAsset.h>
#import <Photos/PHImageManager.h>
#import <AVKit/AVKit.h>


@interface VCidea : UIViewController<UIImagePickerControllerDelegate, NSURLSessionDataDelegate>
{
    AVPlayer * miavPlayer;
    AVPlayerViewController * miavPlayerCon;
}

@property (weak, nonatomic) IBOutlet UIProgressView *ProgresoSubida;
- (IBAction)btnObtenerGaleria:(id)sender;
- (IBAction)btnGrabarIdea:(id)sender;
- (IBAction)btnVerMisIdeas:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgminiatura;

@end
