import bb.cascades 1.2
import nemory.WebImageView 1.0
import nemory.NemAPI 1.0

NavigationPane 
{
    id: navigationPane
    
    signal tabActivated();
    
    onTabActivated:
    {
        loadProfile();
        
        playlists.text = Qt.playlistsCount;
    }
    
    function loadProfile()
    {
        nothing.visible = false;
        loading.visible = true;
        profileContainer.visible = false;
        
        var params = new Object();
        params.endpoint = "me";
        params.url = "https://api.spotify.com/v1/" + params.endpoint;
        profileAPI.getRequest(params);
    }

    Page 
    {
        id: page
        
        ScrollView 
        {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            
            Container 
            {
                layout: DockLayout {}
                
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                
                Container 
                {
                    id: profileContainer
                    
                    //visible: false
                    
                    horizontalAlignment: HorizontalAlignment.Fill
                    bottomPadding: 40
                    
                    Header 
                    {
                        id: header
                        title: "PROFILE"
                        subtitle: "0"
                    }
                    
                    Container 
                    {
                        layout: DockLayout {}
                        
                        topPadding: 100
                        
                        horizontalAlignment: HorizontalAlignment.Center
                        
                        WebImageView 
                        {
                            id: image
                            defaultImage: "asset:///images/spotify/person.png"
                            imageSource: "asset:///images/spotify/person.png"
                            preferredHeight: 300
                            preferredWidth: preferredHeight
                            maxHeight: preferredHeight
                            maxWidth: maxHeight
                            scalingMethod: ScalingMethod.AspectFill
                        }
                        
                        ImageView 
                        {
                            imageSource: "asset:///images/circle_cover.png"
                            preferredHeight: 300
                            preferredWidth: preferredHeight
                            maxHeight: preferredHeight
                            maxWidth: maxHeight
                            scalingMethod: ScalingMethod.AspectFit
                        }
                    }
                    
                    Label 
                    {
                        id: name
                        textStyle.fontSize: FontSize.XLarge
                        textStyle.fontWeight: FontWeight.W100
                        textStyle.textAlign: TextAlign.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        text: "Display Name" 
                        multiline: true
                        preferredWidth: 400
                    }
                    
                    Label 
                    {
                        id: email
                        textStyle.fontSize: FontSize.XSmall
                        textStyle.fontWeight: FontWeight.W100
                        textStyle.textAlign: TextAlign.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        text: "EMAIL"
                    }
                    
                    Divider {}
                    
                    Container 
                    {
                        leftPadding: 20
                        rightPadding: 20
                        
                        horizontalAlignment: HorizontalAlignment.Fill
                        
                        Container 
                        {
                            layout: DockLayout {}
                            
                            horizontalAlignment: HorizontalAlignment.Fill
                            
                            Label 
                            {
                                text: "PLAYLISTS" 
                                horizontalAlignment: HorizontalAlignment.Left   
                                textStyle.fontSize: FontSize.XSmall 
                            }
                            
                            Label 
                            {
                                id: playlists
                                text: "0"  
                                horizontalAlignment: HorizontalAlignment.Right  
                                textStyle.fontSize: FontSize.XSmall 
                            }
                            
                            gestureHandlers: TapHandler 
                            {
                                onTapped: 
                                {
                                    Qt.tabbedPane.activeTab = Qt.tabbedPane.at(1);
                                }
                            }
                        }
                        
                        Divider {}
                        
                        Container 
                        {
                            layout: DockLayout {}
                            
                            horizontalAlignment: HorizontalAlignment.Fill
                            
                            Label 
                            {
                                text: "FOLLOWERS" 
                                horizontalAlignment: HorizontalAlignment.Left 
                                textStyle.fontSize: FontSize.XSmall   
                            }
                            
                            Label 
                            {
                                id: followers
                                text: "0"  
                                horizontalAlignment: HorizontalAlignment.Right
                                textStyle.fontSize: FontSize.XSmall   
                            }
                            
                            gestureHandlers: TapHandler 
                            {
                                onTapped: 
                                {
                                
                                }
                            }
                        }
                        
                        Divider {}
                        
                        Container 
                        {
                            layout: DockLayout {}
                            
                            horizontalAlignment: HorizontalAlignment.Fill
                            
                            Label 
                            {
                                text: "FOLLOWING" 
                                horizontalAlignment: HorizontalAlignment.Left  
                                textStyle.fontSize: FontSize.XSmall 
                            }
                            
                            Label 
                            {
                                id: following
                                text: "0"  
                                horizontalAlignment: HorizontalAlignment.Right  
                                textStyle.fontSize: FontSize.XSmall 
                            }
                            
                            gestureHandlers: TapHandler 
                            {
                                onTapped: 
                                {
                                    
                                }
                            }
                        }
                        
                        Divider {}
                        
                        Container 
                        {
                            layout: DockLayout {}
                            
                            horizontalAlignment: HorizontalAlignment.Fill
                            
                            Label 
                            {
                                text: "COUNTRY" 
                                horizontalAlignment: HorizontalAlignment.Left  
                                textStyle.fontSize: FontSize.XSmall 
                            }
                            
                            Label 
                            {
                                id: country
                                text: ""  
                                horizontalAlignment: HorizontalAlignment.Right  
                                textStyle.fontSize: FontSize.XSmall 
                            }
                        }
                        
                        Divider {}
                        
                        Container 
                        {
                            layout: DockLayout {}
                            
                            horizontalAlignment: HorizontalAlignment.Fill
                            
                            Label 
                            {
                                text: "SUBSCRIPTION" 
                                horizontalAlignment: HorizontalAlignment.Left  
                                textStyle.fontSize: FontSize.XSmall 
                            }
                            
                            Label 
                            {
                                id: subscription
                                text: ""  
                                horizontalAlignment: HorizontalAlignment.Right  
                                textStyle.fontSize: FontSize.XSmall 
                            }
                        }
                        
                        Divider {}
                    }
                }
                
                Container 
                {
                    id: nothing
                    
                    visible: true
                    
                    rightPadding: 100
                    leftPadding: 100
                    
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    
                    ImageView 
                    {
                        imageSource: "asset:///images/spotify/person.png"
                        preferredHeight: 200
                        scalingMethod: ScalingMethod.AspectFit
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                    
                    Label 
                    {
                        text: "Blank Profile"
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                    
                    Label 
                    {
                        id: error
                        visible: false
                        text: "Double check your Internet Connection or try to logout and relogin again."
                        textStyle.color: Color.DarkYellow
                        horizontalAlignment: HorizontalAlignment.Center
                        textStyle.fontSize: FontSize.XXSmall
                        multiline: true
                        preferredWidth: 400
                        textStyle.textAlign: TextAlign.Center
                    }
                }
                
                ActivityIndicator 
                {
                    id: loading
                    visible: false
                    running: visible
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    preferredHeight: 100
                }
            }
        }
        
        actions: 
        [
            ActionItem 
            {
                title: "Refresh"
                imageSource: "asset:///images/refresh.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                
                onTriggered: 
                {
                    loadProfile();
                }
            }
        ]
    }
    
    attachedObjects:
    [
        NemAPI
        {
            id: profileAPI
            
            onComplete: 
            {
                console.log("**** PROFILE endpoint: " + endpoint + ", httpcode: " + httpcode + ", response: " + response);
                
                _app.writeLogToFile(response);
                
                loading.visible = false;
                
                if(httpcode != 200)
                {
                    _app.flurryLogError(httpcode + " - " + endpoint + " - " + response);
                    
                    nothing.visible = true;
                    profileContainer.visible = false;
                    error.visible = true;
                }
                else 
                {
                    nothing.visible = false;
                    profileContainer.visible = true;
                    
                    var responseJSON = JSON.parse(response);
                    
                    if(endpoint == "me")
                    {
                        _app.setSetting("meJSON", response);
                        
                        Qt.me = responseJSON;
                        
                        populateProfile();
                    }
                }
            }
        }
    ]
    
    function populateProfile()
    {
        profileContainer.visible = true;
        loading.visible = false;
        nothing.visible = false;
        error.visible = false;
        
        name.text = Qt.me.display_name;
        image.url = Qt.me.images[0].url;
        email.text = Qt.me.email;
        header.subtitle = Qt.me.id;
        
        subscription.text = Qt.me.product;
        country.text = Qt.me.country;
    }
}