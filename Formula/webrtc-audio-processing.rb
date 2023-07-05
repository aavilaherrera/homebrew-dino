class WebrtcAudioProcessing < Formula
  desc "a more Linux packaging friendly copy of the AudioProcessing module from the WebRTC project."
  homepage "https://freedesktop.org/software/pulseaudio/webrtc-audio-processing/"
  #url "https://freedesktop.org/software/pulseaudio/webrtc-audio-processing/webrtc-audio-processing-1.0.tar.gz"
  #sha256 "441a30d2717b2eb4145c6eb96c2d5a270fe0b4bc71aebf76716750c47be1936f"
  url "https://freedesktop.org/software/pulseaudio/webrtc-audio-processing/webrtc-audio-processing-1.1.tar.gz"
  sha256 "59b3d47aedd32dd6fe4836478499ebb7c5bcad815f14dccddbbd70e752a99e5f"
  license :cannot_represent

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "abseil"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test webrtc-audio-processing`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
