import bb.cascades 1.2
import nemory.NemAPI 1.0

import "../components"
import nemory.WebImageView 1.0

NavigationPane 
{
    id: navigationPane
    
    property variant items : Object();
    
    signal tabActivated();
    
    onTabActivated: 
    {
        loadSongs();
    }
    
    function load(param)
    {
        
    }
    
    Page 
    {
        Container 
        {
            layout: DockLayout {}
            
            Container 
            {
                Header 
                {
                    id: header
                    title: "Songs"
                    subtitle: songsDataModel.size()  
                }
                
                Container
                {
                    id: filterListContainer
                    
                    visible: false;
                    
                    TextField 
                    {
                        id: search
                        hintText: "Filter here"
                        backgroundVisible: false
                        input.submitKey: SubmitKey.Search
                        
                        onTextChanging: 
                        {
                            if(items.length > 0)
                            {
                                var filteredItems = new Array();
                                
                                for(var i = 0; i < items.length; i++)
                                {
                                    var item = items[i];
                                    
                                    if(_app.contains(item.name, search.text))
                                    {
                                        filteredItems.push(item);
                                    }
                                }
                                
                                songsDataModel.clear();
                                songsDataModel.insert(0, filteredItems);
                            }
                            else 
                            {
                                songsDataModel.clear();
                                songsDataModel.insert(0, items);
                            }
                        }
                    }
                    
                    Divider {}
                }
                
                Container 
                {
                    visible: !nothing.visible
                    
                    topPadding: 20
                    
                    ImageButton 
                    {
                        defaultImageSource: "asset:///images/spotify/shuffleButton.png"
                        pressedImageSource: "asset:///images/spotify/shuffleButtonPressed.png"
                        horizontalAlignment: HorizontalAlignment.Center
                        preferredWidth: 500
                        preferredHeight: 80
                        
                        onClicked: 
                        {
                        
                        }
                    }
                    
                    Container 
                    {
                        horizontalAlignment: HorizontalAlignment.Fill  
                        
                        leftPadding: 50
                        rightPadding: leftPadding
                        
                        layout: DockLayout {}
                        
                        Label
                        {
                            text: "Available Offline"
                            verticalAlignment: VerticalAlignment.Center
                        }
                        
                        ToggleButton 
                        {
                            checked: _app.getSetting("availableOffline", "false");
                            horizontalAlignment: HorizontalAlignment.Right
                            
                            onCheckedChanged:
                            {
                                _app.setSetting("availableOffline", checked);
                            }
                        }
                    }
                    
                    Divider { }
                }
                
                PullToRefreshListView 
                {
                    id: listView
                    visible: !nothing.visible
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill
                    
                    dataModel: ArrayDataModel 
                    {
                        id: songsDataModel
                    }
                    
                    listItemComponents: 
                    [
                        ListItemComponent 
                        {
                            content: TrackItem
                            {
                                id: root
                            }
                        }
                    ]
                    
                    onTriggered: 
                    {
                        var item = songsDataModel.data(indexPath);  
                        
                        var page = nowPlayingComponent.createObject();
                        page.load(item);
                        navigationPane.push(page);
                    }
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
                    imageSource: "asset:///images/spotify/playlists.png"
                    preferredHeight: 200
                    scalingMethod: ScalingMethod.AspectFit
                    horizontalAlignment: HorizontalAlignment.Center
                }
                
                Label 
                {
                    text: "0 Songs"
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
        
        actions: 
        [
            ActionItem 
            {
                title: "Filter"
                imageSource: "asset:///images/spotify/filter.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                
                onTriggered: 
                {
                    filterListContainer.visible = !filterListContainer.visible;
                    
                    if(filterListContainer.visible)
                    {
                        search.requestFocus();
                    }
                }
            },
            ActionItem 
            {
                title: "Refresh"
                imageSource: "asset:///images/refresh.png"
                
                onTriggered: 
                {
                    loadSongs();
                }
            }
        ]
    }
    
    attachedObjects:
    [
        NemAPI
        {
            id: songsAPI
            
            onComplete: 
            {
                console.log("**** SONGS endpoint: " + endpoint + ", httpcode: " + httpcode + ", response: " + response);
                
                _app.writeLogToFile(response);
                
                loading.visible = false;
                
                if(httpcode != 200)
                {
                    _app.flurryLogError(httpcode + " - " + endpoint + " - " + response);
                    
                    error.visible = true;
                    
                    items = new Array();
                }
                else
                {
                    var responseJSON = JSON.parse(response);
                    
                    if(responseJSON.items.length > 0)
                    {
                        songsDataModel.insert(0, responseJSON.items);
                    }
                    else
                    {
                    
                    }
                    
                    items = responseJSON.items;
                }
                
                if(songsDataModel.size() > 0)
                {
                    nothing.visible = false;
                }
                else 
                {
                    nothing.visible = true;
                }
                
                header.subtitle = songsDataModel.size();
            }
        },
        ComponentDefinition 
        {
            id: nowPlayingComponent
            source: "asset:///pages/NowPlaying.qml"
        }
    ]
    
    function loadSongs()
    {
        songsDataModel.clear();
        loading.visible = true;
        error.visible = false;
        
        var params = new Object();
        params.endpoint = "me/tracks";
        params.url = "https://api.spotify.com/v1/" + params.endpoint;
        songsAPI.getRequest(params);
    }
}