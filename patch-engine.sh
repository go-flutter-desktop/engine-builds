set -e
curl -O https://raw.githubusercontent.com/graphitemaster/incbin/main/incbin.h
echo -e "\n" >> incbin.h
cp main.gn engine/src/flutter/BUILD.gn
cp incbin.h engine/src/flutter/shell/platform/embedder/
echo "
#define INCBIN_SILENCE_BITCODE_WARNING
#include \"incbin.h\"
INCBIN(Icudtl, \"${PWD}/engine/src/third_party/icu/flutter/icudtl.dat\");
" >> engine/src/flutter/shell/platform/embedder/embedder.cc
cp switches.patch engine/src/flutter/shell/common/
(cd engine/src/flutter/shell/common && patch -i switches.patch)
echo 'patch switches.cc successfully'
cp embedder.patch engine/src/flutter/shell/platform/embedder/
(cd engine/src/flutter/shell/platform/embedder/ && patch -i embedder.patch)
echo 'patch BUILD.gn successfully'
