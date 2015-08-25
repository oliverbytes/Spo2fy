/****************************************************************************
** Meta object code from reading C++ file 'Downloader.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/Downloader/Downloader.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Downloader.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Downloader[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       3,   59, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: signature, parameters, type, tag, flags
      12,   11,   11,   11, 0x05,
      35,   11,   11,   11, 0x05,
      58,   11,   11,   11, 0x05,
      83,   11,   11,   11, 0x05,
      98,   11,   11,   11, 0x05,

 // slots: signature, parameters, type, tag, flags
     137,  112,   11,   11, 0x08,
     169,   11,   11,   11, 0x08,
     188,   11,   11,   11, 0x08,

 // methods: signature, parameters, type, tag, flags
     238,  208,   11,   11, 0x02,

 // properties: name, type, flags
     284,  280, 0x02495001,
     298,  280, 0x02495001,
     320,  312, 0x0a495001,

 // properties: notify_signal_id
       0,
       1,
       2,

       0        // eod
};

static const char qt_meta_stringdata_Downloader[] = {
    "Downloader\0\0progressTotalChanged()\0"
    "progressValueChanged()\0progressMessageChanged()\0"
    "downloadDone()\0retrySignal()\0"
    "bytesReceived,bytesTotal\0"
    "downloadProgress(qint64,qint64)\0"
    "downloadFinished()\0downloadReadyRead()\0"
    "url,id,media_type,snapORstory\0"
    "download(QString,QString,QString,QString)\0"
    "int\0progressTotal\0progressValue\0QString\0"
    "progressMessage\0"
};

void Downloader::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        Downloader *_t = static_cast<Downloader *>(_o);
        switch (_id) {
        case 0: _t->progressTotalChanged(); break;
        case 1: _t->progressValueChanged(); break;
        case 2: _t->progressMessageChanged(); break;
        case 3: _t->downloadDone(); break;
        case 4: _t->retrySignal(); break;
        case 5: _t->downloadProgress((*reinterpret_cast< qint64(*)>(_a[1])),(*reinterpret_cast< qint64(*)>(_a[2]))); break;
        case 6: _t->downloadFinished(); break;
        case 7: _t->downloadReadyRead(); break;
        case 8: _t->download((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData Downloader::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject Downloader::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Downloader,
      qt_meta_data_Downloader, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Downloader::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Downloader::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Downloader::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Downloader))
        return static_cast<void*>(const_cast< Downloader*>(this));
    return QObject::qt_metacast(_clname);
}

int Downloader::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = progressTotal(); break;
        case 1: *reinterpret_cast< int*>(_v) = progressValue(); break;
        case 2: *reinterpret_cast< QString*>(_v) = progressMessage(); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::WriteProperty) {
        _id -= 3;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void Downloader::progressTotalChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void Downloader::progressValueChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void Downloader::progressMessageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void Downloader::downloadDone()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void Downloader::retrySignal()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}
QT_END_MOC_NAMESPACE
