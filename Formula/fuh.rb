class Fuh < Formula
  desc "UTF-8 capable fork of feh image viewer"
  homepage "https://github.com/bjargal/fuh"
  url "https://github.com/bjargal/fuh/archive/refs/tags/v1.1.4.tar.gz"
  sha256 "c7557fbe771e174d5e6a0b8b22a3456e8ee9c93e39ea7baa2f96a6f9190065ae"
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
              "-DVERSION='\"1.1.4\"'",
      "LDFLAGS=-L#{HOMEBREW_PREFIX}/lib -lfreetype -lfontconfig -lharfbuzz"
    bin.install "src/fuh"
    (share/"fuh").install Dir["share/feh/*"]
    inreplace "man/feh.1", /\bfeh\b/, "fuh"
    man1.install "man/feh.1" => "fuh.1"
  end

  test do
    system "#{bin}/fuh", "--version"
  end
end
