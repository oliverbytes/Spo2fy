#include "Downloader.hpp"

#include <QtCore/QFileInfo>
#include <QtCore/QTimer>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QNetworkRequest>
#include <QtCore/QtCore>

Downloader::Downloader(QObject *parent)
    : QObject(parent), m_currentDownload(0), m_downloadedCount(0), m_totalCount(0), m_progressTotal(0), m_progressValue(0)
{

}

void Downloader::download(QString url, QString id, QString media_type, QString snapORstory)
{
	QString extension = "";
	QString path = "";

	if(snapORstory == "snap" && media_type == "photo") // image and snap
	{
		path = "data/files/snaps/photos/";
		extension = ".jpg";
	}
	else if(snapORstory == "snap" && media_type == "video") // video and snap
	{
		path = "data/files/snaps/videos/";
		extension = ".mp4";
	}
	else if(snapORstory == "story" && media_type == "photo") // image and snap
	{
		path = "data/files/stories/photos/";
		extension = ".jpg";
	}
	else if(snapORstory == "story" && media_type == "video") // video and snap
	{
		path = "data/files/stories/videos/";
		extension = ".mp4";
	}

    const QString filename = path + id + extension;

    if(filename.length() <= 0)
    {
    	emit retrySignal();
    	return;
    }

    m_output.setFileName(filename);

    if (!m_output.open(QIODevice::WriteOnly))
    {
    	qDebug() << "PROBLEM OPENING FILE: " + filename;
    	emit retrySignal();
        return;
    }

    QNetworkRequest request(url);
    m_currentDownload = m_manager.get(request);

    connect(m_currentDownload, SIGNAL(downloadProgress(qint64, qint64)), SLOT(downloadProgress(qint64, qint64)));
    connect(m_currentDownload, SIGNAL(finished()), SLOT(downloadFinished()));
    connect(m_currentDownload, SIGNAL(readyRead()), SLOT(downloadReadyRead()));

    m_downloadTime.start();
}

void Downloader::downloadProgress(qint64 bytesReceived, qint64 bytesTotal)
{
    m_progressTotal = bytesTotal;
    m_progressValue = bytesReceived;
    emit progressTotalChanged();
    emit progressValueChanged();

    double speed = bytesReceived * 1000.0 / m_downloadTime.elapsed();
    QString unit;

    if (speed < 1024)
    {
        unit = "B/s";
    }
    else if (speed < 1024 * 1024)
    {
        speed /= 1024;
        unit = "KB/s";
    }
    else
    {
        speed /= 1024 * 1024;
        unit = "MB/s";
    }

    m_progressMessage = QString("%1 %2").arg(speed, 3, 'f', 1).arg(unit);
    emit progressMessageChanged();
}

void Downloader::downloadFinished()
{
    m_progressTotal = 0;
    m_progressValue = 0;
    m_progressMessage.clear();

    emit progressValueChanged();
    emit progressTotalChanged();
    emit progressMessageChanged();
    emit downloadDone();

    m_output.close();

    m_currentDownload->deleteLater();
    m_currentDownload = 0;
}

void Downloader::downloadReadyRead()
{
	if(m_currentDownload != NULL && m_currentDownload != 0)
	{
		m_output.write(m_currentDownload->readAll());
	}
	else
	{
		m_currentDownload->deleteLater();
		m_currentDownload = 0;
		m_output.close();

		qDebug() << "DOWNLOAD READY READ: NULL";
	}
}

int Downloader::progressTotal() const
{
    return m_progressTotal;
}

int Downloader::progressValue() const
{
    return m_progressValue;
}

QString Downloader::progressMessage() const
{
    return m_progressMessage;
}
