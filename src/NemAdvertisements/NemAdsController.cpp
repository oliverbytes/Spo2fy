#include "NemAdsController.hpp"

#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrl>
#include <QtNetwork/QtNetwork>

const QString ACCEPT_LANGUAGE       = "en;q=1, en;q=0.9";
const QString ACCEPT_LOCALE         = "en_US";
const QString CONTENT_TYPE          = "application/x-www-form-urlencoded";
const QString USER_AGENT            = "Snapchat/4.1.07 (SAMSUNG-SGH-I747; Android 19; gzip)";

const QString HOSTNAME              = "http://nemorystudios.com";
const QString CLICK_BASEURL         = HOSTNAME + "/advertisements/includes/webservices/clicked.php?id=";
const QString ADS_BASEURL           = HOSTNAME + "/advertisements/includes/webservices/get.php?object=advertisement&userid=";

#define ARRAY_SIZE(arr) ((sizeof(arr))/(sizeof(arr[0])))

NemAdsController::NemAdsController(QObject* parent) : QObject(parent)
{

}

void NemAdsController::postRequest(QVariant params)
{
    QVariantMap paramsMap   = params.toMap();

    QString theurl          = paramsMap.value("url").toString();
    QString endpoint        = paramsMap.value("endpoint").toString();
    QString data            = paramsMap.value("data").toString();

    QNetworkRequest request;
    request.setUrl(QUrl(theurl));
    request.setRawHeader("Accept-Language", ACCEPT_LANGUAGE.toAscii());
    request.setRawHeader("Accept-Locale", ACCEPT_LOCALE.toAscii());
    request.setHeader(QNetworkRequest::ContentTypeHeader, CONTENT_TYPE);
    request.setRawHeader("User-Agent", USER_AGENT.toAscii());

    QNetworkReply* reply = networkAccessManager.post(request, data.toAscii());
    reply->setProperty("endpoint", endpoint);
    connect (reply, SIGNAL(finished()), this, SLOT(onComplete()));
}

void NemAdsController::getRequest(QVariant params)
{
	QVariantMap paramsMap 	= params.toMap();

	QString endpoint		= paramsMap.value("endpoint").toString();
	QString data            = paramsMap.value("data").toString();

	QString theurl          = "";

	if(endpoint == "load")
	{
	    theurl = ADS_BASEURL;
	}
	else if(endpoint == "clicked")
    {
        theurl = CLICK_BASEURL;
    }

	QNetworkRequest request;
	request.setUrl(QUrl(theurl + data));
    request.setRawHeader("Accept-Language", ACCEPT_LANGUAGE.toAscii());
    request.setRawHeader("Accept-Locale", ACCEPT_LOCALE.toAscii());
    request.setHeader(QNetworkRequest::ContentTypeHeader, CONTENT_TYPE);
    request.setRawHeader("User-Agent", USER_AGENT.toAscii());

	QNetworkReply* reply = networkAccessManager.get(request);
	reply->setProperty("endpoint", endpoint);
	connect (reply, SIGNAL(finished()), this, SLOT(onComplete()));
}

void NemAdsController::onComplete()
{
	QNetworkReply* reply 	= qobject_cast<QNetworkReply*>(sender());
	int status 				= reply->attribute( QNetworkRequest::HttpStatusCodeAttribute ).toInt();
	QString reason 			= reply->attribute( QNetworkRequest::HttpReasonPhraseAttribute ).toString();

	QString response;

	if (reply)
	{
		if (reply->error() == QNetworkReply::NoError)
		{
			const int available = reply->bytesAvailable();

			if (available > 0)
			{
				const QByteArray buffer(reply->readAll());
				response = QString::fromUtf8(buffer);
			}
		}
		else
		{
			response = "error";
		}

		reply->deleteLater();
	}

	if (response.trimmed().isEmpty())
	{
		response = "error";
	}

	if(QString::number(status) == "200")
	{
		response = ((response.length() > 0 && response != "error") ? response : QString::number(status));
	}
	else
	{
		response = QString::number(status);
	}

	emit complete(response, QString::number(status), reply->property("endpoint").toString());
}
