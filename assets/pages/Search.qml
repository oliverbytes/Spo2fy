import bb.cascades 1.2
import nemory.NemAPI 1.0

import "../components"

NavigationPane 
{
    id: navigationPane
    
    property variant items : Object();
    
    property string lastSearchResponse : "";
    
    signal tabActivated();
    
    onTabActivated: 
    {
        search.requestFocus();
    }
    
    Page 
    {
        Container 
        {
            leftPadding: 20
            rightPadding: 20
            topPadding: 20
            bottomPadding: 20
            
            verticalAlignment: VerticalAlignment.Fill
            
            layout: DockLayout {}
            
            Container 
            {
                DropDown 
                {
                    id: filterSearch
                    title: "Search Filter"
                    selectedIndex: 0
                    visible: false
                    
                    options: 
                    [
                        Option 
                        {
                            text: "All"
                            value: "artist,album,track"
                        },
                        Option 
                        {
                            text: "Tracks"
                            value: "track"
                        },
                        Option 
                        {
                            text: "Artists"   
                            value: "artist" 
                        },
                        Option 
                        {
                            text: "Albums"    
                            value: "album"
                        }
                    ]
                }
                
                TextField 
                {
                    id: search
                    hintText: "Search here"
                    backgroundVisible: false
                    input.submitKey: SubmitKey.Search
                    
                    input.onSubmitted: 
                    {
                        loadSearch();
                    }
                }
                
                Divider {}
                
                SegmentedControl 
                {
                    id: filterResults
                    
                    visible: false
                    
                    options: 
                    [
                        Option 
                        {
                            text: "Tracks"
                            value: "tracks"
                        },
                        Option 
                        {
                            text: "Artists"   
                            value: "artists" 
                        },
                        Option 
                        {
                            text: "Albums"    
                            value: "albums"
                        }
                    ]
                    
                    onSelectedValueChanged: 
                    {
                        searchDataModel.clear();
                        
                        var responseJSON = JSON.parse(lastSearchResponse);
                        
                        if(selectedValue == "tracks")
                        {
                            if(responseJSON.tracks.items.length > 0)
                            {
                                searchDataModel.insert(0, responseJSON.tracks.items);
                            }
                            else 
                            {
                                searchDataModel.clear();
                            }
                        }
                        else if(selectedValue == "artists")
                        {
                            if(responseJSON.artists.items.length > 0)
                            {
                                searchDataModel.insert(0, responseJSON.artists.items);
                            }
                            else 
                            {
                                searchDataModel.clear();
                            }
                        }
                        else if(selectedValue == "albums")
                        {
                            if(responseJSON.albums.items.length > 0)
                            {
                                searchDataModel.insert(0, responseJSON.albums.items);
                            }
                            else 
                            {
                                searchDataModel.clear();
                            }
                        }
                        
                        if(searchDataModel.size() > 0)
                        {
                            filterResults.visible = true;
                        }
                        else 
                        {
                            filterResults.visible = false;
                        }
                        
                        header.subtitle = searchDataModel.size();
                    }
                }
                
                Container 
                {
                    Header 
                    {
                        id: header
                        title: "Results"
                        subtitle: searchDataModel.size();
                    }
                    
                    ListView 
                    {
                        id: listView
                        visible: !nothing.visible
                        verticalAlignment: VerticalAlignment.Fill
                        horizontalAlignment: HorizontalAlignment.Fill
                        
                        dataModel: ArrayDataModel 
                        {
                            id: searchDataModel
                        }
                        
                        listItemComponents: 
                        [
                            ListItemComponent 
                            {
                                content: SearchResultItem
                                {
                                    id: root
                                }
                            }
                        ]
                        
                        onTriggered: 
                        {
                            var item = searchDataModel.data(indexPath); 
                            
                            _app.writeLogToFile(JSON.stringify(item));
                            
                            var page = new Object();
                            
                            if(item.type == "track")
                            {
                                page = nowPlayingComponent.createObject();
                                
                                var trackObject     = new Object();
                                trackObject.track   = item;
                                item                = trackObject;
                            }
                            else if(item.type == "album")
                            {
                                page = albumProfileComponent.createObject();
                            }
                            else if(item.type == "artist")
                            {
                                page = artistProfileComponent.createObject();
                            }
                            
                            page.load(item);
                            navigationPane.push(page);
                        }
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
                    imageSource: "asset:///images/spotify/search.png"
                    preferredHeight: 200
                    scalingMethod: ScalingMethod.AspectFit
                    horizontalAlignment: HorizontalAlignment.Center
                }
                
                Label 
                {
                    text: "Find your favourite music"
                    horizontalAlignment: HorizontalAlignment.Center
                }
                
                Label 
                {
                    text: "Search for tracks, artists, albums, playlists and profiles."
                    multiline: true
                    textStyle.fontSize: FontSize.XSmall
                    horizontalAlignment: HorizontalAlignment.Center
                    textStyle.textAlign: TextAlign.Center
                    textStyle.color: Color.Gray
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
                title: "Search"
                imageSource: "asset:///images/spotify/search.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                
                onTriggered: 
                {
                    search.requestFocus();
                }
            },
            ActionItem 
            {
                title: "Filter"
                imageSource: "asset:///images/spotify/filter.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                
                onTriggered: 
                {
                    filterSearch.visible = !filterSearch.visible;
                }
            },
            ActionItem 
            {
                title: "Refresh"
                imageSource: "asset:///images/refresh.png"
                ActionBar.placement: ActionBarPlacement.InOverflow
                
                onTriggered: 
                {
                    loadSearch();
                }
            }
        ]
    }
    
    attachedObjects: 
    [
        NemAPI
        {
            id: searchAPI
            
            onComplete: 
            {
                console.log("**** endpoint: " + endpoint + ", httpcode: " + httpcode + ", response: " + response);
                
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
                    lastSearchResponse = response;
                    
                    var responseJSON = JSON.parse(response);
                    
                    if(responseJSON.tracks)
                    {
                        if(responseJSON.tracks.items.length > 0)
                        {
                            searchDataModel.insert(0, responseJSON.tracks.items);
                        }
                    }
                    else if(responseJSON.artists)
                    {
                        if(responseJSON.artists.items.length > 0)
                        {
                            searchDataModel.insert(0, responseJSON.artists.items);
                        }
                    }
                    else if(responseJSON.albums)
                    {
                        if(responseJSON.albums.items.length > 0)
                        {
                            searchDataModel.insert(0, responseJSON.albums.items);
                        }
                    }
                    
                    items = responseJSON.items;
                }
                
                if(searchDataModel.size() > 0)
                {
                    filterResults.visible = true;
                    
                    nothing.visible = false;
                }
                else 
                {
                    filterResults.visible = false;
                    
                    nothing.visible = true;
                }
                
                header.subtitle = searchDataModel.size();
            }
        },
        ComponentDefinition 
        {
            id: nowPlayingComponent
            source: "asset:///pages/NowPlaying.qml"
        },
        ComponentDefinition 
        {
            id: albumProfileComponent
            source: "asset:///pages/AlbumProfile.qml"
        },
        ComponentDefinition 
        {
            id: artistProfileComponent
            source: "asset:///pages/ArtistProfile.qml"
        }
    ]
    
    function loadSearch()
    {
        error.visible = false;
        
        if(search.text.length > 0)
        {
            searchDataModel.clear();
            filterResults.visible = false;
            filterSearch.visible = false;
            loading.visible = true;
            nothing.visible = false;
            
            var params = new Object();
            params.endpoint = "search";
            params.url = "https://api.spotify.com/v1/" + params.endpoint + "?q=" + search.text + "&type=" + filterSearch.selectedValue + "&limit=50";
            searchAPI.getRequest(params);
        }
        else 
        {
            searchDataModel.clear();
            
            loading.visible = false;
            nothing.visible = true;
        }
    }
}