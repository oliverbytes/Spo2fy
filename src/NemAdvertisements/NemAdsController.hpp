#ifndef NEMADSCONTROLLER_H_
#define NEMADSCONTROLLER_H_

#include <QtCore/QObject>
#include <QVariant>
#include <QtNetwork/QNetworkAccessManager>

class NemAdsController : public QObject
{
    Q_OBJECT

public:
    NemAdsController(QObject* parent = 0);

    Q_INVOKABLE void getRequest(QVariant params);
    Q_INVOKABLE void postRequest(QVariant params);

Q_SIGNALS:

    void complete(QString response, QString httpcode, QString endpoint);

public slots:

	void onComplete();

private :

    QNetworkAccessManager networkAccessManager;
};

#endif /* NEMADSCONTROLLER_H_ */

