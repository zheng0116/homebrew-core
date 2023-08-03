class PipTools < Formula
  include Language::Python::Virtualenv

  desc "Locking and sync for Pip requirements files"
  homepage "https://pip-tools.readthedocs.io"
  url "https://files.pythonhosted.org/packages/b9/c3/1aaa83575efca3cdd2a237d2371a7179af66a3e39f3922df4b657e607f03/pip-tools-7.2.0.tar.gz"
  sha256 "616488b539e14b8aa85436ed597a33c291f4885c1d2e0bec97400abe5aff2c0d"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "09e492e1a0af5e344fe97d556fea8fb126d5788a691f629e61074424ea7d6c2f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a6997de408096a2481aabc898e48071e710c73503a768e792e682fad685548b1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b1c23efb4f52da77d17f60a0a6bc6eff2eb4f3aa08b18124a462b02b90b0fe88"
    sha256 cellar: :any_skip_relocation, ventura:        "1fc1e70ff2f4befddc8e1e7f820a9126ee246aba1acecd27b1a2b3c1836cc1d1"
    sha256 cellar: :any_skip_relocation, monterey:       "80d710a0f8dbbc478cb7c327622e5e3a94f3a2f119a5d003b2d35713e15b5ac7"
    sha256 cellar: :any_skip_relocation, big_sur:        "1ff382e94d4b22755568f7083f01fdd6bdb827743849808f0888ec21424b0529"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c337491937d8385f23cf3bd2cafbe673093178d2ed342519f9bcbd28a3bf9a43"
  end

  depends_on "python@3.11"

  resource "build" do
    url "https://files.pythonhosted.org/packages/de/1c/fb62f81952f0e74c3fbf411261d1adbdd2d615c89a24b42d0fe44eb4bcf3/build-0.10.0.tar.gz"
    sha256 "d5b71264afdb5951d6704482aac78de887c80691c52b88a9ad195983ca2c9269"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/72/bd/fedc277e7351917b6c4e0ac751853a97af261278a4c7808babafa8ef2120/click-8.1.6.tar.gz"
    sha256 "48ee849951919527a045bfe3bf7baa8a959c423134e1a5b98c05c20ba75a1cbd"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/b9/6c/7c6658d258d7971c5eb0d9b69fa9265879ec9a9158031206d47800ae2213/packaging-23.1.tar.gz"
    sha256 "a392980d2b6cffa644431898be54b0045151319d1e7ec34f0cfed48767dd334f"
  end

  resource "pyproject-hooks" do
    url "https://files.pythonhosted.org/packages/25/c1/374304b8407d3818f7025457b7366c8e07768377ce12edfe2aa58aa0f64c/pyproject_hooks-1.0.0.tar.gz"
    sha256 "f271b298b97f5955d53fb12b72c1fb1948c22c1a6b70b315c54cedaca0264ef5"
  end

  resource "wheel" do
    url "https://files.pythonhosted.org/packages/ec/34/903929e15b2657335b2ce8723d92fc804d3569b7ac0f1f8877ed1a7b2024/wheel-0.41.0.tar.gz"
    sha256 "55a0f0a5a84869bce5ba775abfd9c462e3a6b1b7b7ec69d72c0b83d673a5114d"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"requirements.in").write <<~EOS
      pip-tools
      typing-extensions
    EOS

    compiled = shell_output("#{bin}/pip-compile requirements.in -q -o -")
    assert_match "This file is autogenerated by pip-compile", compiled
    assert_match "# via pip-tools", compiled
  end
end
