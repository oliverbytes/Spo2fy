/****************************************************************************
** Meta object code from reading C++ file 'NemAPI.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/NemAPI/NemAPI.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'NemAPI.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_NemAPI[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      35,    8,    7,    7, 0x05,

 // slots: signature, parameters, type, tag, flags
      69,    7,    7,    7, 0x0a,

 // methods: signature, parameters, type, tag, flags
      89,   82,    7,    7, 0x02,
     116,   82,    7,    7, 0x02,
     137,   82,    7,    7, 0x02,
     172,  167,  159,    7, 0x02,
     190,   82,    7,    7, 0x02,
     237,  213,  159,    7, 0x02,
     287,  265,    7,    7, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_NemAPI[] = {
    "NemAPI\0\0response,httpcode,endpoint\0"
    "complete(QString,QString,QString)\0"
    "onComplete()\0params\0getRequestNemory(QVariant)\0"
    "getRequest(QVariant)\0postRequest(QVariant)\0"
    "QString\0time\0timeSince(qint64)\0"
    "refreshToken(QVariant)\0objectName,defaultValue\0"
    "getSetting(QString,QString)\0"
    "objectName,inputValue\0setSetting(QString,QString)\0"
};

void NemAPI::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        NemAPI *_t = static_cast<NemAPI *>(_o);
        switch (_id) {
        case 0: _t->complete((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 1: _t->onComplete(); break;
        case 2: _t->getRequestNemory((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 3: _t->getRequest((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 4: _t->postRequest((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 5: { QString _r = _t->timeSince((*reinterpret_cast< qint64(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 6: _t->refreshToken((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 7: { QString _r = _t->getSetting((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 8: _t->setSetting((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData NemAPI::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject NemAPI::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_NemAPI,
      qt_meta_data_NemAPI, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &NemAPI::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *NemAPI::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *NemAPI::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_NemAPI))
        return static_cast<void*>(const_cast< NemAPI*>(this));
    return QObject::qt_metacast(_clname);
}

int NemAPI::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    }
    return _id;
}

// SIGNAL 0
void NemAPI::complete(QString _t1, QString _t2, QString _t3)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_END_MOC_NAMESPACE
