class Fuh < Formula
  desc "UTF-8 capable fork of feh image viewer"
  homepage "https://github.com/bjargal/fuh"
  url "https://github.com/bjargal/fuh/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "651264f70628c79eba6bae5a06b3ff9937bcd6c8dac7c7dac659360127cad9ca"
  license "MIT"

  depends_on "freetype"
  depends_on "harfbuzz"
  depends_on "fontconfig"
  depends_on "imlib2"
  depends_on "libexif"
  depends_on "libpng"
  depends_on "libx11"
  depends_on "libxinerama"
  depends_on "libxt"

  def install
    system "make",
      "verscmp=0",
      "CFLAGS=-I#{Formula["freetype"].opt_include}/freetype2 " \
              "-I#{Formula["harfbuzz"].opt_include}/harfbuzz " \
              "-I#{Formula["fontconfig"].opt_include} " \
              "-I#{Formula["libx11"].opt_include} " \
              "-I#{HOMEBREW_PREFIX}/include " \
              "-DPREFIX='\"#{prefix}\"' " \
              "-DPACKAGE='\"fuh\"' " \
              "-DVERSION='\"1.1.0\"'",
      "LDFLAGS=-L#{HOMEBREW_PREFIX}/lib -lfreetype -lfontconfig -lharfbuzz"
    bin.install "src/fuh"
    share.install "share/feh" => "fuh"
  end

  test do
    system "#{bin}/fuh", "--version"
  end
end
