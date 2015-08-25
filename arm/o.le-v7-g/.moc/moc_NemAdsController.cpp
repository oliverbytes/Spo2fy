/****************************************************************************
** Meta object code from reading C++ file 'NemAdsController.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/NemAdvertisements/NemAdsController.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'NemAdsController.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_NemAdsController[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      45,   18,   17,   17, 0x05,

 // slots: signature, parameters, type, tag, flags
      79,   17,   17,   17, 0x0a,

 // methods: signature, parameters, type, tag, flags
      99,   92,   17,   17, 0x02,
     120,   92,   17,   17, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_NemAdsController[] = {
    "NemAdsController\0\0response,httpcode,endpoint\0"
    "complete(QString,QString,QString)\0"
    "onComplete()\0params\0getRequest(QVariant)\0"
    "postRequest(QVariant)\0"
};

void NemAdsController::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        NemAdsController *_t = static_cast<NemAdsController *>(_o);
        switch (_id) {
        case 0: _t->complete((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 1: _t->onComplete(); break;
        case 2: _t->getRequest((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 3: _t->postRequest((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData NemAdsController::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject NemAdsController::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_NemAdsController,
      qt_meta_data_NemAdsController, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &NemAdsController::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *NemAdsController::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *NemAdsController::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_NemAdsController))
        return static_cast<void*>(const_cast< NemAdsController*>(this));
    return QObject::qt_metacast(_clname);
}

int NemAdsController::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void NemAdsController::complete(QString _t1, QString _t2, QString _t3)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_END_MOC_NAMESPACE
