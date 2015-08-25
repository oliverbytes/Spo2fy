import bb.cascades 1.2
import nemory.NemAPI 1.0
import nemory.WebImageView 1.0

import "../components"

Page 
{
    id: page
    
    property variant items : Object();
    
    property variant param : Object();

    function load(data)
    {
        param = data;
        
        image.url = param.images[0].url;
        name.text = param.name;
        
        loadAlbumTracks();
    }
    
    ScrollView 
    {
        Container 
        {
            layout: DockLayout {}
            
            Container 
            {
                Header 
                {
                    id: header
                    title: "Album Tracks"
                    subtitle: albumProfileDataModel.size()  
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
                                
                                albumProfileDataModel.clear();
                                albumProfileDataModel.insert(0, filteredItems);
                            }
                            else 
                            {
                                albumProfileDataModel.clear();
                                albumProfileDataModel.insert(0, items);
                            }
                        }
                    }
                    
                    Divider {}
                }
                
                Container 
                {
                    layout: DockLayout {}
                    
                    topPadding: 100
                    
                    horizontalAlignment: HorizontalAlignment.Center
                    
                    WebImageView 
                    {
                        id: image
                        defaultImage: "asset:///images/spotify/album.png"
                        imageSource: "asset:///images/spotify/album.png"
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
                    text: "Album Title" 
                }
                
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
                
                Divider {}
                
                PullToRefreshListView 
                {
                    id: listView
                    visible: !nothing.visible
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill
                    maxHeight: _app.getDisplayHeight() - 200;
                    
                    dataModel: ArrayDataModel 
                    {
                        id: albumProfileDataModel
                    }
                    
                    listItemComponents: 
                    [
                        ListItemComponent 
                        {
                            content: AlbumTrackItem
                            {
                                id: root
                            }
                        }
                    ]
                    
                    onTriggered: 
                    {
                        var item = albumProfileDataModel.data(indexPath); 
                        
                        var page = nowPlayingComponent.createObject();
                        
                        var trackObject     = new Object();
                        trackObject.track   = item;
                        trackObject.album   = new Object();
                        item                = trackObject;
                        
                        page.load(item);
                        navigationPane.push(page);
                    }
                }
            }
            
            Container 
            {
                id: nothing
                
                visible: false
                
                rightPadding: 100
                leftPadding: 100
                
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                
                ImageView 
                {
                    imageSource: "asset:///images/spotify/album.png"
                    preferredHeight: 200
                    scalingMethod: ScalingMethod.AspectFit
                    horizontalAlignment: HorizontalAlignment.Center
                }
                
                Label 
                {
                    text: "0 Album's Tracks"
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
                loadAlbumTracks();
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
            id: albumsAPI
            
            onComplete: 
            {
                console.log("**** ALBUM PROFILE endpoint: " + endpoint + ", httpcode: " + httpcode + ", response: " + response);
                
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
                    
                    if(responseJSON.items && responseJSON.items.length > 0)
                    {
                        albumProfileDataModel.insert(0, responseJSON.items);
                    }
                    else
                    {
                    
                    }
                    
                    items = responseJSON.items;
                }
                
                if(albumProfileDataModel.size() > 0)
                {
                    nothing.visible = false;
                }
                else 
                {
                    nothing.visible = true;
                }
                
                header.subtitle = albumProfileDataModel.size();
            }
        },
        ComponentDefinition 
        {
            id: nowPlayingComponent
            source: "asset:///pages/NowPlaying.qml"
        }
    ]
    
    function loadAlbumTracks()
    {
        albumProfileDataModel.clear();
        loading.visible = true;
        
        var params = new Object();
        params.endpoint = "albums/" + param.id + "/tracks";
        params.url = "https://api.spotify.com/v1/" + params.endpoint;
        albumsAPI.getRequest(params);
    }
}