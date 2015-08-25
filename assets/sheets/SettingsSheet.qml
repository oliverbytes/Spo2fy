import bb.cascades 1.2

Sheet 
{
    id: sheet
    
    property int containerPadding : 20
    
    Page 
    {
        id: page

        titleBar: TitleBar 
        {
            title: "Settings"
            
            dismissAction: ActionItem 
            {
                title: "Close"
                
                onTriggered: 
                {
                    sheet.close();
                }
            }
        }
        
        Container 
        {
            topPadding: containerPadding
            bottomPadding: containerPadding
            leftPadding: containerPadding
            rightPadding: containerPadding
            
            layout: DockLayout {}
            
            Label 
            {
                text: "Nothing for now"
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
            }
        }
    }
}
