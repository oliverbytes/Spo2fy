import bb.cascades 1.0
import bb.multimedia 1.0

Container 
{
    translationX: 1
    property bool replay: false
    property alias videoSource: videoPlayer.sourceUrl
    
    id: videoPlayerComponent
    preferredWidth: _app.getDisplayWidth()
    preferredHeight: _app.getDisplayHeight()
    background: Color.Black

    signal playVideo();
    signal stopVideo();
    signal completed();
    
    layout: DockLayout {}
    
    onCreationCompleted: 
    {
        OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.All;
    }
    
    attachedObjects: 
    [
        MediaPlayer
        {
            id: videoPlayer
            videoOutput: VideoOutput.PrimaryDisplay
            windowId: videoPlayerForeignWindow.windowId
            
            onPlaybackCompleted: 
            {
                stopVideo();
                completed();
            }
        },
        OrientationHandler 
        {
            id: orientationHandler
            onOrientationChanged:
            {
                if (orientation == OrientationSupport.supportedDisplayOrientation.DisplayPortrait) 
                {
                    videoPlayerComponent.preferredWidth = _app.getDisplayWidth();
                    videoPlayerComponent.preferredHeight = _app.getDisplayHeight();
                } 
                else if (orientation == OrientationSupport.supportedDisplayOrientation.DisplayLandscape) 
                {
                    videoPlayerComponent.preferredWidth = _app.getDisplayHeight();
                    videoPlayerComponent.preferredHeight = _app.getDisplayWidth();                     
                }
            }
        }
    ]
    
    ForeignWindowControl 
    {
        id					: videoPlayerForeignWindow
        windowId			: "videoPlayerForeignWindow"
        updatedProperties	: WindowProperty.Size | WindowProperty.Position | WindowProperty.Visible | WindowProperty.SourceSize
        horizontalAlignment	: HorizontalAlignment.Fill
        verticalAlignment	: VerticalAlignment.Fill
        
        preferredWidth 		: videoPlayer.videoDimensions.width;
        minWidth 			: videoPlayer.videoDimensions.width;
        //maxWidth 			: videoPlayer.videoDimensions.width;
        
        preferredHeight 	: videoPlayer.videoDimensions.height;
        minHeight 			: videoPlayer.videoDimensions.height;
        //maxHeight 			: videoPlayer.videoDimensions.height;
        
        opacity: 1.0
    }

    onPlayVideo: 
    {
        if ((videoPlayer.sourceUrl != "")) 
        {
            videoPlayerForeignWindow.visible = true;
            videoPlayer.play();
        }
    }
    
    onStopVideo:
    {
        videoPlayerForeignWindow.visible = false;
        videoPlayer.stop();
    }
    
    onCompleted: 
    {
        if(replay)
    	{
    	    playVideo();
    	}    
    }
}