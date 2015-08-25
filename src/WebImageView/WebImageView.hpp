#ifndef WEBIMAGEVIEW_HPP_
#define WEBIMAGEVIEW_HPP_

#include <bb/cascades/ImageView>
#include <qt4/QtNetwork/QNetworkAccessManager>
#include <qt4/QtCore/qurl.h>
#include <qt4/QtCore/qobject.h>

using namespace bb::cascades;

class WebImageView: public bb::cascades::ImageView {
	Q_OBJECT
	Q_PROPERTY (QUrl url READ url WRITE setUrl NOTIFY urlChanged)
	Q_PROPERTY (float loading READ loading WRITE setLoading NOTIFY loadingChanged)
	Q_PROPERTY (QUrl defaultImage READ defaultImage WRITE setDefaultImage NOTIFY defaultImageChanged)
	Q_PROPERTY (bool ready READ ready NOTIFY readyChanged)
public:
	WebImageView(bb::cascades::Container *parent = 0);
	const QUrl& url() const;
	const QUrl& defaultImage() const;
	double loading() const;
	bool ready();

public slots:
	void setUrl(const QUrl url);
	void setDefaultImage(const QUrl url);
	void setLoading(const float loading);

private slots:
	void imageLoaded();
	void downloadProgressed(qint64,qint64);
	void setReady(bool ready);

signals:
	void urlChanged();
	void defaultImageChanged();
	void loadingChanged();
	void readyChanged();
	void theImageLoaded();

private:
	static QNetworkAccessManager * mNetManager;
	QUrl mUrl;
	QList<QUrl> urls;
	QList<QNetworkReply* > replys;
	QUrl defaultImageUrl;
	float mLoading;
	bool mReady;
	QString cacheLocation;
};

Q_DECLARE_METATYPE(WebImageView *);

#endif
