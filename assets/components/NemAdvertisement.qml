import bb.cascades 1.0
import nemory.WebImageView 1.0
import QtQuick 1.0
import bb.system 1.0
import nemory.Advertisements 1.0

Container 
{
    id: advertisements
    
    property variant animationDirection: LayoutOrientation.TopToBottom
    property bool autoLoadOnStart : true;
    property bool started : false;
    
    property int userid : 0 // you can find your userid in the dashboard
    property int refreshInterval: 300 // in seconds
    property int evolutionInterval: 7 // in seconds
    
    preferredHeight: 120
    maxHeight: preferredHeight
    minHeight: preferredHeight
    visible: false

    onCreationCompleted: 
    {
        if(autoLoadOnStart)
        {
            adsReloadTimer.start();
            
            started = true;
        }
    }
    
    function start()
    {
        if(!started)
        {
            adsReloadTimer.start();
            
            started = true;
        }
    }
    
    attachedObjects: 
    [
        NemAdsController 
        {
            id: adController
            
            onComplete: 
            {
                console.log("NemAdsController RESPONSE: " + response + ", HTTPCODE: " + httpcode + ", ENDPOINT: " + endpoint);
                
                if(httpcode == "200")
                {
                    if(endpoint == "load")
                    {
                        adsEvolutionTimer.stop();
                        adsEvolutionTimer.start();
                        
                        adsDataModel.clear();
                        
                        var data = JSON.parse(response);
                        
                        if(data.length > 0)
                        {
                            adsDataModel.insert(0, data);
                            advertisements.visible = (_app.getSetting("purchasedAds", "false") == "false");
                        }
                        else 
                        {
                            advertisements.visible = false;
                        }
                    }
                    else (endpoint == "clicked")
                    {
                        
                    }
                }
            }
        },
        Timer
        {
            id: adsReloadTimer
            triggeredOnStart: true
            repeat: true
            interval: 10000 * 1000
            
            onTriggered: 
            {
                load();
            }
        },
        Timer
        {
            id: adsEvolutionTimer
            repeat: true
            interval: evolutionInterval * 1000
            property int currentIndex : 0;
            
            onTriggered: 
            {
                currentIndex++;
                
                var indexPath = new Array();
                indexPath[0] = currentIndex;
                
                listView.scrollToItem(indexPath);
                
                if(currentIndex > adsDataModel.size())
                {
                    currentIndex = 0;
                }
            }
        },
        Invocation 
        {
            id: adsInvoker
            query.invokeActionId: "bb.action.OPEN"
        },
        SystemDialog
        {
            id: adsDialog
        }
    ]
    
    ListView 
    {
        id: listView
        snapMode: SnapMode.LeadingEdge
        flickMode: FlickMode.SingleItem
        stickToEdgePolicy: ListViewStickToEdgePolicy.Beginning
        preferredHeight: 120
        maxHeight: preferredHeight
        minHeight: preferredHeight
        
        dataModel: ArrayDataModel 
        {
            id: adsDataModel
        }
        
        layout: StackListLayout 
        {
            orientation: animationDirection
        }
        
        onTriggered: 
        {
            var selectedItem = adsDataModel.data(indexPath);
            
            clicked(selectedItem.id);
            
            if(selectedItem.launchin == "message")
            {
                adsDialog.title    = "Information";
                adsDialog.body     = selectedItem.text;
                adsDialog.show();
            }
            else 
            {
                adsInvoker.query.uri = selectedItem.url;
                
                if(selectedItem.launchin == "bbworld")
                {
                    adsInvoker.query.invokeTargetId = "sys.appworld";
                }
                else if(selectedItem.launchin == "browser")
                {
                    adsInvoker.query.invokeTargetId = "sys.browser";
                }
                
                adsInvoker.query.updateQuery();
                adsInvoker.trigger("bb.action.OPEN");
            }
        }
        
        listItemComponents: 
        [
            ListItemComponent 
            {
                Container
                {
                    preferredHeight: 120
                    maxHeight: preferredHeight
                    minHeight: preferredHeight
                    preferredWidth: 768
                    minWidth: 768
                    horizontalAlignment: HorizontalAlignment.Fill
                    background: Color.create(ListItemData.bgcolor)
                    
                    layout: StackLayout 
                    {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    
                    WebImageView 
                    {
                        id: adImage
                        url: ListItemData.image
                        defaultImage: "asset:///components/adloading.png"
                        preferredHeight: 120
                        preferredWidth: 300
                        maxHeight: preferredHeight
                        maxWidth: preferredWidth
                        minHeight: preferredHeight
                        minWidth: preferredWidth
                    }
                    
                    Container 
                    {
                        leftPadding: 10
                        rightPadding: 10
                        
                        verticalAlignment: VerticalAlignment.Center
                        
                        Label 
                        {
                            id: adText
                            text: ListItemData.text
                            textStyle.color: Color.create(ListItemData.textcolor)
                            textStyle.fontSize: FontSize.XXSmall
                            multiline: true
                        }
                    }
                }
            }
        ]
    }
    
    function load()
    {
        var params         = new Object();
        params.endpoint    = "load";
        params.data         = userid
        adController.getRequest(params);
    }
    
    function clicked(adID)
    {
        var params         = new Object();
        params.endpoint    = "clicked";
        params.data         = adID
        adController.getRequest(params);
    }
}