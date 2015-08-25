#include "applicationui.hpp"
#include <bb/cascades/Application>
#include <QLocale>
#include <QTranslator>
#include <Qt/qdeclarativedebug.h>

#include "NemAPI/NemAPI.hpp"
#include "WebImageView/WebImageView.hpp"
#include <Flurry.h>
#include <bb/ApplicationInfo>
#include "NemAdvertisements/NemAdsController.hpp"

using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
    #if !defined(QT_NO_DEBUG)
        Flurry::Analytics::SetDebugLogEnabled(false);
    #endif

    Flurry::Analytics::SetAppVersion(bb::ApplicationInfo().version());
    Flurry::Analytics::StartSession("8BPSZH5TWNK4YDNTF4M5");

    QSettings settings("NEMORY", "SPO2FY");
    QString colortheme = "dark";

    if (!settings.value("colortheme").isNull())
    {
        colortheme = settings.value("colortheme").toString();
    }

    qputenv("CASCADES_THEME", colortheme.toUtf8());

    qmlRegisterType<NemAdsController>("nemory.Advertisements", 1, 0, "NemAdsController");
    qmlRegisterType<NemAPI>("nemory.NemAPI", 1, 0, "NemAPI");
    qmlRegisterType<WebImageView>("nemory.WebImageView", 1, 0, "WebImageView");

    Application app(argc, argv);
    ApplicationUI appui;
    return Application::exec();
}
