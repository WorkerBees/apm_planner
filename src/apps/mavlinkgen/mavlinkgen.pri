# Third-party includes.
# if you include this file with the commands below into
# your Qt project, you can enable your application
# to generate MAVLink code easily.

###### EXAMPLE BEGIN

## Include MAVLink generator
#DEPENDPATH += \
#    src/apps/mavlinkgen
#
#INCLUDEPATH += \
#    src/apps/mavlinkgen
#    src/apps/mavlinkgen/ui \
#    src/apps/mavlinkgen/generator
#
#include(src/apps/mavlinkgen/mavlinkgen.pri)

###### EXAMPLE END



INCLUDEPATH += .\
    src/apps/mavlinkgen/ui \
    src/apps/mavlinkgen/generator

FORMS += src/apps/mavlinkgen/ui/XMLCommProtocolWidget.ui

HEADERS += \
    src/apps/mavlinkgen/ui/XMLCommProtocolWidget.h \
    src/apps/mavlinkgen/generator/MAVLinkXMLParser.h \
    src/apps/mavlinkgen/generator/MAVLinkXMLParserV10.h \
    src/apps/mavlinkgen/ui/DomItem.h \
    src/apps/mavlinkgen/ui/DomModel.h \
    src/apps/mavlinkgen/ui/QGCMAVLinkTextEdit.h
SOURCES += \
    src/apps/mavlinkgen/ui/XMLCommProtocolWidget.cc \
    src/apps/mavlinkgen/ui/DomItem.cc \
    src/apps/mavlinkgen/ui/DomModel.cc \
    src/apps/mavlinkgen/generator/MAVLinkXMLParser.cc \
    src/apps/mavlinkgen/generator/MAVLinkXMLParserV10.cc \
    src/apps/mavlinkgen/ui/QGCMAVLinkTextEdit.cc

RESOURCES += src/apps/mavlinkgen/mavlinkgen.qrc
