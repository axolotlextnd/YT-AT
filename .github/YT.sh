# Load dữ liệu cài đặt 
. $HOME/.github/options/YouTube.md

# lấy dữ liệu phiên bản mặc định
echo "- Lấy dữ liệu phiên bản YouTube..."
for kck in $Vik; do
Vidon="$(java -jar $lib1 -a $lib3 -b $lib2 -l --with-versions | grep -m1 "$kck" | tr ' ' '\n' | sed -e "s| |\n|g" | tail -n2 | sed -e "s|\n||g")"
[ "$Vidon" ] && break
done
VER="$Vidon"
echo "  $VER"
echo

echo "- Tải YouTube apk apks..."
# Tải YouTube apk
kkk1="google-inc/youtube/youtube-${VER//./-}-release/youtube-${VER//./-}-2-android-apk-download"
kkk2="google-inc/youtube/youtube-${VER//./-}-release/youtube-${VER//./-}-android-apk-download"

# Tải
TaiYT 'YouTube.apk' "$kkk1" & TaiYT 'YouTube.apks' "$kkk2"

# Chờ tải xong
Loading apk/YouTube.apk.txt apk/YouTube.apks.txt
echo

# Xem xét apk
if [ "$(unzip -l apk/YouTube.apk | grep -cm1 'base.apk')" == 1 ];then
mv apk/YouTube.apk apk/YouTube.apk2
mv apk/YouTube.apks apk/YouTube.apk
mv apk/YouTube.apk2 apk/YouTube.apks
fi

# xoá lib dựa vào abi
if [ "$DEVICE" == "arm64-v8a" ];then
lib="lib/x86/* lib/x86_64/* lib/armeabi-v7a/*"
ach="arm64"
elif [ "$DEVICE" == "x86" ];then
lib="lib/x86_64/* lib/arm64-v8a/* lib/armeabi-v7a/*"
ach="x86"
elif [ "$DEVICE" == "x86_64" ];then
lib="lib/x86/* lib/arm64-v8a/* lib/armeabi-v7a/*"
ach="x64"
else
lib="lib/arm64-v8a/* lib/x86/* lib/x86_64/*"
ach="arm"
fi

#echo > $HOME/Module/common/$ach
#cp -rf $HOME/.github/Tools/sqlite3_$ach $HOME/Module/common/sqlite3

# Xử lý revanced patches
if [ "$Vidon" != "$VER" ];then
echo "- Chuyển đổi phiên bản thành $VER"
echo
unzip -qo "lib/revanced-patches.jar" -d jar
for vak in $(grep -Rl "$Vidon" jar); do
cp -rf $vak test
XHex test | sed -e "s/$(echo -n "$Vidon" | XHex)/$(echo -n "$VERSION" | XHex)/" | ZHex > $vak
done
cd jar
zip -qr "lib/revanced-patches.jar" *
fi

# MOD YouTube 
(
echo '- Bắt đầu quá trình xây dựng..."
echo
java -Djava.io.tmpdir=tmp -jar $lib1 -b $lib2 -m $lib3 -a apk/YouTube.apk -o YT.apk \
-t tmp --options=$HOME/.github/options.toml $Tof $Ton
) & (
Loading "tmp/res/values" "tmp/res/values"
zip -qr apk/YouTube.apk -d res/*
)
