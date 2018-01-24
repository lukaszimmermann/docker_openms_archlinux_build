FROM base/archlinux
WORKDIR /
USER root
RUN pacman -Syyu --noconfirm && \
    pacman -S --noconfirm  \
           autoconf \
           automake \
           binutils \
           bison \
           boost \
           bzip2 \
           cmake \
           eigen \
           fakeroot \
           flex \
           gcc \
           git \
           glpk \
           gperf \
           gst-plugins-base-libs \
           make \
           mesa \
           patch \
           pkg-config \
           python2 \
           ruby \
           qt4 \
           sqlite \
           systemd \
           wget \
           xerces-c \
           zlib && \
    mkdir -p /openms && \
    useradd makepkg && \
    chown -R makepkg:makepkg /openms && \
    cd /tmp && \
    wget https://aur.archlinux.org/cgit/aur.git/snapshot/qtwebkit.tar.gz && \
    tar xf qtwebkit.tar.gz && \
    chown -R makepkg:makepkg qtwebkit && \
    cd qtwebkit && \
    su -c 'makepkg' makepkg && \
    pacman -U --noconfirm *pkg.tar.xz && \
    cd /openms && \
    echo '[Desktop Entry]' > OpenMS-TOPPAS.desktop && \
    echo 'Name=OpenMS-TOPPAS' >> OpenMS-TOPPAS.desktop && \
    echo 'GenericName=' >> OpenMS-TOPPAS.desktop && \
    echo 'Comment=Software for LC-MS data management and analyses' >> OpenMS-TOPPAS.desktop && \
    echo 'Exec=TOPPAS' >> OpenMS-TOPPAS.desktop && \
    echo 'Icon=applications-science' >> OpenMS-TOPPAS.desktop && \
    echo 'Type=Application' >> OpenMS-TOPPAS.desktop && \
    echo 'Terminal=false' >> OpenMS-TOPPAS.desktop && \
    echo 'Categories=Science;' >> OpenMS-TOPPAS.desktop && \
    echo 'StartupNotify=false' >> OpenMS-TOPPAS.desktop && \
    echo '[Desktop Entry]' > OpenMS-TOPPView.desktop && \
    echo 'Name=OpenMS-TOPPView' >> OpenMS-TOPPView.desktop && \
    echo 'GenericName=' >> OpenMS-TOPPView.desktop && \
    echo 'Comment=Software for LC-MS data management and analyses' >> OpenMS-TOPPView.desktop && \
    echo 'Exec=TOPPView' >> OpenMS-TOPPView.desktop && \
    echo 'Icon=applications-science' >> OpenMS-TOPPView.desktop && \
    echo 'Terminal=false' >> OpenMS-TOPPView.desktop && \
    echo 'Type=Application' >> OpenMS-TOPPView.desktop && \
    echo 'Categories=Science;' >> OpenMS-TOPPView.desktop && \
    echo 'StartupNotify=false' >> OpenMS-TOPPView.desktop && \
    echo '# Maintainer: lukaszimmermann <luk.zim91 at gmail dot com>' > PKGBUILD && \
    echo '# Contributor: saxonbeta <saxonbeta at gmail dot com>' >> PKGBUILD && \
    echo 'pkgname=openms' >> PKGBUILD && \
    echo '_pkgname=OpenMS' >> PKGBUILD && \
    echo 'pkgver=2.3.0' >> PKGBUILD && \
    echo '_pkgver=2.3' >> PKGBUILD && \
    echo 'pkgrel=1' >> PKGBUILD && \
    echo 'pkgdesc="C++ library and tools for LC/MS data management and analyses"' >> PKGBUILD && \
    echo "arch=('i686' 'x86_64')" >> PKGBUILD && \
    echo 'url="http://www.openms.de"' >> PKGBUILD && \
    echo "license=('BSD')" >> PKGBUILD && \
    echo "depends=('boost' 'qt4' 'qtwebkit' 'xerces-c' 'bzip2' 'eigen' 'glpk' 'zlib')" >> PKGBUILD && \
    echo "makedepends=('autoconf' 'automake' 'binutils' 'cmake' 'fakeroot' 'gcc' 'make' 'patch')" >> PKGBUILD && \
    echo 'source=("https://download.sourceforge.net/project/open-ms/${_pkgname}/${_pkgname}-${_pkgver}/${_pkgname}-${pkgver}-src.tar.gz"' >> PKGBUILD && \
    echo '        OpenMS-TOPPView.desktop OpenMS-TOPPAS.desktop)' >> PKGBUILD && \
    echo "sha256sums=('6ddc56811e1bcb67f28b8c55781229bbe10cc8250b59e76ba1f2a3b52e142ba5'" >> PKGBUILD && \
    echo "            '4f93d5c22a8267e4fbde6883ecc34a00abfc2ee5eafb46f6d81256ad8a33cdac'" >> PKGBUILD && \
    echo "            '9b33c6c91d931802e88af89ade4beb6c8d05484d57d1ad804888511b7a8b00a0')" >> PKGBUILD && \
    echo "build() {" >> PKGBUILD && \
    echo '  cd "${srcdir}/"' >> PKGBUILD && \
    echo '  rm -rf ${_pkgname}-${pkgver}-build' >> PKGBUILD && \
    echo '  mkdir  ${_pkgname}-${pkgver}-build' >> PKGBUILD  && \
    echo '  rm -rf contrib-build' >> PKGBUILD  && \
    echo '  mkdir contrib-build' >> PKGBUILD &&  \
    echo '  cd contrib-build'  >> PKGBUILD &&  \
    echo '  cmake -DBUILD_TYPE=SEQAN     $(realpath -P ../${_pkgname}-${pkgver}/contrib)' >> PKGBUILD  && \
    echo '  cmake -DBUILD_TYPE=LIBSVM    $(realpath -P ../${_pkgname}-${pkgver}/contrib)' >> PKGBUILD  && \
    echo '  cmake -DBUILD_TYPE=COINOR    $(realpath -P ../${_pkgname}-${pkgver}/contrib)' >> PKGBUILD  && \
    echo '  cmake -DBUILD_TYPE=KISSFFT   $(realpath -P ../${_pkgname}-${pkgver}/contrib)' >> PKGBUILD  && \
    echo '  cmake -DBUILD_TYPE=WILDMAGIC $(realpath -P ../${_pkgname}-${pkgver}/contrib)' >> PKGBUILD  && \
    echo '  cd ../${_pkgname}-${pkgver}-build' >> PKGBUILD  && \
    echo '  cmake -DCMAKE_BUILD_TYPE=Release -DOPENMS_CONTRIB_LIBS=$(realpath -P ../contrib-build) -DCMAKE_INSTALL_PREFIX=$(realpath -P ${pkgdir}/usr)  $(realpath -P ../${_pkgname}-${pkgver})' >> PKGBUILD  && \
    echo '  make OpenMS TOPP UTILS GUI' >> PKGBUILD  && \
    echo "}" >> PKGBUILD && \
    echo "package() {" >> PKGBUILD && \
    echo '  cd "${srcdir}/${_pkgname}-${pkgver}-build"' >> PKGBUILD && \
    echo '  make DESTDIR=${pkgdir}/usr install' >> PKGBUILD  && \
    echo '  install -D -m644 ${srcdir}/${_pkgname}-${pkgver}/LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"' >> PKGBUILD  && \
    echo '  install -D -m644 ${srcdir}/OpenMS-TOPPView.desktop ${pkgdir}/usr/share/applications/OpenMS-TOPPView.desktop' >> PKGBUILD  && \
    echo '  install -D -m644 ${srcdir}/OpenMS-TOPPAS.desktop ${pkgdir}/usr/share/applications/OpenMS-TOPPAS.desktop' >> PKGBUILD  && \
    echo "}" >> PKGBUILD && \
    chown -R makepkg:makepkg /openms && \
    su -c 'makepkg' makepkg && \
    pacman -U --noconfirm *pkg.tar.xz && \
    pacman -Sc --noconfirm && \
    paccache -r && \
    paccache -ruk0 && \
    rm -rf /var/cache/pacman/pkg/* && \
    rm -rf /tmp/*
ENTRYPOINT ["/bin/bash"]


# [no target]     builds the OpenMS library, TOPP tools and UTILS tools
#    OpenMS          builds the OpenMS library
#    TOPP            builds the TOPP tools
#    UTILS           builds the UTILS tools
#    GUI             builds the GUI tools (TOPPView,...)
#    test            executes OpenMS and TOPP tests
#                    make sure they are built using the 'all' target
#    Tutorials_build builds the code snippets of the tutorials in source/EXAMPLES
#    doc             builds the doxygen and class documentation, parameters
#                    documentation, and tutorial PDFs
#    doc_class_only  builds only the doxygen and class documentation
#                    (faster then doc and very useful when writing
#                    documentation).
#    doc_tutorials   builds the PDF tutorials
#    help            list all
#   echo '  cd "${srcdir}/${_pkgname}-${pkgver}"' >> PKGBUILD && \
