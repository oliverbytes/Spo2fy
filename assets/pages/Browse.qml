import bb.cascades 1.2
import nemory.NemAPI 1.0

import "../components"

NavigationPane 
{
    id: navigationPane
    
    property variant items : Object();
    
    signal tabActivated();
    
    onTabActivated: 
    {
        loadBrowses();
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
                    title: "Browse"
                    subtitle: browseDataModel.size()  
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
                                
                                browseDataModel.clear();
                                browseDataModel.insert(0, filteredItems);
                            }
                            else 
                            {
                                browseDataModel.clear();
                                browseDataModel.insert(0, items);
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
                        id: browseDataModel
                    }
                    
                    listItemComponents: 
                    [
                        ListItemComponent 
                        {
                            content: BrowseItem
                            {
                                id: root
                            }
                        }
                    ]
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
                    imageSource: "asset:///images/spotify/browse.png"
                    preferredHeight: 200
                    scalingMethod: ScalingMethod.AspectFit
                    horizontalAlignment: HorizontalAlignment.Center
                }
                
                Label 
                {
                    text: "Browse"
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
                    loadBrowses();
                }
            }
        ]
    }
    
    attachedObjects:
    [
        NemAPI
        {
            id: browsesAPI
            
            onComplete: 
            {
                console.log("**** ARTISTS endpoint: " + endpoint + ", httpcode: " + httpcode + ", response: " + response);
                
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
                    
                    if(responseJSON.items && responseJSON.items.length > 0)
                    {
                        browseDataModel.insert(0, responseJSON.items);
                    }
                    else
                    {
                    
                    }
                    
                    items = responseJSON.items;
                }
                
                if(browseDataModel.size() > 0)
                {
                    nothing.visible = false;
                }
                else 
                {
                    nothing.visible = true;
                }
                
                header.subtitle = browseDataModel.size();
            }
        }
    ]
    
    function loadBrowses()
    {
        browseDataModel.clear();
        loading.visible = true;
        error.visible = false;
        
        var params = new Object();
        params.endpoint = "me";
        params.url = "https://api.spotify.com/v1/" + params.endpoint;
        browsesAPI.getRequest(params);
    }
}