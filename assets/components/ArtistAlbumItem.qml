import bb.cascades 1.2
import nemory.WebImageView 1.0

CustomListItem 
{
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    
    preferredHeight: 150
    
    Container
    {
        id: mainContainer
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: DockLayout {}
        leftPadding: 20
        rightPadding: leftPadding
        topPadding: leftPadding
        bottomPadding: leftPadding
        
        Container
        {
            id: contentContainer
            
            horizontalAlignment: HorizontalAlignment.Left
            
            layout: StackLayout
            {
                orientation: LayoutOrientation.LeftToRight
            }
            
            Container 
            {
                id: photoContainer
                
                layout: DockLayout {}
                minWidth: 120
                minHeight: minWidth
                maxWidth: minWidth
                maxHeight: minWidth
                
                layoutProperties: StackLayoutProperties 
                {
                    spaceQuota: 1
                }
                
                WebImageView 
                {
                    url: ListItemData.images[1].url;
                    defaultImage: "asset:///images/spotify/album.png"
                    imageSource: "asset:///images/spotify/album.png"
                    preferredHeight: 120
                    preferredWidth: preferredHeight
                    scalingMethod: ScalingMethod.AspectFit
                }
                
                ImageView 
                {
                    imageSource: "asset:///images/circle_cover.png"
                    preferredHeight: 120
                    preferredWidth: preferredHeight
                    scalingMethod: ScalingMethod.AspectFit
                }
            }
            
            Container 
            {
                id: textContainer
                leftPadding: 20
                verticalAlignment: VerticalAlignment.Center
                
                layoutProperties: StackLayoutProperties 
                {
                    spaceQuota: 4
                }
                
                Container 
                {
                    Label 
                    {
                        textStyle.fontSize: FontSize.Large
                        textStyle.fontWeight: FontWeight.W100
                        text: ListItemData.name
                    }
                }
                
                Container 
                {
                    Label 
                    {
                        textStyle.fontSize: FontSize.XXSmall
                        textStyle.fontWeight: FontWeight.Default
                        text: ListItemData.artists[0].name
                    }
                }
            }
        }
    }
}