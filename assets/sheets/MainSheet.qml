import bb.cascades 1.2

import "../components"

Sheet 
{
    id: sheet
    
    Page 
    {
        id: page
        
        Container 
        {
            layout: DockLayout {}  
            
            //        VideoPlayer 
            //        {
            //            id: video
            //            videoSource: "asset:///videos/backgroundVideo.mp4"
            //            horizontalAlignment: HorizontalAlignment.Fill
            //            verticalAlignment: VerticalAlignment.Fill
            //            
            //            onCreationCompleted: 
            //            {
            //                playVideo();
            //            }
            //        }
            
            ImageView 
            {
                imageSource: "asset:///images/spotify/backgroundPhoto.jpg"    
                scalingMethod: ScalingMethod.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
            }
            
            Container 
            {
                leftPadding: 50
                rightPadding: 50
                bottomPadding: 50
                topPadding: 200
                
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                
                layout: DockLayout {}
                
                ImageView 
                {
                    imageSource: "asset:///images/spotify/bannerTransparent.png"
                    scalingMethod: ScalingMethod.AspectFit
                    preferredHeight: 130
                    horizontalAlignment: HorizontalAlignment.Center
                }
                
                Container 
                {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Bottom
                    
                    Label 
                    {
                        text: "Hello"
                        textStyle.fontSize: FontSize.XXLarge
                        textStyle.fontWeight: FontWeight.W100
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                    
                    Container 
                    {
                        bottomPadding: 50
                        horizontalAlignment: HorizontalAlignment.Center
                        
                        Label 
                        {
                            text: "Enjoy Free and Unlimited Music for your BlackBerry 10. \nBrowse, Search, Playlists, Radio, "
                            multiline: true
                            textStyle.textAlign: TextAlign.Center
                            textStyle.fontSize: FontSize.XXSmall
                            textStyle.fontWeight: FontWeight.W100
                        }
                    }
                    
                    Container 
                    {
                        layout: StackLayout 
                        {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        
                        Button 
                        {
                            text: "Login"
                            horizontalAlignment: HorizontalAlignment.Fill
                            
                            onClicked: 
                            {
                                Qt.loginSheet.open();
                            }
                        }
                        
                        Button 
                        {
                            text: "Register"
                            horizontalAlignment: HorizontalAlignment.Fill
                            
                            onClicked: 
                            {
                                Qt.loginSheet.open();
                                
                                Qt.dialog.pop("Attention", "Click the Sign Up Link below.");
                            }
                        }
                    }
                    
                    Label 
                    {
                        text: "Forgot your password? Tap here."
                        textStyle.fontSize: FontSize.XSmall
                        textStyle.fontStyle: FontStyle.Italic
                        
                        gestureHandlers: TapHandler 
                        {
                            onTapped: 
                            {
                                Qt.loginSheet.open();
                                
                                Qt.dialog.pop("Attention", "Click the Forgot your password? Link below.");
                            }
                        }
                    }
                }
            }
        }
    }
}