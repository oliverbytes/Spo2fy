import bb.cascades 1.0

Sheet 
{
    id: sheet

    Page 
    {
        titleBar: TitleBar 
        {
            title: "About Spo2fy"
            
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
            layout: DockLayout {}
            
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Center

            ScrollView 
            {
                verticalAlignment: VerticalAlignment.Center
                
                Container 
                {
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    
                    leftPadding: 20
                    rightPadding: 20
                    
                    ImageView 
                    {
                        scalingMethod: ScalingMethod.AspectFit
                        imageSource: "asset:///images/icon480.png"    
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        preferredHeight: 300
                    }
                    
                    Label 
                    {
                        text: "Native Spotify Client for BlackBerry 10."
                        multiline: true
                        horizontalAlignment: HorizontalAlignment.Center
                        textStyle.textAlign: TextAlign.Center
                        textStyle.fontWeight: FontWeight.W100
                        textStyle.color: Color.Gray
                        textStyle.fontSize: FontSize.XLarge
                    }
                    
                    Label 
                    {
                        text: "Developed using QT, C++, QML, Javascript, PHP, JSON, XML, HTML, CSS, BlackBerry Cascades UI Framework, Momentics IDE/QDE, NemEngine";
                        horizontalAlignment: HorizontalAlignment.Center
                        textStyle.fontSize: FontSize.XXSmall
                        textStyle.color: Color.Gray
                        textStyle.textAlign: TextAlign.Center
                        multiline: true
                    }
                    
                    Label 
                    {
                        text: "Developed by: Nemory Studios / Oliver Martinez"
                        multiline: true
                        horizontalAlignment: HorizontalAlignment.Center
                        textStyle.textAlign: TextAlign.Center
                        textStyle.color: Color.Gray
                        textStyle.fontSize: FontSize.XSmall
                        textStyle.fontWeight: FontWeight.W400
                        maxWidth: 500
                    }
                    
                    Label 
                    {
                        text: "Version " + _packageInfo.version;
                        horizontalAlignment: HorizontalAlignment.Center
                        textStyle.fontSize: FontSize.XXSmall
                        textStyle.fontWeight: FontWeight.Bold
                        textStyle.color: Color.Gray
                        multiline: true
                    }
                    
                     Button 
                     {
                         text: "Invite friends to download"
                         horizontalAlignment: HorizontalAlignment.Center
                         onClicked: 
                         {
                             Qt.app.inviteUserToDownloadViaBBM();
                         }
                     }
                }
            }
        }
    }
}