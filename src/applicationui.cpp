#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/platform/Notification>
#include <bb/PackageInfo>
#include <bb/system/SystemDialog>
#include "ActiveFrame/ActiveFrameCover.h"
#include <bb/device/DisplayInfo>
#include <bb/system/Clipboard>
#include <Flurry.h>

using namespace bb::cascades;
using bb::platform::Notification;
using bb::PackageInfo;
using namespace bb::system;
using bb::device::DisplayInfo;
using namespace bb::cascades;

const QString AUTHOR     = "NEMORY";
const QString APPNAME    = "SPO2FY";

ApplicationUI::ApplicationUI() :
        QObject()
{
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);

    bool res = QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(onSystemLanguageChanged()));
    Q_ASSERT(res);
    Q_UNUSED(res);

    onSystemLanguageChanged();

    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("_app", this);

    ActiveFrameCover *activeFrame = new ActiveFrameCover();
    Application::instance()->setCover(activeFrame);
    qml->setContextProperty("_activeFrame", activeFrame);

    PackageInfo packageInfo;
    QDeclarativePropertyMap* map = new QDeclarativePropertyMap(this);
    map->setProperty("version", packageInfo.version());
    map->setProperty("author", packageInfo.author());
    qml->setContextProperty("_packageInfo", map);

    AbstractPane *root = qml->createRootObject<AbstractPane>();
    Application::instance()->setScene(root);

    m_context = new bb::platform::bbm::Context(QUuid("7a5fc056-288a-4071-be19-51613f2fef41"));

    if (m_context->registrationState() != bb::platform::bbm::RegistrationState::Allowed)
    {
        connect(m_context, SIGNAL(registrationStateUpdated (bb::platform::bbm::RegistrationState::Type)), this, SLOT(registrationStateUpdated (bb::platform::bbm::RegistrationState::Type)));
        m_context->requestRegisterApplication();
    }
}

void ApplicationUI::writeLogToFile(QString log)
{
    QFile file("data/LOGFILE.txt");
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&file);
    out << log;
    file.close();
}

bool ApplicationUI::contains(QString text, QString find)
{
    if(find == "" || find == " " || find == "  " || text == "" || text == " " || text == "  ")
    {
        return false;
    }

    bool result = text.contains(find, Qt::CaseInsensitive);

    return result;
}

QString ApplicationUI::getSetting(const QString &objectName, const QString &defaultValue)
{
    QSettings settings(AUTHOR, APPNAME);

    if (settings.value(objectName).isNull() || settings.value(objectName) == "")
    {
        return defaultValue;
    }

    return settings.value(objectName).toString();
}

void ApplicationUI::setSetting(const QString &objectName, const QString &inputValue)
{
    QSettings settings(AUTHOR, APPNAME);
    settings.setValue(objectName, QVariant(inputValue));
}

void ApplicationUI::flurrySetUserID(QString value)
{
    Flurry::Analytics::SetUserID(value);
}

void ApplicationUI::flurryLogError(QString value)
{
    Flurry::Analytics::LogError(value);
}

void ApplicationUI::flurryLogEvent(QString value)
{
    Flurry::Analytics::LogEvent(value);
}

QString ApplicationUI::getHomePath()
{
    return QDir::homePath();
}

qint64 ApplicationUI::getFolderSize(QString folder)
{
    qint64 totalFileSize = 0;

    QDir filesDir(folder);

    if (filesDir.exists(folder))
    {
        Q_FOREACH(QFileInfo info, filesDir.entryInfoList(QDir::NoDotAndDotDot | QDir::System | QDir::Hidden  | QDir::AllDirs | QDir::Files | QDir::AllEntries | QDir::Writable, QDir::DirsFirst))
        {
            QFile *file = new QFile(info.absoluteFilePath());

            if(file->open(QIODevice::ReadWrite))
            {
                totalFileSize = totalFileSize + file->size();
            }

            file->close();
        }
    }

    return totalFileSize;
}

bool ApplicationUI::wipeFolderContents(const QString &folder)
{
    bool result = false;

    if(folder.length() > 0)
    {
        QDir dir(folder);

        if (dir.exists(folder))
        {
            Q_FOREACH(QFileInfo info, dir.entryInfoList(QDir::NoDotAndDotDot | QDir::System | QDir::Hidden  | QDir::AllDirs | QDir::Files | QDir::AllEntries | QDir::Writable, QDir::DirsFirst))
            {
                if (info.isDir())
                {
                    result = wipeFolder(info.absoluteFilePath());
                }
                else
                {
                    result = QFile::remove(info.absoluteFilePath());
                }
            }
        }
    }

    return result;
}

bool ApplicationUI::wipeFolder(const QString &folder)
{
    bool result = false;

    if(folder.length() > 0)
    {
        QDir dir(folder);

        if (dir.exists(folder))
        {
            Q_FOREACH(QFileInfo info, dir.entryInfoList(QDir::NoDotAndDotDot | QDir::System | QDir::Hidden  | QDir::AllDirs | QDir::Files | QDir::AllEntries | QDir::Writable, QDir::DirsFirst))
            {
                if (info.isDir())
                {
                    result = wipeFolder(info.absoluteFilePath());
                }
                else
                {
                    result = QFile::remove(info.absoluteFilePath());
                }
            }

            result = dir.rmdir(folder);
        }
    }

    return result;
}

void ApplicationUI::inviteUserToDownloadViaBBM()
{
    if (m_context->registrationState() == bb::platform::bbm::RegistrationState::Allowed)
    {
        m_messageService->sendDownloadInvitation();
    }
    else
    {
        SystemDialog *bbmDialog = new SystemDialog("OK");
        bbmDialog->setTitle("BBM Connection Error");
        bbmDialog->setBody("BBM is not currently connected. Please setup / sign-in to BBM to remove this message.");
        connect(bbmDialog, SIGNAL(finished(bb::system::SystemUiResult::Type)), this, SLOT(dialogFinished(bb::system::SystemUiResult::Type)));
        bbmDialog->show();
        return;
    }
}

void ApplicationUI::updatePersonalMessage(const QString &message)
{
    if (m_context->registrationState() == bb::platform::bbm::RegistrationState::Allowed)
    {
        m_userProfile->requestUpdatePersonalMessage(message);
    }
    else
    {
        SystemDialog *bbmDialog = new SystemDialog("OK");
        bbmDialog->setTitle("BBM Connection Error");
        bbmDialog->setBody("BBM is not currently connected. Please setup / sign-in to BBM to remove this message.");
        connect(bbmDialog, SIGNAL(finished(bb::system::SystemUiResult::Type)), this, SLOT(dialogFinished(bb::system::SystemUiResult::Type)));
        bbmDialog->show();
        return;
    }
}

void ApplicationUI::registrationStateUpdated(bb::platform::bbm::RegistrationState::Type state)
{
    if (state == bb::platform::bbm::RegistrationState::Allowed)
    {
        m_messageService = new bb::platform::bbm::MessageService(m_context,this);
        m_userProfile = new bb::platform::bbm::UserProfile(m_context, this);
    }
    else if (state == bb::platform::bbm::RegistrationState::Unregistered)
    {
        m_context->requestRegisterApplication();
    }
}

QString ApplicationUI::regex(QString text, QString expression, int index)
{
    QRegExp rxItem(expression);
    QString result = "";

    if( rxItem.indexIn( text ) != -1 )
    {
        result = rxItem.cap(index);
    }

    return result;
}

void ApplicationUI::deleteFile(QString fileName)
{
    if(QFile::exists(fileName))
    {
        QFile::remove(fileName);
    }
}

int ApplicationUI::getDisplayHeight()
{
    DisplayInfo displayInfo;
    return displayInfo.pixelSize().height();
}

int ApplicationUI::getDisplayWidth()
{
    DisplayInfo displayInfo;
    return displayInfo.pixelSize().width();
}

void ApplicationUI::copyAndRemove(QString from, QString to)
{
    if(QFile::exists(from))
    {
        if(QFile::exists(to))
        {
            QFile::remove(to);
        }

        if(QFile::copy(from, to))
        {
            QFile::remove(from);
        }
    }
}

QString ApplicationUI::getTempPath()
{
    return QDir::tempPath();
}

void ApplicationUI::copyToClipboard(QByteArray data)
{
    bb::system::Clipboard clipboard;
    clipboard.clear();
    clipboard.insert("text/plain", data);
}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    QString locale_string = QLocale().name();
    QString file_name = QString("Spo2fy_%1").arg(locale_string);

    if (m_pTranslator->load(file_name, "app/native/qm"))
    {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}
