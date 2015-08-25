import bb.cascades 1.0

ListView 
{
    id: refreshableListView
    leadingVisualSnapThreshold: 0
    snapMode: SnapMode.LeadingEdge
    bufferedScrollingEnabled: true
    
    signal refreshTriggered()
    signal doneRefreshing();
    
    onDoneRefreshing: 
    {
        refreshHeaderComponent.doneRefreshing();
    }
    
    leadingVisual: RefreshHeader 
    {
        id: refreshHeaderComponent
        
        onRefreshTriggered:
        {
            refreshableListView.refreshTriggered();
        }
    }
    
    onTouch: 
    {
        refreshHeaderComponent.onListViewTouch(event);
    }

    function refreshHeader()
    {
        refreshTriggered();
        refreshHeaderComponent.refreshTriggered();
    }
}
