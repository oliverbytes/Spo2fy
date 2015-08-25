#include "ActiveFrameCover.h"

#include <bb/cascades/SceneCover>
#include <bb/cascades/Container>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>

using namespace bb::cascades;

ActiveFrameCover::ActiveFrameCover(QObject *parent)
    : SceneCover(parent)
{
    QmlDocument *qml = QmlDocument::create("asset:///activeframes/ActiveFrameCover.qml").parent(parent);
    Container *mainContainer = qml->createRootObject<Container>();
    setContent(mainContainer);

    theusername1 = mainContainer->findChild<Label*>("theusername1");
    theusername2 = mainContainer->findChild<Label*>("theusername2");
    theusername3 = mainContainer->findChild<Label*>("theusername3");
    theusername4 = mainContainer->findChild<Label*>("theusername4");
    theusername5 = mainContainer->findChild<Label*>("theusername5");
	theusername6 = mainContainer->findChild<Label*>("theusername6");

	thestatus1 = mainContainer->findChild<Label*>("thestatus1");
	thestatus2 = mainContainer->findChild<Label*>("thestatus2");
	thestatus3 = mainContainer->findChild<Label*>("thestatus3");
	thestatus4 = mainContainer->findChild<Label*>("thestatus4");
	thestatus5 = mainContainer->findChild<Label*>("thestatus5");
	thestatus6 = mainContainer->findChild<Label*>("thestatus6");

	theimage1 = mainContainer->findChild<ImageView*>("theimage1");
	theimage2 = mainContainer->findChild<ImageView*>("theimage2");
	theimage3 = mainContainer->findChild<ImageView*>("theimage3");
	theimage4 = mainContainer->findChild<ImageView*>("theimage4");
	theimage5 = mainContainer->findChild<ImageView*>("theimage5");
	theimage6 = mainContainer->findChild<ImageView*>("theimage6");

	snap1Container = mainContainer->findChild<Container*>("snap1");
	snap2Container = mainContainer->findChild<Container*>("snap2");
	snap3Container = mainContainer->findChild<Container*>("snap3");
	snap4Container = mainContainer->findChild<Container*>("snap4");
	snap5Container = mainContainer->findChild<Container*>("snap5");
	snap6Container = mainContainer->findChild<Container*>("snap6");

	listSnaps 			= mainContainer->findChild<Container*>("listSnaps");
	splashScreenImage 	= mainContainer->findChild<ImageView*>("splashScreenImage");
}

void ActiveFrameCover::setSnap1Visibility(bool visibility)
{
	snap1Container->setVisible(visibility);
}

void ActiveFrameCover::setSnap2Visibility(bool visibility)
{
	snap2Container->setVisible(visibility);
}

void ActiveFrameCover::setSnap3Visibility(bool visibility)
{
	snap3Container->setVisible(visibility);
}

void ActiveFrameCover::setSnap4Visibility(bool visibility)
{
	snap4Container->setVisible(visibility);
}

void ActiveFrameCover::setSnap5Visibility(bool visibility)
{
	snap5Container->setVisible(visibility);
}

void ActiveFrameCover::setSnap6Visibility(bool visibility)
{
	snap6Container->setVisible(visibility);
}

//

void ActiveFrameCover::setSplashImageVisibility(bool visibility)
{
	splashScreenImage->setVisible(visibility);
}

void ActiveFrameCover::setListSnapsVisibility(bool visibility)
{
	listSnaps->setVisible(visibility);
}

void ActiveFrameCover::setUsername1(QString text)
{
	theusername1->setText(text);
}

void ActiveFrameCover::setUsername2(QString text)
{
	theusername2->setText(text);
}

void ActiveFrameCover::setUsername3(QString text)
{
	theusername3->setText(text);
}

void ActiveFrameCover::setUsername4(QString text)
{
	theusername4->setText(text);
}

void ActiveFrameCover::setUsername5(QString text)
{
	theusername5->setText(text);
}

void ActiveFrameCover::setUsername6(QString text)
{
	theusername6->setText(text);
}


// ------------------ STATUS

void ActiveFrameCover::setStatus1(QString text)
{
	thestatus1->setText(text);
}

void ActiveFrameCover::setStatus2(QString text)
{
	thestatus2->setText(text);
}

void ActiveFrameCover::setStatus3(QString text)
{
	thestatus3->setText(text);
}

void ActiveFrameCover::setStatus4(QString text)
{
	thestatus4->setText(text);
}

void ActiveFrameCover::setStatus5(QString text)
{
	thestatus5->setText(text);
}

void ActiveFrameCover::setStatus6(QString text)
{
	thestatus6->setText(text);
}

// ----------------------- IMAGE

void ActiveFrameCover::setImage1(QString imageSource)
{
	theimage1->setImageSource(imageSource);
}

void ActiveFrameCover::setImage2(QString imageSource)
{
	theimage2->setImageSource(imageSource);
}

void ActiveFrameCover::setImage3(QString imageSource)
{
	theimage3->setImageSource(imageSource);
}

void ActiveFrameCover::setImage4(QString imageSource)
{
	theimage4->setImageSource(imageSource);
}

void ActiveFrameCover::setImage5(QString imageSource)
{
	theimage5->setImageSource(imageSource);
}

void ActiveFrameCover::setImage6(QString imageSource)
{
	theimage6->setImageSource(imageSource);
}
