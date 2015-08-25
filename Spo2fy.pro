APP_NAME = Spo2fy

CONFIG 		+= qt warn_on cascades10 mobility

QT 			+= network
QT 			+= declarative

LIBS += -lbb
LIBS += -lbbdata
LIBS += -lbbsystem
LIBS += -lbbdevice

LIBS += -lbbmultimedia
LIBS += -lbbplatform
LIBS += -lbbplatformbbm

LIBS += -lscreen
LIBS += -lcrypto
LIBS += -lcurl 
LIBS += -lpackageinfo 
LIBS += -lhuapi

include(config.pri)
