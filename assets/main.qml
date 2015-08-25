import bb.cascades 1.0
import bb.system 1.0
import nemory.NemAPI 1.0

import "pages"
import "sheets"

TabbedPane 
{
    id: tabbedPane
    activeTab: tabPlaylists
    
    onActiveTabChanged: 
    {
        activeTab.content.tabActivated();
    }
    
    Tab 
    {
        title: "Profile"
        imageSource: "asset:///images/spotify/person.png"
        
        content: Profile 
        {
            id: profilePage
        }
    }
    
    Tab 
    {
        id: tabPlaylists
        title: "Playlists"
        imageSource: "asset:///images/spotify/playlists.png"
        
        content: Playlists 
        {
            id: playlistsPage
        }
    }
    
    Tab 
    {
        title: "Songs"
        imageSource: "asset:///images/spotify/music.png"
        
        content: Songs
        {
            id: songsPage
        }
    }
    
    Tab 
    {
        title: "Albums"
        imageSource: "asset:///images/spotify/album.png"
        
        content: Albums 
        {
            id: albumsPage
        }
    }
    
    Tab 
    {
        title: "Artists"
        imageSource: "asset:///images/spotify/artists.png"
        
        content: Artists
        {
            id: artistsPage
        }
    }
    
    Tab 
    {
        title: "Search"
        imageSource: "asset:///images/spotify/search.png"
        
        content: Search 
        {
            id: searchPage
        }
    }
    
    Tab 
    {
        title: "Browse"
        imageSource: "asset:///images/spotify/browse.png"
        
        content: Browse 
        {
            id: browsePage
        }
    }
    
    Tab 
    {
        title: "Radio"
        imageSource: "asset:///images/spotify/radio.png"
        
        content: Radio 
        {
            id: radioPage
        }
    }
    
    attachedObjects: 
    [
        SettingsSheet 
        {
            id: settingsSheet
        },
        MainSheet
        {
            id: mainSheet
        },
        AboutSheet
        {
            id: aboutSheet
        },
        LoginSheet 
        {
            id: loginSheet
            
            onLoggedIn: 
            {
                playlistsPage.loadPlaylists();
            }
        },
        SystemDialog
        {
            id: dialog
            
            function pop(title, message)
            {
                dialog.title = title;
                dialog.body = message;
                dialog.show();
            }
        },
        SystemToast
        {
            id: toast
            
            function pop(message)
            {
                toast.body = message;
                toast.show();
            }
        },
        Invocation 
        {
            id: invokeShare
            query.mimeType: "text/plain"
            query.invokeActionId: "bb.action.SHARE"
            query.invokerIncluded: true
            query.data: "Spo2fy - The first and only Native Spotify Client for BlackBerry 10. Get it at http://appworld.blackberry.com/webstore/content/"
        },
        Invocation 
        {
            id: invokeBBWorld
            query.mimeType: "text/html"
            query.uri: "appworld://content/"
            query.invokeActionId: "bb.action.OPEN"
        },
        Invocation 
        {
            id: invokeEmail
            query.mimeType: "text/plain"
            query.invokeTargetId: "sys.pim.uib.email.hybridcomposer"
            query.invokeActionId: "bb.action.SENDEMAIL"
            onArmed: 
            {
                invokeEmail.trigger(query.invokeActionId);
            }
        },
        NemAPI
        {
            id: nemAPI
            
            onComplete: 
            {
                console.log("**** MAIN endpoint: " + endpoint + ", httpcode: " + httpcode + ", response: " + response);
                
                if(httpcode != 200)
                {
                    _app.flurryLogError(httpcode + " - " + endpoint + " - " + response);
                }
                else 
                {
                    var responseJSON = JSON.parse(response);
                    
                    if(endpoint == "xxx")
                    {
                        
                    }
                }
            }
        }
    ]
    
    onCreationCompleted: 
    {
        console.log("**** ACCESS TOKEN: " + _app.getSetting("access_token", "") + " ****");
        
        Qt.app                            = _app;
        Qt.dialog                         = dialog;
        Qt.toast                          = toast;
        Qt.tabbedPane                     = tabbedPane;
        Qt.mainSheet                      = mainSheet;
        Qt.loginSheet                     = loginSheet;
        Qt.settingsSheet                  = settingsSheet;
        Qt.aboutSheet                     = aboutSheet;
        
        Qt.playlistsCount                 = 0;
        Qt.shuffleQueueList               = new Array();
        
        Qt.me                             = new Object();
        
        if(_app.getSetting("access_token", "") == "")
        {
            mainSheet.open();
        }
        else 
        {
            var meJSON = _app.getSetting("meJSON", "");
            
            if(meJSON.length > 0)
            {
                Qt.me = JSON.parse(meJSON);
                
                _app.flurrySetUserID(Qt.me.id);
            }
            
//            var params = new Object();
//            params.endpoint = "refreshToken";
//            params.grant_type = "refresh_token";
//            params.refresh_token = _app.getSetting("access_token", "");
//            params.url = "https://accounts.spotify.com/api/token";
//            nemAPI.refreshToken(params);
        }
        
        Qt.dialog.pop("Attention", "This is a SUPER ALPHA VERSION of Spo2fy. All you see that doesn't work means has not been worked on yet. Hope you understand. And login sessions are expired for like after 20 minutes only and you have to relogin again (temp issue).\n\nHope you enjoy this version so far. Let us know anything. Join us in the Spo2fy CrackBerry Forum Discussion :)");
    }
    
    Menu.definition: MenuDefinition 
    {
        actions: 
        [
            ActionItem 
            {
                title: "About"
                imageSource: "asset:///images/info.png"
                onTriggered: 
                {
                    aboutSheet.open();
                }
            },
            ActionItem 
            {
                title: "Settings"
                imageSource: "asset:///images/settings.png"
                onTriggered:
                {
                    settingsSheet.open();
                }
            },
            ActionItem  
            {
                title: "Contact"
                imageSource: "asset:///images/email.png"
                onTriggered: 
                {
                    invokeEmail.query.uri = "mailto:spo2fy@gmail.com?subject=Support : Spo2fy";
                    invokeEmail.query.updateQuery();
                }
            },
            ActionItem 
            {
                title: "Rate"
                imageSource: "asset:///images/rate.png"
                onTriggered:
                {
                    invokeBBWorld.trigger("bb.action.OPEN")
                }
            },
            ActionItem 
            {
                title: "Logout"
                imageSource: "asset:///images/spotify/x.png"
                onTriggered:
                {
                    _app.setSetting("access_token", "");
                    toast.pop("Successfully Logged Out!");
                    
                    mainSheet.open();
                }
            }
        ]
    }
}