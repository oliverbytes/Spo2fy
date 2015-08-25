/****************************************************************************
** Meta object code from reading C++ file 'applicationui.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/applicationui.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'applicationui.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ApplicationUI[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      22,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      15,   14,   14,   14, 0x08,
      47,   41,   14,   14, 0x08,

 // methods: signature, parameters, type, tag, flags
     131,  121,  116,   14, 0x02,
     161,  157,   14,   14, 0x02,
     191,  185,   14,   14, 0x02,
     216,  185,   14,   14, 0x02,
     240,  185,   14,   14, 0x02,
     296,  272,  264,   14, 0x02,
     346,  324,   14,   14, 0x02,
     388,  381,  374,   14, 0x02,
     411,   14,  264,   14, 0x02,
     425,   14,  264,   14, 0x02,
     439,  381,  116,   14, 0x02,
     467,  381,  116,   14, 0x02,
     495,  487,   14,   14, 0x02,
     535,  526,   14,   14, 0x02,
     560,  555,   14,   14, 0x02,
     592,   14,  588,   14, 0x02,
     611,   14,  588,   14, 0x02,
     629,   14,   14,   14, 0x02,
     666,  658,   14,   14, 0x02,
     719,  697,  264,   14, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_ApplicationUI[] = {
    "ApplicationUI\0\0onSystemLanguageChanged()\0"
    "state\0"
    "registrationStateUpdated(bb::platform::bbm::RegistrationState::Type)\0"
    "bool\0text,find\0contains(QString,QString)\0"
    "log\0writeLogToFile(QString)\0value\0"
    "flurrySetUserID(QString)\0"
    "flurryLogError(QString)\0flurryLogEvent(QString)\0"
    "QString\0objectName,defaultValue\0"
    "getSetting(QString,QString)\0"
    "objectName,inputValue\0setSetting(QString,QString)\0"
    "qint64\0folder\0getFolderSize(QString)\0"
    "getHomePath()\0getTempPath()\0"
    "wipeFolderContents(QString)\0"
    "wipeFolder(QString)\0from,to\0"
    "copyAndRemove(QString,QString)\0fileName\0"
    "deleteFile(QString)\0data\0"
    "copyToClipboard(QByteArray)\0int\0"
    "getDisplayHeight()\0getDisplayWidth()\0"
    "inviteUserToDownloadViaBBM()\0message\0"
    "updatePersonalMessage(QString)\0"
    "text,expression,index\0regex(QString,QString,int)\0"
};

void ApplicationUI::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ApplicationUI *_t = static_cast<ApplicationUI *>(_o);
        switch (_id) {
        case 0: _t->onSystemLanguageChanged(); break;
        case 1: _t->registrationStateUpdated((*reinterpret_cast< bb::platform::bbm::RegistrationState::Type(*)>(_a[1]))); break;
        case 2: { bool _r = _t->contains((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 3: _t->writeLogToFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 4: _t->flurrySetUserID((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 5: _t->flurryLogError((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 6: _t->flurryLogEvent((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 7: { QString _r = _t->getSetting((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 8: _t->setSetting((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 9: { qint64 _r = _t->getFolderSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< qint64*>(_a[0]) = _r; }  break;
        case 10: { QString _r = _t->getHomePath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 11: { QString _r = _t->getTempPath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 12: { bool _r = _t->wipeFolderContents((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 13: { bool _r = _t->wipeFolder((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 14: _t->copyAndRemove((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 15: _t->deleteFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 16: _t->copyToClipboard((*reinterpret_cast< QByteArray(*)>(_a[1]))); break;
        case 17: { int _r = _t->getDisplayHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 18: { int _r = _t->getDisplayWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 19: _t->inviteUserToDownloadViaBBM(); break;
        case 20: _t->updatePersonalMessage((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 21: { QString _r = _t->regex((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ApplicationUI::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ApplicationUI::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ApplicationUI,
      qt_meta_data_ApplicationUI, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ApplicationUI::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ApplicationUI::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ApplicationUI::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ApplicationUI))
        return static_cast<void*>(const_cast< ApplicationUI*>(this));
    return QObject::qt_metacast(_clname);
}

int ApplicationUI::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 22)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 22;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
