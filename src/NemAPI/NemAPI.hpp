#ifndef NEMAPI_H_
#define NEMAPI_H_

#include <QtCore/QObject>
#include <QtNetwork/QNetworkAccessManager>
#include <QtCore/QVariant>
#include <QtCore/QFile>
#include <QtCore/QtCore>

class NemAPI : public QObject
{
    Q_OBJECT

public:
    NemAPI(QObject* parent = 0);

    Q_INVOKABLE void getRequestNemory(QVariant params);
    Q_INVOKABLE void getRequest(QVariant params);
    Q_INVOKABLE void postRequest(QVariant params);
    Q_INVOKABLE QString timeSince(qint64 time);

    Q_INVOKABLE void refreshToken(QVariant params);

    Q_INVOKABLE QString getSetting(const QString &objectName, const QString &defaultValue);
	Q_INVOKABLE void setSetting(const QString &objectName, const QString &inputValue);

Q_SIGNALS:

    void complete(QString response, QString httpcode, QString endpoint);

private Q_SLOTS:


public slots:

	void onComplete();

private :

    QNetworkAccessManager networkAccessManager;
};

#endif /* NEMAPI_H_ */

