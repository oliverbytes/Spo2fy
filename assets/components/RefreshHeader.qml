import bb.cascades 1.0
import QtQuick 1.0

Container 
{
    property bool readyForRefresh: false;
    property bool refreshing: false;
    property string refreshedAt: "";
    property int refresh_threshold: 150;
    
    signal refreshTriggered
    id: refreshContainer
    horizontalAlignment: HorizontalAlignment.Fill
    layout: DockLayout {}

    Container 
    {
        id: refreshStatusContainer
        visible: !refreshing
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Top
        bottomPadding: 30.0
        
        ImageView 
        {
            id: refreshImage
            visible: !refreshing
            imageSource: "asset:///images/stretchableRefresh.png"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredHeight: getImageHeight();
        }
    }
    
    Container 
    {
        id: refreshingContainer
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Fill
        visible: refreshing
        topPadding: 20
         bottomPadding: 20
        
        ActivityIndicator 
        {
            running: refreshing
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
        }
    }
    
    Divider 
    {
        opacity: 0.0
    }
    
    attachedObjects: 
    [
        LayoutUpdateHandler 
        {
            id: refreshHandler
            
            onLayoutFrameChanged: 
            {
                if (refreshing) 
                {
                    return;
                }
                
                readyForRefresh = false;

                if (layoutFrame.y >= 0) 
                {
                    if (layoutFrame.y >= refresh_threshold) 
                    {
                        if (!refreshing) 
                        {
                            readyForRefresh = true;
                        }
                    }
                } 
                else if (layoutFrame.y >= -100) 
                {
                   // not yet ready
                } 
            }
        }
    ]
    
    function released() 
    {
        if (readyForRefresh) 
        {
            readyForRefresh = false;
            refreshing = true;
            refreshTriggered();
        }
        else 
        {
            refreshContainer.setPreferredHeight(0);
        }
    }

    function doneRefreshing()
    {
        readyForRefresh = false;
        refreshing = false;
        
        refreshContainer.setPreferredHeight(0);
        refreshStatusContainer.visible = true;
    }

    function onListViewTouch(event) 
    {
        refreshContainer.resetPreferredHeight();
        
        if (event.touchType == TouchType.Up) 
        {
            released();
        }
    }
    
    function getImageHeight()
    {
        var height = 0;
        
        if(refreshHandler.layoutFrame.y > 0)
        {
            height = refreshHandler.layoutFrame.y;
        }
        else 
        {
            height = 5;
        }
        
        return height;
    }
}
