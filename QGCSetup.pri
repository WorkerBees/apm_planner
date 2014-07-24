# -------------------------------------------------
# QGroundControl - Micro Air Vehicle Groundstation
# Please see our website at <http://qgroundcontrol.org>
# Maintainer:
# Lorenz Meier <lm@inf.ethz.ch>
# (c) 2009-2011 QGroundControl Developers
# This file is part of the open groundstation project
# QGroundControl is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# QGroundControl is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with QGroundControl. If not, see <http://www.gnu.org/licenses/>.
# -------------------------------------------------

QMAKE_POST_LINK += $$quote(echo "Copying files")

#
# Copy the application resources to the associated place alongside the application
#

COPY_RESOURCE_LIST = \
    $$BASEDIR/files \
    $$BASEDIR/qml \
    $$BASEDIR/data

WindowsBuild {
	DESTDIR_COPY_RESOURCE_LIST = $$replace(DESTDIR,"/","\\")
    COPY_RESOURCE_LIST = $$replace(COPY_RESOURCE_LIST, "/","\\")
    CONCATCMD = $$escape_expand(\\n)
}

LinuxBuild {
    DESTDIR_COPY_RESOURCE_LIST = $$DESTDIR
    CONCATCMD = &&
}

MacBuild {
    DESTDIR_COPY_RESOURCE_LIST = $$DESTDIR/$${TARGET}.app/Contents/MacOS
    CONCATCMD = &&
}

for(COPY_DIR, COPY_RESOURCE_LIST):QMAKE_POST_LINK += $$CONCATCMD $$QMAKE_COPY_DIR $${COPY_DIR} $$DESTDIR_COPY_RESOURCE_LIST

#
# Perform platform specific setup
#

MacBuild {
	# Copy non-standard libraries and frameworks into app package
    QMAKE_POST_LINK += && $$QMAKE_COPY_DIR $$BASEDIR/libs/lib/mac64/lib $$DESTDIR/$${TARGET}.app/Contents/libs
    QMAKE_POST_LINK += && $$QMAKE_COPY_DIR -L $$BASEDIR/libs/lib/Frameworks $$DESTDIR/$${TARGET}.app/Contents/Frameworks

	# Fix library paths inside executable

    QMAKE_POST_LINK += && install_name_tool -add_rpath "@executable_path/../libs" $$DESTDIR/$${TARGET}.app/Contents/MacOS/$${TARGET}

	# Fix library paths within libraries (inter-library dependencies)

    # Main osg libs
    INSTALL_NAME_LIB_LIST = \
        libOpenThreads.dylib \
        libosg.dylib \
        libosgAnimation.dylib \
        libosgDB.dylib \
        libosgFX.dylib \
        libosgGA.dylib \
        libosgManipulator.dylib \
        libosgParticle.dylib \
        libosgPresentation.dylib \
        libosgShadow.dylib \
        libosgSim.dylib \
        libosgTerrain.dylib \
        libosgText.dylib \
        libosgUtil.dylib \
        libosgViewer.dylib \
        libosgVolume.dylib \
        libosgWidget.dylib
    for(INSTALL_NAME_LIB, INSTALL_NAME_LIB_LIST) {
        QMAKE_POST_LINK += && install_name_tool -add_rpath "@executable_path/../libs" $$DESTDIR/$${TARGET}.app/Contents/libs/$$INSTALL_NAME_LIB
    }

    # osg plugins
    INSTALL_NAME_LIB_LIST = \
        osgdb_3dc.so \
        osgdb_3ds.so \
        osgdb_ac.so \
        osgdb_bmp.so \
        osgdb_bsp.so \
        osgdb_bvh.so \
        osgdb_cfg.so \
        osgdb_curl.so \
        osgdb_dds.so \
        osgdb_deprecated_osg.so \
        osgdb_deprecated_osganimation.so \
        osgdb_deprecated_osgfx.so \
        osgdb_deprecated_osgparticle.so \
        osgdb_deprecated_osgshadow.so \
        osgdb_deprecated_osgsim.so \
        osgdb_deprecated_osgterrain.so \
        osgdb_deprecated_osgtext.so \
        osgdb_deprecated_osgviewer.so \
        osgdb_deprecated_osgvolume.so \
        osgdb_deprecated_osgwidget.so \
        osgdb_dot.so \
        osgdb_dw.so \
        osgdb_dxf.so \
        osgdb_freetype.so \
        osgdb_glsl.so \
        osgdb_gz.so \
        osgdb_hdr.so \
        osgdb_imageio.so \
        osgdb_ive.so \
        osgdb_jp2.so \
        osgdb_ktx.so \
        osgdb_logo.so \
        osgdb_lwo.so \
        osgdb_lws.so \
        osgdb_md2.so \
        osgdb_mdl.so \
        osgdb_normals.so \
        osgdb_obj.so \
        osgdb_openflight.so \
        osgdb_osc.so \
        osgdb_osg.so \
        osgdb_osga.so \
        osgdb_osgshadow.so \
        osgdb_osgterrain.so \
        osgdb_osgtgz.so \
        osgdb_osgviewer.so \
        osgdb_p3d.so \
        osgdb_pdf.so \
        osgdb_pic.so \
        osgdb_ply.so \
        osgdb_pnm.so \
        osgdb_pov.so \
        osgdb_pvr.so \
        osgdb_revisions.so \
        osgdb_rgb.so \
        osgdb_rot.so \
        osgdb_scale.so \
        osgdb_sdl.so \
        osgdb_serializers_osg.so \
        osgdb_serializers_osganimation.so \
        osgdb_serializers_osgfx.so \
        osgdb_serializers_osgga.so \
        osgdb_serializers_osgmanipulator.so \
        osgdb_serializers_osgparticle.so \
        osgdb_serializers_osgshadow.so \
        osgdb_serializers_osgsim.so \
        osgdb_serializers_osgterrain.so \
        osgdb_serializers_osgtext.so \
        osgdb_serializers_osgviewer.so \
        osgdb_serializers_osgvolume.so \
        osgdb_shp.so \
        osgdb_stl.so \
        osgdb_svg.so \
        osgdb_tga.so \
        osgdb_tgz.so \
        osgdb_tiff.so \
        osgdb_trans.so \
        osgdb_trk.so \
        osgdb_txf.so \
        osgdb_txp.so \
        osgdb_vtf.so \
        osgdb_x.so \
        osgdb_zeroconf.so \
        osgdb_zip.so
    for(INSTALL_NAME_LIB, INSTALL_NAME_LIB_LIST) {
        QMAKE_POST_LINK += && install_name_tool -add_rpath "@executable_path/../libs" $$DESTDIR/$${TARGET}.app/Contents/libs/osgPlugins-3.2.1/$$INSTALL_NAME_LIB
    }

    # SDL Framework
    QMAKE_POST_LINK += && install_name_tool -change "@rpath/SDL.framework/Versions/A/SDL" "@executable_path/../Frameworks/SDL.framework/Versions/A/SDL" $$DESTDIR/$${TARGET}.app/Contents/MacOS/$${TARGET}

}

WindowsBuild {
	# Copy dependencies
	BASEDIR_WIN = $$replace(BASEDIR,"/","\\")
	DESTDIR_WIN = $$replace(DESTDIR,"/","\\")

    QMAKE_POST_LINK += $$escape_expand(\\n) $$quote($$QMAKE_COPY_DIR "$$(QTDIR)\\plugins" "$$DESTDIR_WIN")

    COPY_FILE_DESTDIR = $$DESTDIR_WIN
	DebugBuild: DLL_QT_DEBUGCHAR = "d"
    ReleaseBuild: DLL_QT_DEBUGCHAR = ""
    COPY_FILE_LIST = \
        $$BASEDIR_WIN\\libs\\lib\\sdl\\win32\\SDL.dll \
        $$BASEDIR_WIN\\libs\\thirdParty\\libxbee\\lib\\libxbee.dll \
        $$(QTDIR)\\bin\\phonon$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtCore$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtGui$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtMultimedia$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtNetwork$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtOpenGL$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtSql$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtSvg$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtTest$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtWebKit$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtXml$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtXmlPatterns$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtDeclarative$${DLL_QT_DEBUGCHAR}4.dll \
        $$(QTDIR)\\bin\\QtScript$${DLL_QT_DEBUGCHAR}4.dll
    for(COPY_FILE, COPY_FILE_LIST) {
        QMAKE_POST_LINK += $$escape_expand(\\n) $$quote($$QMAKE_COPY "$$COPY_FILE" "$$COPY_FILE_DESTDIR")
    }

	ReleaseBuild {
		QMAKE_POST_LINK += $$escape_expand(\\n) $$quote(del /F "$$DESTDIR_WIN\\$${TARGET}.exp")

		# Copy Visual Studio DLLs
		# Note that this is only done for release because the debugging versions of these DLLs cannot be redistributed.
		# I'm not certain of the path for VS2008, so this only works for VS2010.
		win32-msvc2010 {
			QMAKE_POST_LINK += $$escape_expand(\\n) $$quote(xcopy /D /Y "\"C:\\Program Files \(x86\)\\Microsoft Visual Studio 10.0\\VC\\redist\\x86\\Microsoft.VC100.CRT\\*.dll\""  "$$DESTDIR_WIN\\")
		}
	}
}

LinuxBuild {
        #Installer section
        BINDIR = $$PREFIX/bin
        DATADIR =$$PREFIX/share

        DEFINES += DATADIR=\\\"$$DATADIR\\\" PKGDATADIR=\\\"$$PKGDATADIR\\\"

        #MAKE INSTALL - copy files
        INSTALLS += target datafiles desktopLink menuLink permFolders permFiles

        target.path =$$BINDIR

        datafiles.path = $$DATADIR/APMPlanner2
        datafiles.files += $$BASEDIR/files
        datafiles.files += $$BASEDIR/data
        datafiles.files += $$BASEDIR/qml

        #fix up file permissions. Bit of a hack job
        #permFolders.path = $$DATADIR/APMPlanner2
        #permFolders.commands += find $$DATADIR -type d -exec chmod 755 {} \\;
        #permFiles.path = $$DATADIR/APMPlanner2
        #permFiles.commands += find $$DATADIR -type f -exec chmod 644 {} \\;

        #create menu links
        desktopLink.path = $$DATADIR/menu
        desktopLink.files += $$BASEDIR/debian/apmplanner2
        menuLink.path = $$DATADIR/applications
        menuLink.files += $$BASEDIR/debian/apmplanner2.desktop
}
