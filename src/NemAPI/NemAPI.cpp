#include "NemAPI.hpp"

#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrl>
#include <QtNetwork/QtNetwork>
#include <QtCore/QtCore>
#include <QtGui/QtGui>

#include <bb/data/JsonDataAccess>

using bb::data::JsonDataAccess;


const QString CONTENT_TYPE 			= "application/json; charset=utf-8";
const QString ACCEPT_LANGUAGE       = "en;q=1, en;q=0.9";
const QString ACCEPT_LOCALE         = "en_US";

const QString CLIENT_ID             = "9572fbd8aa8744e1923798aae760355a";
const QString CLIENT_SECRET         = "f27cb59dba7747119a75ce01217a2188";

#define ARRAY_SIZE(arr) ((sizeof(arr))/(sizeof(arr[0])))

NemAPI::NemAPI(QObject* parent) : QObject(parent)
{

}


void NemAPI::refreshToken(QVariant params)
{
    QVariantMap paramsMap   = params.toMap();

    QString theurl          = paramsMap.value("url").toString();
    QString endpoint        = paramsMap.value("endpoint").toString();
    QString data            = paramsMap.value("data").toString();

    QNetworkRequest request;
    request.setUrl(QUrl(theurl));

    QString clientIDandSecret = CLIENT_ID + ":" + CLIENT_SECRET;

    QString bearerAccessToken = "Basic " + clientIDandSecret.toUtf8().toBase64();

    qDebug() << "**** BASE 64: " + bearerAccessToken;

    request.setRawHeader("Authorization", bearerAccessToken.toAscii());
    request.setHeader(QNetworkRequest::ContentTypeHeader, CONTENT_TYPE);

    QUrl dataToSend;

    dataToSend.addQueryItem("grant_type", paramsMap.value("grant_type").toString());
    dataToSend.addQueryItem("refresh_token", paramsMap.value("refresh_token").toString());

    QNetworkReply* reply = networkAccessManager.post(request, dataToSend.encodedQuery());
    reply->setProperty("endpoint", endpoint);
    connect (reply, SIGNAL(finished()), this, SLOT(onComplete()));
}

void NemAPI::postRequest(QVariant params)
{
    QVariantMap paramsMap   = params.toMap();

    QString theurl          = paramsMap.value("url").toString();
    QString endpoint        = paramsMap.value("endpoint").toString();
    QString data            = paramsMap.value("data").toString();

    QNetworkRequest request;
    request.setUrl(QUrl(theurl));

    QString bearerAccessToken = "Bearer " + getSetting("access_token", "");
    request.setRawHeader("Authorization", bearerAccessToken.toAscii());
    request.setHeader(QNetworkRequest::ContentTypeHeader, CONTENT_TYPE);

    QNetworkReply* reply = networkAccessManager.post(request, data.toAscii());
    reply->setProperty("endpoint", endpoint);
    connect (reply, SIGNAL(finished()), this, SLOT(onComplete()));
}

void NemAPI::getRequestNemory(QVariant params)
{
    QVariantMap paramsMap   = params.toMap();

    QString endpoint        = paramsMap.value("endpoint").toString();
    QString theurl          = paramsMap.value("url").toString();

    QNetworkRequest request;
    request.setUrl(QUrl(theurl));
    request.setRawHeader("Accept-Language", ACCEPT_LANGUAGE.toAscii());
    request.setRawHeader("Accept-Locale", ACCEPT_LOCALE.toAscii());
    request.setHeader(QNetworkRequest::ContentTypeHeader, CONTENT_TYPE);

    QNetworkReply* reply = networkAccessManager.get(request);
    reply->setProperty("endpoint", endpoint);
    connect (reply, SIGNAL(finished()), this, SLOT(onComplete()));
}

void NemAPI::getRequest(QVariant params)
{
	QVariantMap paramsMap 	= params.toMap();

	QString theurl			= paramsMap.value("url").toString();
	QString endpoint		= paramsMap.value("endpoint").toString();

	QNetworkRequest request;
	request.setUrl(QUrl(theurl));

    QString bearerAccessToken = "Bearer " + getSetting("access_token", "");
    request.setRawHeader("Authorization", bearerAccessToken.toAscii());

    qDebug() << "**** FULL URL: " + theurl;

	QNetworkReply* reply = networkAccessManager.get(request);
	reply->setProperty("endpoint", endpoint);
	connect (reply, SIGNAL(finished()), this, SLOT(onComplete()));
}

void NemAPI::onComplete()
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

QString NemAPI::timeSince(qint64 time)
{
   QString periods[] = {"second", "minute", "hour", "day", "week", "month", "year", "decade"};

   int lengths[] = {60, 60, 24, 7, 4.35, 12, 10};

   qint64 now = QDateTime::currentMSecsSinceEpoch() / 1000;

   qint64 difference     = now - (time / 1000);
   QString tense         = "ago";

   int j = 0;

   for(j = 0; difference >= lengths[j] && j < ARRAY_SIZE(lengths) - 1; j++)
   {
	   difference /= lengths[j];
   }

   difference = qRound(difference);

   if(difference != 1)
   {
	   periods[j] += "s";
   }

   return QString::number(difference) + " " + periods[j] + " " + tense;
}

QString NemAPI::getSetting(const QString &objectName, const QString &defaultValue)
{
	QSettings settings("NEMORY", "SPO2FY");

	if (settings.value(objectName).isNull() || settings.value(objectName) == "")
	{
		return defaultValue;
	}

	return settings.value(objectName).toString();
}

void NemAPI::setSetting(const QString &objectName, const QString &inputValue)
{
	QSettings settings("NEMORY", "SPO2FY");
	settings.setValue(objectName, QVariant(inputValue));
}
