class Espresso < Formula
  desc "End-to-end neural automatic speech recognition (ASR) toolkit"
  homepage "https://github.com/freewym/espresso"
  url "https://github.com/freewym/espresso.git", revision: "8d9f214"
  version "2021.04"
  license "MIT"

  on_macos do
    uses_from_macos "python@3"
  end

  on_linux do
    depends_on "cuda11"
  end

  depends_on "kaldi"
  conflicts_with "fairseq", because: "espresso has fairseq embedded"

  def install
    # The things that pip installs as deps
    xy = Language::Python.major_minor_version("python3")
    ENV.prepend_create_path "PYTHONPATH",
      "#{prefix}/lib/python#{xy}/site-packages"
    ENV.prepend_create_path "PYTHONPATH",
      "#{HOMEBREW_PREFIX}/lib/python#{xy}/site-packages"
    on_linux do
      ENV["CUDA_HOME"] = Formula["cuda11"].prefix
      ENV["TORCH_CUDA_ARCH_LIST"] = "3.7;6.1;7.0;7.5;8.6+PTX"
    end
    system "pip3", "-v", "install", "--prefix", "#{prefix}", "."
    cd buildpath/"espresso/tools" do
      system "make", "KALDI=#{Formula["kaldi"].prefix}"
    end
  end

  test do
    system "false"
  end
end
