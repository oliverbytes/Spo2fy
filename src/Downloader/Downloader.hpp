#ifndef DOWNLOADER_HPP
#define DOWNLOADER_HPP

#include <QtCore/QFile>
#include <QtCore/QObject>
#include <QtCore/QStringList>
#include <QtCore/QTime>
#include <QtCore/QUrl>
#include <QtNetwork/QNetworkAccessManager>

class QNetworkReply;

class Downloader : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int progressTotal READ progressTotal NOTIFY progressTotalChanged)
    Q_PROPERTY(int progressValue READ progressValue NOTIFY progressValueChanged)
    Q_PROPERTY(QString progressMessage READ progressMessage NOTIFY progressMessageChanged)

public:
    Downloader(QObject *parent = 0);

    Q_INVOKABLE void download(QString url, QString id, QString media_type, QString snapORstory);

    int progressTotal() const;
    int progressValue() const;
    QString progressMessage() const;

signals:
	void progressTotalChanged();
	void progressValueChanged();
	void progressMessageChanged();
	void downloadDone();

Q_SIGNALS:
	void retrySignal();

public Q_SLOTS:

private Q_SLOTS:

    void downloadProgress(qint64 bytesReceived, qint64 bytesTotal);
    void downloadFinished();
    void downloadReadyRead();

private:
    QNetworkAccessManager m_manager;
    QNetworkReply *m_currentDownload;
    QFile m_output;
    QTime m_downloadTime;

    int m_downloadedCount;
    int m_totalCount;
    int m_progressTotal;
    int m_progressValue;

    QString m_progressMessage;
};

#endif
