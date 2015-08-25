import bb.cascades 1.2
import bb.system 1.0
import nemory.NemAPI 1.0

import "../components"

NavigationPane 
{
    id: navigationPane
    
    property variant items : Object();
    
    signal tabActivated();
    
    onTabActivated: 
    {
        loadPlaylists();
    }
    
    onCreationCompleted: 
    {
        var meJSON = _app.getSetting("meJSON", "");
        
        if(meJSON.length > 0)
        {
            Qt.me = JSON.parse(meJSON);
            
            loadPlaylists();
        }
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
                    title: "Playlists"
                    subtitle: playlistsDataModel.size()  
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
                                
                                playlistsDataModel.clear();
                                playlistsDataModel.insert(0, filteredItems);
                            }
                            else 
                            {
                                playlistsDataModel.clear();
                                playlistsDataModel.insert(0, items);
                            }
                        }
                    }
                    
                    Divider {}
                }
                
                PullToRefreshListView 
                {
                    id: listView
                    visible: !nothing.visible
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill
                    
                    dataModel: ArrayDataModel 
                    {
                        id: playlistsDataModel
                    }
                    
                    listItemComponents: 
                    [
                        ListItemComponent 
                        {
                            content: PlaylistItem
                            {
                                id: root
                            }
                        }
                    ]
                    
                    onTriggered: 
                    {
                        var item = playlistsDataModel.data(indexPath); 
                        
                        var page = playlistTracksComponent.createObject();
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
                    imageSource: "asset:///images/spotify/playlists.png"
                    preferredHeight: 200
                    scalingMethod: ScalingMethod.AspectFit
                    horizontalAlignment: HorizontalAlignment.Center
                }
                
                Label 
                {
                    text: "0 Playlists"
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
                title: "Create a Playlist"
                imageSource: "asset:///images/spotify/addToPlaylist.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                
                onTriggered: 
                {
                    promptCreatePlaylist.show();
                }
            },
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
                ActionBar.placement: ActionBarPlacement.InOverflow
                
                onTriggered: 
                {
                    loadPlaylists();
                }
            }
        ]
    }
    
    attachedObjects:
    [
        NemAPI
        {
            id: playlistsAPI
            
            onComplete: 
            {
                console.log("**** PLAYLISTS endpoint: " + endpoint + ", httpcode: " + httpcode + ", response: " + response);
                
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
                        playlistsDataModel.insert(0, responseJSON.items);
                    }
                    else
                    {
                        
                    }
                    
                    items = responseJSON.items;
                }
                
                if(playlistsDataModel.size() > 0)
                {
                    nothing.visible = false;
                }
                else 
                {
                    nothing.visible = true;
                }
                
                header.subtitle = playlistsDataModel.size();
                
                Qt.playlistsCount = playlistsDataModel.size();
            }
        },
        SystemPrompt 
        {
            id: promptCreatePlaylist
            title: "Create a New Playlist"
            includeRememberMe: false
            rememberMeChecked: false
            confirmButton.label: "Create"
            cancelButton.label: "Cancel"
            inputField.emptyText: "Title"
            returnKeyAction: SystemUiReturnKeyAction.Done
        },
        ComponentDefinition 
        {
            id: playlistTracksComponent
            source: "asset:///pages/PlaylistTracks.qml"
        }
    ]
    
    function loadPlaylists()
    {
        playlistsDataModel.clear();
        loading.visible = true;
        error.visible = false;
        
        var params = new Object();
        params.endpoint = "users/" + Qt.me.id + "/playlists";
        params.url = "https://api.spotify.com/v1/" + params.endpoint;
        playlistsAPI.getRequest(params);
    }
}