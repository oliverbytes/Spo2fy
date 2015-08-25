#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <bb/platform/bbm/Context>
#include <bb/platform/bbm/MessageService>
#include <bb/platform/bbm/UserProfile>

namespace bb
{
    namespace cascades
    {
        class LocaleHandler;
    }
}

class QTranslator;

class ApplicationUI : public QObject
{
    Q_OBJECT

public:

    ApplicationUI();
    virtual ~ApplicationUI() {}

    Q_INVOKABLE bool contains(QString text, QString find);
    Q_INVOKABLE void writeLogToFile(QString log);

    Q_INVOKABLE void flurrySetUserID(QString value);
    Q_INVOKABLE void flurryLogError(QString value);
    Q_INVOKABLE void flurryLogEvent(QString value);

    Q_INVOKABLE QString getSetting(const QString &objectName, const QString &defaultValue);
    Q_INVOKABLE void setSetting(const QString &objectName, const QString &inputValue);

    Q_INVOKABLE qint64 getFolderSize(QString folder);
    Q_INVOKABLE QString getHomePath();
    Q_INVOKABLE QString getTempPath();
    Q_INVOKABLE bool wipeFolderContents(const QString &folder);
    Q_INVOKABLE bool wipeFolder(const QString &folder);
    Q_INVOKABLE void copyAndRemove(QString from, QString to);
    Q_INVOKABLE void deleteFile(QString fileName);

    Q_INVOKABLE void copyToClipboard(QByteArray data);
    Q_INVOKABLE int getDisplayHeight();
    Q_INVOKABLE int getDisplayWidth();

    Q_INVOKABLE void inviteUserToDownloadViaBBM();
    Q_INVOKABLE void updatePersonalMessage(const QString &message);

    Q_INVOKABLE QString regex(QString text, QString expression, int index);

private slots:

    void onSystemLanguageChanged();

private:

    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;

    bb::platform::bbm::UserProfile * m_userProfile;
    bb::platform::bbm::Context *m_context;
    bb::platform::bbm::MessageService *m_messageService;
    Q_SLOT void registrationStateUpdated(bb::platform::bbm::RegistrationState::Type state);

};

#endif /* ApplicationUI_HPP_ */
