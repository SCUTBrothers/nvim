# issue: https://github.com/folke/noice.nvim/issues/1184
# noice 可能会调用一些treesitter用到的 `.so` 动态库文件，这些似乎与操作系统（MacOS）级别的代码签名缓存
# 可以通过以下脚本对这些动态库文件进行重新签名，从而解决 noice.nvim 在 MacOS 上出现的问题

find ~/.local/share/nvim -name "*.so" | while read lib; do
  sudo codesign --force --sign - "$lib"
done
