DESCRIPTION = "Weston is the reference implementation of a Wayland compositor. \
This particular version we are using contains the IVI-Shell implementation."
HOMEPAGE = "https://github.com/ntanibata/weston-ivi-shell"

SRCREV = "71019824462597a82e71bee913f12165875e9fd2"

SRC_URI_remove = "http://wayland.freedesktop.org/releases/weston-1.4.0.tar.xz"
SRC_URI_prepend = "git://github.com/ntanibata/weston-ivi-shell.git;branch=weston-ivi-shell-1.4.0-v12;protocol=http "
S = "${WORKDIR}/git"

PR = "r2"

FILES_${PN} += "${libdir}/weston/*"
FILES_${PN}-dbg += "${libdir}/weston/.debug/*"

do_install_append() {
   WESTON_INI_CONFIG=${sysconfdir}/xdg/weston
   install -d ${D}${WESTON_INI_CONFIG}
   install -m 0644 ${S}/ivi-shell/weston.ini.in ${D}${WESTON_INI_CONFIG}/weston.ini
   sed -i -e 's/hmi-controller.so/hmi-controller.so,ivi-controller.so/' \
          -e 's|\@libexecdir\@|${libexecdir}|' \
          -e 's|\@abs_top_builddir\@\/data|${datadir}\/weston|' \
          -e 's|\@abs_top_builddir\@\/clients|${bindir}|' ${D}${WESTON_INI_CONFIG}/weston.ini

}

FILES_${PN} += "${sysconfdir}/xdg"
