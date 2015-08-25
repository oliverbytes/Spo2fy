
#ifndef ACTIVEFRAMECOVER_H_
#define ACTIVEFRAMECOVER_H_

#include <QObject>
#include <bb/cascades/Label>
#include <bb/cascades/ImageView>
#include <bb/cascades/Container>
#include <bb/cascades/SceneCover>

using namespace ::bb::cascades;

class ActiveFrameCover: public SceneCover
{
    Q_OBJECT

public:
    ActiveFrameCover(QObject *parent=0);
    virtual ~ActiveFrameCover() { }

    Q_INVOKABLE void setUsername1(QString text);
	Q_INVOKABLE void setUsername2(QString text);
	Q_INVOKABLE void setUsername3(QString text);
	Q_INVOKABLE void setUsername4(QString text);
	Q_INVOKABLE void setUsername5(QString text);
	Q_INVOKABLE void setUsername6(QString text);

	Q_INVOKABLE void setStatus1(QString text);
	Q_INVOKABLE void setStatus2(QString text);
	Q_INVOKABLE void setStatus3(QString text);
	Q_INVOKABLE void setStatus4(QString text);
	Q_INVOKABLE void setStatus5(QString text);
	Q_INVOKABLE void setStatus6(QString text);

	Q_INVOKABLE void setImage1(QString imageSource);
	Q_INVOKABLE void setImage2(QString imageSource);
	Q_INVOKABLE void setImage3(QString imageSource);
	Q_INVOKABLE void setImage4(QString imageSource);
	Q_INVOKABLE void setImage5(QString imageSource);
	Q_INVOKABLE void setImage6(QString imageSource);

	Q_INVOKABLE void setSnap1Visibility(bool visibility);
	Q_INVOKABLE void setSnap2Visibility(bool visibility);
	Q_INVOKABLE void setSnap3Visibility(bool visibility);
	Q_INVOKABLE void setSnap4Visibility(bool visibility);
	Q_INVOKABLE void setSnap5Visibility(bool visibility);
	Q_INVOKABLE void setSnap6Visibility(bool visibility);

	Q_INVOKABLE void setListSnapsVisibility(bool visibility);
	Q_INVOKABLE void setSplashImageVisibility(bool visibility);

private:
    bb::cascades::Label *theusername1;
    bb::cascades::Label *theusername2;
    bb::cascades::Label *theusername3;
    bb::cascades::Label *theusername4;
    bb::cascades::Label *theusername5;
    bb::cascades::Label *theusername6;

    bb::cascades::Label *thestatus1;
	bb::cascades::Label *thestatus2;
	bb::cascades::Label *thestatus3;
	bb::cascades::Label *thestatus4;
	bb::cascades::Label *thestatus5;
	bb::cascades::Label *thestatus6;

	bb::cascades::ImageView *theimage1;
	bb::cascades::ImageView *theimage2;
	bb::cascades::ImageView *theimage3;
	bb::cascades::ImageView *theimage4;
	bb::cascades::ImageView *theimage5;
	bb::cascades::ImageView *theimage6;

	bb::cascades::Container *snap1Container;
	bb::cascades::Container *snap2Container;
	bb::cascades::Container *snap3Container;
	bb::cascades::Container *snap4Container;
	bb::cascades::Container *snap5Container;
	bb::cascades::Container *snap6Container;

	bb::cascades::Container *listSnaps;
	bb::cascades::ImageView *splashScreenImage;
};

#endif /* ACTIVEFRAMECOVER_H_ */

