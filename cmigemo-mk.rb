require 'formula'

class CmigemoMk < Formula
  homepage 'http://www.kaoriya.net/software/cmigemo'
  head 'https://github.com/koron/cmigemo', :using => :git

  depends_on 'nkf' => :build

  def patches
    DATA
  end

  def install
    ENV["HOMEBREW_OPTFLAGS"] = "-march=core2" if build.with? 'binary-release'
    ENV.append 'LDFLAGS', '-headerpad_max_install_names'

    system "./configure", "--prefix=#{prefix}"
    system "make osx-dict"
    cd 'dict' do
      system "make utf-8"
    end
    ENV.j1 # Install can fail on multi-core machines unless serialized
    system "make osx-install"
  end
end

__END__
diff --git a/dict/dict.mak b/dict/dict.mak
index 8ea8a66..4f27a97 100644
--- a/dict/dict.mak
+++ b/dict/dict.mak
@@ -6,7 +6,7 @@
 
 DICT 		= migemo-dict
 DICT_BASE	= base-dict
-SKKDIC_BASEURL 	= http://openlab.ring.gr.jp/skk/dic
+SKKDIC_BASEURL 	= http://web.archive.org/web/20110707131038/http://openlab.ring.gr.jp/skk/dic
 SKKDIC_FILE	= SKK-JISYO.L
 EUCJP_DIR	= euc-jp.d
 UTF8_DIR	= utf-8.d
