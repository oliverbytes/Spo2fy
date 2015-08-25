import bb.cascades 1.2
import nemory.NemAPI 1.0
import nemory.WebImageView 1.0

import "../components"

Page 
{
    id: page
    
    property variant items : Object();
    
    property variant param : Object();
    
    signal tabActivated();
    
    onTabActivated: 
    {
        loadPlaylistTracks();
    }
    
    function load(data)
    {
        param = data;
        
        loadPlaylistTracks();
    }
    
    Container 
    {
        layout: DockLayout {}
        
        Container 
        {
            Header 
            {
                id: header
                title: "PLAYLIST'S TRACKS"
                subtitle: playlistTracksDataModel.size()  
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
                            
                            playlistTracksDataModel.clear();
                            playlistTracksDataModel.insert(0, filteredItems);
                        }
                        else 
                        {
                            playlistTracksDataModel.clear();
                            playlistTracksDataModel.insert(0, items);
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
                    id: playlistTracksDataModel
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
                    var item = playlistTracksDataModel.data(indexPath);  
                    
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
                text: "0 Playlist's Tracks"
                horizontalAlignment: HorizontalAlignment.Center
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
                loadPlaylistTracks();
            }
        },
        ActionItem 
        {
            title: "Shuffle"
            imageSource: "asset:///images/spotify/shuffle.png"
            ActionBar.placement: ActionBarPlacement.InOverflow
            
            onTriggered: 
            {
            
            }
        }
    ]
    
    attachedObjects:
    [
        NemAPI
        {
            id: playlistTracksAPI
            
            onComplete: 
            {
                console.log("**** PLAYLIST TRACKS endpoint: " + endpoint + ", httpcode: " + httpcode + ", response: " + response);
                
                _app.writeLogToFile(response);
                
                loading.visible = false;
                
                if(httpcode != 200)
                {
                    _app.flurryLogError(httpcode + " - " + endpoint + " - " + response);
                    
                    items = new Array();
                }
                else
                {
                    var responseJSON = JSON.parse(response);
                    
                    if(responseJSON.items.length > 0)
                    {
                        playlistTracksDataModel.insert(0, responseJSON.items);
                    }
                    else
                    {
                    
                    }
                    
                    items = responseJSON.items;
                }
                
                if(playlistTracksDataModel.size() > 0)
                {
                    nothing.visible = false;
                }
                else 
                {
                    nothing.visible = true;
                }
                
                header.subtitle = playlistTracksDataModel.size();
            }
        },
        ComponentDefinition 
        {
            id: nowPlayingComponent
            source: "asset:///pages/NowPlaying.qml"
        }
    ]
    
    function loadPlaylistTracks()
    {
        playlistTracksDataModel.clear();
        loading.visible = true;
        nothing.visible = false;
        
        var params = new Object();
        params.endpoint = "users/" + Qt.me.id + "/playlists/" + param.id + "/tracks";
        params.url = "https://api.spotify.com/v1/" + params.endpoint;
        playlistTracksAPI.getRequest(params);
    }
}