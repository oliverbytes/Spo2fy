import bb.cascades 1.0
import nemory.NemAPI 1.0
import bb.system 1.0

Sheet 
{
    id: sheet
    
    property string client_id         : "9572fbd8aa8744e1923798aae760355a";
    property string client_secret     : "f27cb59dba7747119a75ce01217a2188";
    property string redirect_uri      : "http://localhost/";
    property string scopes            : "playlist-modify-public playlist-modify-private playlist-read-private user-library-modify user-library-read user-read-private user-read-email";
    property string loginURL          : "https://accounts.spotify.com/authorize?response_type=token&client_id=" + client_id + "&scope=" + scopes + "&redirect_uri=" + redirect_uri;
    
    signal loggedIn();
    
    onOpened: 
    {
        browser.storage.clearCookies();
        browser.url = loginURL;    
        browser.reload();
    }
    
    Page 
    {
        id: page
        
        titleBar: TitleBar 
        {
            title: "Login / Sign Up"
            
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
            id: mainContainer
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            
            ProgressIndicator
            {
                visible: browser.visible && browser.loading
                fromValue: 0
                toValue: 100
                value: browser.loadProgress
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Bottom
            }
            
            Container 
            {
                layout: DockLayout {}
                
                ScrollView 
                {
                    Container 
                    {
                        WebView
                        {
                            id: browser
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            minHeight: 1000
                            property string lastURL : ""
                            
                            onNavigationRequested:
                            {
                                if(_app.contains(request.url, "http://localhost/#access_token="))
                                {
                                    var access_token = _app.regex(request.url, "access_token=(.*)&token_type", 1);
                                    
                                    _app.setSetting("access_token", access_token);

//                                    var params = new Object();
//                                    params.endpoint = "refreshToken";
//                                    params.grant_type = "refresh_token";
//                                    params.refresh_token = access_token;
//                                    params.url = "https://accounts.spotify.com/api/token";
//                                    tokenAPI.refreshToken(params);

                                    var params = new Object();
                                    params.endpoint = "me";
                                    params.url = "https://api.spotify.com/v1/" + params.endpoint;
                                    loginAPI.getRequest(params);
                                    
                                    progressDialog.title     = "Processing";
                                    progressDialog.body      = "Final Authentication...";
                                    progressDialog.show();
                                } 
                            }
                        }
                    }
                }
                
                Container 
                {
                    visible: browser.loading
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Bottom
                    
                    bottomPadding: 20
                    rightPadding: 20
                    
                    onVisibleChanged: 
                    {
                        if(visible)
                        {
                            loadingLogo.play();
                        }
                        else 
                        {
                            loadingLogo.stop();
                        }
                    }
                    
                    layout: DockLayout {}
                    
                    ImageView 
                    {
                        id: loadingLogo
                        imageSource: "asset:///images/icon144.png" 
                        scalingMethod: ScalingMethod.AspectFit
                        preferredHeight: 50
                        
                        animations: 
                        [
                            FadeTransition 
                            {
                                id: fadeAnimation
                                duration: 1000
                                repeatCount: 99999999
                                toOpacity: 1.0
                                fromOpacity: 0.3
                                easingCurve: StockCurve.Linear
                                
                                onStopped: 
                                {
                                    loadingLogo.resetOpacity();
                                }
                            },
                            ScaleTransition 
                            {
                                id: scaleAnimation
                                duration: 1000
                                repeatCount: 99999999
                                toX: 1.0
                                toY: 1.0
                                fromX: 0.7
                                fromY: 0.7
                                easingCurve: StockCurve.BounceInOut
                                
                                onStopped: 
                                {
                                    loadingLogo.resetScale();
                                }
                            }
                        ]
                        
                        function play()
                        {
                            loadingLogo.visible = true;
                            fadeAnimation.play();
                            scaleAnimation.play();
                        }
                        
                        function stop()
                        {
                            loadingLogo.visible = false;
                            fadeAnimation.stop();
                            scaleAnimation.stop();
                        }
                    }
                }
            }
        }
    }
    
    attachedObjects: 
    [
        NemAPI 
        {
            id: loginAPI
            
            onComplete: 
            {
                console.log("**** LOGIN endpoint: " + endpoint + ", httpcode: " + httpcode + ", response: " + response);

                if(httpcode != 200)
                {
                    _app.flurryLogError(httpcode + " - " + endpoint + " - " + response);
                }
                else 
                {
                    var responseJSON = JSON.parse(response);
                    
                    if(endpoint == "me")
                    {
                        Qt.me = responseJSON;
                        
                        _app.flurrySetUserID(Qt.me.id);
                        
                        _app.setSetting("meJSON", response);
                        
                        Qt.toast.pop("Successfully Logged In!");
                        
                        sheet.close();
                        Qt.mainSheet.close();
                        
                        loggedIn();
                    }
                }
                
//                if(responseJSON.access_token)
//                {
//                    _app.setSetting("access_token", responseJSON.access_token);
//                    
//                    Qt.toast.pop("Successfully Logged In!");
//                     
//                    sheet.close();
//                    Qt.mainSheet.close();
//                     
//                    loggedIn();
//                }
                
                progressDialog.cancel();
            }
        },
        SystemProgressDialog
        {
            id: progressDialog
        }
    ]
}
