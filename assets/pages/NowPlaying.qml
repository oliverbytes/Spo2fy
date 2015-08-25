import bb.cascades 1.2
import nemory.WebImageView 1.0
import bb.multimedia 1.0
import QtQuick 1.0

Page 
{
    id: page
    
    property variant param : Object();
    property bool playing : false;
    property bool onmute : false;
    property double lastVolume;
    
    function load(data)
    {
        param = data;
        
        if(param.track.album && param.track.album.images)
        {
            image.imageSource     = param.track.album.images[0].url;
        }
        
        title.text            = param.track.name;
        artist.text           = param.track.artists[0].name;
        
        header.subtitle       = param.track.name;
        
        var secondsDuration   = Math.floor(param.track.duration_ms / 1000);
        
        var minutesDuration   = Math.floor(secondsDuration / 60);
        minutesDuration       = (minutesDuration.length == 1 ? "0" + minutesDuration : minutesDuration)
        
        var secondsRemainder  = secondsDuration % 60;
        secondsRemainder       = (secondsRemainder.length == 1 ? "0" + secondsRemainder : secondsRemainder)
        
        endingPoint.text      = minutesDuration + ":" + secondsRemainder;

        startTimer.start();
    }
    
    Container 
    {
        layout: DockLayout {}
        
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill

        WebImageView 
        {
            id: image
            defaultImage: "asset:///images/spotify/musicBackground.png"
            imageSource: "asset:///images/spotify/musicBackground.png"
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            scalingMethod: ScalingMethod.AspectFill
            minHeight: 720
            minWidth: 720
        }
        
        ActivityIndicator 
        {
            id: loading
            visible: true
            running: visible 
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            preferredHeight: 100
        }
        
        Header 
        {
            id: header
            title: "NOW PLAYING"
            subtitle: ""
        }
        Container 
        {
            id: bottom
            
            verticalAlignment: VerticalAlignment.Bottom
            horizontalAlignment: HorizontalAlignment.Fill
            
            Label 
            {
                id: title
                text: "Song Title"
                textStyle.fontWeight: FontWeight.W100  
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontSize: FontSize.Large
            }
            
            Label 
            {
                id: artist
                text: "The Artist"
                textStyle.fontWeight: FontWeight.W100  
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontSize: FontSize.XXSmall  
            }
            
            Container 
            {
                id: sliderContainer
                layout: DockLayout {}
                
                horizontalAlignment: HorizontalAlignment.Fill
                
                leftPadding: 20
                rightPadding: leftPadding
                bottomPadding: 20
                
                property bool touching : false;
                
                onTouchingChanged: 
                {
                    console.log("****** TOUCHING : " + touching + " *******");
                }
                
                onTouchEnter: 
                {
                    touching = true;
                }
                
                onTouchExit: 
                {
                    touching = false;
                }
                
                Label 
                {
                    id: startingPoint
                    
                    text: 
                    {
                        var second = Math.round(mediaPlayer.position / 1000)
                        second     = (second.length == 1 ? "0" + second : second)
                        
                        var minute = Math.round(second / 60);
                        minute     = (minute.length == 1 ? "0" + minute : minute)
                        
                        return minute + ":" + second;    
                    }
                    
                    textStyle.fontSize: FontSize.XSmall
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                }
                
                Slider 
                {
                    id: slider
                    maxWidth: 550
                    horizontalAlignment: HorizontalAlignment.Center
                    value: mediaPlayer.position
                    toValue: mediaPlayer.duration
                    
                    onValueChanged: 
                    {
                        if(sliderContainer.touching)
                        {
                            mediaPlayer.seekTime(value);
                        }
                    }
                }
                
                Label 
                {
                    id: endingPoint
                    textStyle.fontSize: FontSize.XSmall
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Center
                }
            }
        }
    }
    
    actions: 
    [
        ActionItem 
        {
            title: "Previous"
            imageSource: "asset:///images/spotify/prev.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: 
            {
            
            }
        },
        ActionItem 
        {
            title: (playing ? "Pause" : "Play")
            imageSource: (playing ? "asset:///images/spotify/pause.png" : "asset:///images/spotify/play.png")
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: 
            {
                if(mediaPlayer.mediaState == MediaState.Started)
                {
                    mediaPlayer.pause();
                    
                    playing = false;
                }
                else 
                {
                    mediaPlayer.play();
                    
                    playing = true;
                }
            }
        },
        ActionItem 
        {
            title: "Next"
            imageSource: "asset:///images/spotify/next.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: 
            {
            
            }
        },
        ActionItem 
        {
            title: "Replay"
            imageSource: "asset:///images/spotify/replay.png"
            ActionBar.placement: ActionBarPlacement.InOverflow
            
            onTriggered: 
            {
                playing = false;
                
                mediaPlayer.stop();
                mediaPlayer.play();
                
                playing = true;
            }
        },
        ActionItem 
        {
            title: "Add to Playlist"
            imageSource: "asset:///images/spotify/addToPlaylist.png"
            ActionBar.placement: ActionBarPlacement.InOverflow
            
            onTriggered: 
            {
                
            }
        },
        ActionItem 
        {
            title: (onmute ? "Unmute" : "Mute")
            imageSource: (onmute ? "asset:///images/spotify/unmute.png" : "asset:///images/spotify/mute.png")
            ActionBar.placement: ActionBarPlacement.InOverflow
            
            onTriggered: 
            {
                onmute = !onmute;
                
                if(onmute)
                {
                    mediaPlayer.volume = 0.0;
                }
                else 
                {
                    mediaPlayer.volume = lastVolume;
                }
            }
        }
    ]
    
    attachedObjects: 
    [
        MediaPlayer
        {
            id: mediaPlayer
            
            onBuffering: 
            {
                console.log("******** BUFFERING: " + percentage + "% ***********");
            }
            
            onBufferStatusChanged: 
            {
                console.log("******** BUFFER STATUS: " + bufferStatus + " ***********");    
                
                if(mediaPlayer.bufferStatus == BufferStatus.Buffering)
                {
                    loading.visible = true;
                }
                else 
                {
                    loading.visible = false;
                }
            }
            
            onError: 
            {
                console.log("******** ERROR ***********");    
            }

            onPlaybackCompleted: 
            {
                console.log("******** PLAYBACK COMPLETED ***********");
                
                playing = false;
            }
            
            onDurationChanged:
            {
                console.log("******** DURATION: " + duration + " ***********");
                
                var secondsDuration   = Math.floor(duration / 1000);
                
                var minutesDuration   = Math.floor(secondsDuration / 60);
                minutesDuration       = (minutesDuration.length == 1 ? "0" + minutesDuration : minutesDuration)
                
                var secondsRemainder  = secondsDuration % 60;
                secondsRemainder       = (secondsRemainder.length == 1 ? "0" + secondsRemainder : secondsRemainder)
                
                endingPoint.text      = minutesDuration + ":" + secondsRemainder;
            }
            
            onPositionChanged: 
            {
                console.log("******** POSITION: " + position + " ***********");
            }
        },
        Timer
        {
            id: startTimer
            interval: 1000
            repeat: false;
            
            onTriggered: 
            {
                console.log("******** PREPARING: " + param.track.preview_url + " ***********");
                
                mediaPlayer.sourceUrl = param.track.preview_url;
                mediaPlayer.play();
                
                playing = true;
                
                lastVolume = mediaPlayer.volume;
            }
        }
    ]
}