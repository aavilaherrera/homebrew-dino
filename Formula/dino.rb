class Dino < Formula
  desc "a modern open-source chat client for the desktop"
  homepage "https://dino.im/"
  url "https://github.com/dino/dino/releases/download/v0.4.2/dino-0.4.2.tar.gz"
  sha256 "e1b1527028073b95c3abec41cb02ec60c1ee0a76da2c57bf2456afb8a3cd7eed"
  license "GPL-3.0-or-later"

  depends_on "adwaita-icon-theme"
  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "gettext"
  depends_on "glib"
  depends_on "glib-networking"
  depends_on "gnu-getopt" => :build
  depends_on "gpgme"
  depends_on "gspell"
  depends_on "gstreamer"
  depends_on "gtk+3"
  depends_on "gtk4"
  depends_on "icu4c"
  depends_on "libadwaita"
  depends_on "libgcrypt"
  depends_on "libgee"
  depends_on "libgpg-error"
  depends_on "libnice"
  depends_on "libsignal-protocol-c"
  depends_on "libsoup"
  depends_on "libxml2"
  depends_on "ninja"
  depends_on "qrencode"
  depends_on "sqlite"
  depends_on "srtp"
  depends_on "vala"
  depends_on "webrtc-audio-processing"

  on_macos do
    # libgpg-error linking problem on macos
    patch do
      # diff --git a/plugins/gpgme-vala/CMakeLists.txt b/plugins/gpgme-vala/CMakeLists.txt
      # index 5255bac..a1c3d3c 100644
      # --- a/plugins/gpgme-vala/CMakeLists.txt
      # +++ b/plugins/gpgme-vala/CMakeLists.txt
      # @@ -47,6 +47,6 @@ set(CFLAGS ${VALA_CFLAGS} -I${CMAKE_CURRENT_SOURCE_DIR}/src)
      #  add_definitions(${CFLAGS})
      #  add_library(gpgme-vala STATIC ${GPGME_VALA_C} src/gpgme_fix.c)
      #  add_dependencies(gpgme-vala gpgme-vapi)
      # -target_link_libraries(gpgme-vala ${GPGME_VALA_PACKAGES} gpgme)
      # +target_link_libraries(gpgme-vala ${GPGME_VALA_PACKAGES} gpg-error gpgme)
      #  set_property(TARGET gpgme-vala PROPERTY POSITION_INDEPENDENT_CODE ON)
      url "https://svnweb.mageia.org/packages/cauldron/dino/current/SOURCES/dino-linking.patch?revision=1852837&view=co"
      sha256 "05ef4757858ec836a56bc0f32594d589be308da426f3d00f0a6345116c761c7b"
    end
  end

  def install
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    ggetopt_path = Formula['gnu-getopt'].bin
    with_env({"PATH" => "#{ggetopt_path}:#{ENV['PATH']}"
    }) do
      system "./configure", *std_configure_args, "--disable-silent-rules", "--with-libsoup3"
      system "make"
      system "make", "install"
    end
      ohai "renaming plugin extensions { .dylib => .so }"
      plugins = lib/"dino/plugins"
      plugins.glob("*.dylib").each do |plugin|
        ohai "  * #{plugin.basename('.dylib')}"
        plugin.rename(plugin.sub_ext('.so'))
      end
  end

  test do
    assert_equal "Dino #{version}", shell_output("#{bin}/dino --version | head -n 1").strip
  end
end
