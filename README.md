# M5Stack 用 TWELITE STAGE

本パッケージは M5Stack 用にビルドされたバイナリを格納します。書き換え用のバッチファイル、スクリプトも添付しています。

M5Stack版では、以下の機能を利用できます。

* ビューア (ターミナルなど)
* アプリ書換 (ビルド済みのバイナリを SDカードに格納)
* インタラクティブモード



M5Stackへの書換には以下の操作が必要になります。本READMEで不足の情報は一般の情報を参照ください。

* コマンドラインによる操作が必要になります。
* デバイスドライバの導入が必要になります (Silicon Labs CP210x)。
* M5Stack が接続されている COM ポート(Windows), デバイス名(macOS/Linux) を確認する必要があります。



M5Stack を利用する場合は、M5Stack Library の手順に沿って環境を用意することを推奨します。

> M5Stack Library - https://github.com/m5stack/M5Stack



## パッケージの構成

```
README.md　　　　　　--- 本ドキュメント
TWELITE_Stage/     --- ライセンスなどドキュメント
esptool-2.3.1/     --- esptool.py 
   https://github.com/espressif/esptool/releases/tag/v2.3.1 より
esptool-2.3.1-win/ --- windows用の esptool.exe
fw/                --- M5Stack用ファームウェア .bin
program.cmd        --- Windows 用の書き込みバッチ
program.sh         --- bash用のシェルスクリプト
```



## TWELITE STAGE の資料

* https://stage.twelite.info/ - TWELITE STAGE マニュアル
* https://mwm5.twelite.info/ - MWM5 ライブラリマニュアル
* https://mono-wireless.com/jp/products/stage-board/ - TWELITE STAGEボード資料
* https://mono-wireless.com/jp/products/stage/ - TWELITE STAGE 資料 (M5Stackではソースファイルのビルドは出来ません)



## 動作確認済みのM5Stack

* M5Stack Core

* M5Stack faces

※ 全てのハードウェアのリビジョンについて確認しているわけではありません。



## 制約・既知の問題

* 設定書き込み時に、ハードウェアリセットが起き、設定内容がクリアされることがある。
* M5Stack faces のキーボードの割り込みピンとTWELITE 側のピンが対立するため、SETピンを用いたインタラクティブモードの自動遷移は出来ません。



## Silicon Labs CP210x のデバイスドライバ

リンク先に各OS用のドライバがダウンロードできます。事前に導入しておいてください。

https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers



## 書換方法 (Windows10)

書換前に TWELITE STAGE 基板から M5Stack を取り外してください。



### COMポートの確認

事前にデバイスドライバの導入は済ませておいてください。以下に挙げた手順は一例です。

1. M5Stack を接続しない状態でデバイスマネージャーを開いておく。
2. デバイスマネージャ ポート(COM と LPT) を確認する。
3. M5Stack を接続する。
4. 項目 (例: `Silicon Labs CP210x USB to UART Bridge (COM??)` ) が表示される。
   `COM??`部分がポート名です。



### program.cmd を実行

本パッケージを展開して、パッケージの一番上のフォルダにある `program.cmd` を実行します。



以下のように COM ポート名の入力が求められます。

```
*** PROGRAMMING TOOL OF TWELTIE STAGE for M5Stack ***
INPUT COM PORT NAME:
```



先ほど調べた COM ポート名を入力します。以下の例では `COM12` に接続された M5Stack に書き換えを行っています。

```
*** PROGRAMMING TOOL OF TWELTIE STAGE for M5Stack ***
INPUT COM PORT NAME: COM12
esptool.py v2.3.1
Connecting....
Chip is ESP32D0WDQ6 (revision (unknown 0xa))
Features: WiFi, BT, Dual Core, VRef calibration in efuse
... 続く
```



書き込みが無事終了すれば、以下のようなメッセージで終了します。M5Stackはリセットされます。

```
"*** PROGRAMMING TOOL OF TWELTIE STAGE for M5Stack ***"
INPUT COM PORT NAME: COM12
esptool.py v2.3.1
Connecting....
Chip is ESP32D0WDQ6 (revision (unknown 0xa))
Features: WiFi, BT, Dual Core, VRef calibration in efuse
Uploading stub...
Running stub...
Stub running...
Changing baud rate to 921600
Changed.
Configuring flash size...
Auto-detected Flash size: 16MB
Compressed 8192 bytes to 47...
Wrote 8192 bytes (47 compressed) at 0x0000e000 in 0.0 seconds (effective 21845.2 kbit/s)...
Hash of data verified.
Flash params set to 0x024f
Compressed 17392 bytes to 11186...
Wrote 17392 bytes (11186 compressed) at 0x00001000 in 0.2 seconds (effective 886.2 kbit/s)...
Hash of data verified.
Compressed 712640 bytes to 360652...
Wrote 712640 bytes (360652 compressed) at 0x00010000 in 6.2 seconds (effective 918.6 kbit/s)...
Hash of data verified.
Compressed 3072 bytes to 128...
Wrote 3072 bytes (128 compressed) at 0x00008000 in 0.0 seconds (effective 4096.0 kbit/s)...
Hash of data verified.

Leaving...
Hard resetting via RTS pin...
続行するには何かキーを押してください . . .
```



## 書換方法 (macOS)

書換前に TWELITE STAGE 基板から M5Stack を取り外してください。



### PySerial の導入

事前にpython上で[PySerial](https://pythonhosted.org/pyserial/)が動作するようにしておいてください。すでに導入済みの場合は、再インストールや更新は、通常必要ありません。

代表的な導入例を挙げておきます。pipの導入（導入済みであれば不要）と`pip install pyserial`の実行です。

```
$ curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
... {get-pin.pyを取得}
$ python get-pip.py
... {get-pip.pyを実行してpipを利用可能とする}
$ python -m pip install pyserial
... {PySerialの導入}
```



### デバイス名の確認

事前にデバイスドライバの導入は済ませておいてください。以下に挙げた手順は一例です。

1. ターミナルを開きます。

2. `ls -1 /dev/cu.*` を実行する。

   ```
   $ ls -1 /dev/cu.*
   /dev/cu.Bluetooth-Incoming-Port
   ```

3. M5Stackを接続する。

   ```
   $ ls -1 /dev/cu.*
   /dev/cu.Bluetooth-Incoming-Port
   /dev/cu.SLAB_USBtoUART
   ```

4. 新しく表示されたデバイス名 (例では`cu.SLAB_USBtoUART`)です。



### program.sh の実行

本パッケージを展開して、パッケージの一番上のフォルダにある `program.sh` を実行します。



ターミナルを開き、パッケージを展開したフォルダに移動します。

```
$ cd ...{パッケージ展開フォルダ}
$ ls -1
esptool-2.3.1
esptool-2.3.1-win
fw
program.cmd
program.sh
... (パッケージのバージョン等で内容は異なります)
```



`bash program.sh`のようにシェルスクリプトを実行します。

```
$ bash program.sh
*** PROGRAMMING TOOL OF TWELTIE STAGE for M5Stack ***
INPUT COM PORT NAME[/dev/cu.SLAB_USBtoUART]:
```



デバイス名の入力を求められるので、先ほど調べたデバイス名を入力します。デバイス名を入力すると、書き込みが始まります。

```
$ bash program.sh
*** PROGRAMMING TOOL OF TWELTIE STAGE for M5Stack ***
INPUT COM PORT NAME[/dev/cu.SLAB_USBtoUART]: /dev/cu.SLAB_USBtoUART
esptool.py v2.3.1
Connecting....
Chip is ESP32D0WDQ6 ...続く
```



書き込みが無事終了すれば、以下のようなメッセージで終了します。M5Stackはリセットされます。

```
$ bash program.sh
*** PROGRAMMING TOOL OF TWELTIE STAGE for M5Stack ***
INPUT COM PORT NAME[/dev/cu.SLAB_USBtoUART]: /dev/cu.SLAB_USBtoUART
esptool.py v2.3.1
Connecting....
Chip is ESP32D0WDQ6 (revision (unknown 0xa))
Features: WiFi, BT, Dual Core, VRef calibration in efuse
Uploading stub...
Running stub...
Stub running...
Changing baud rate to 921600
Changed.
Configuring flash size...
Auto-detected Flash size: 16MB
Compressed 8192 bytes to 47...
Wrote 8192 bytes (47 compressed) at 0x0000e000 in 0.0 seconds (effective 15383.8 kbit/s)...
Hash of data verified.
Flash params set to 0x024f
Compressed 17392 bytes to 11186...
Wrote 17392 bytes (11186 compressed) at 0x00001000 in 0.1 seconds (effective 928.9 kbit/s)...
Hash of data verified.
Compressed 712640 bytes to 360652...
Wrote 712640 bytes (360652 compressed) at 0x00010000 in 6.1 seconds (effective 934.7 kbit/s)...
Hash of data verified.
Compressed 3072 bytes to 128...
Wrote 3072 bytes (128 compressed) at 0x00008000 in 0.0 seconds (effective 4580.1 kbit/s)...
Hash of data verified.

Leaving...
Hard resetting via RTS pin...
```



シリアルポート関連のエラーが出る場合はルート権限で動作を試みてください。

```
$ sudo bash program.sh
Password:(パスワード入力)
*** PROGRAMMING TOOL OF TWELTIE STAGE for M5Stack ***
INPUT COM PORT NAME[/dev/cu.SLAB_USBtoUART]:
```



## TWELITE STAGE ボードとの接続

資料 (https://mono-wireless.com/jp/products/stage-board/ ) にあるデータシート中の TWELITE STAGE ボードの回路図 J1 コネクタが M5Stack との接続部分になります。

TWELITE STAGE ボード上のピンヘッダに M5Stack 右部分にある１５ピンソケットを接続します。構造上、逆に接続したりピンがずれて差し込んだりは出来ませんが、接続には注意を払うようにしてください。

* M5Stack を接続した場合、TWELITE 無線マイコンには M5Stack の 3.3V (3V3) 経由で電源供給されます。
* M5Stack が USB 電源供給されていない状態では、内部のバッテリーのみで電源供給することになります。
  * M5Stack の電源OFF操作を行っても、基板に接続される限り 3V3 からの供給は続き、M5Stack の電池を消耗します。使わないときはM5StackをTWELITE STAGEボードから外してください。



### キーボードについて

TWELITE STAGE アプリでは、多くの操作をキーボード前提としております。以下のキーボードに対応しています。

* PS/2 コネクタ
  PS/2 キーボードを接続することが出来ます。USB共用タイプの一部など、場合によっては動作しないことも考えられます。
* M5Stack 純正のカード型キーボード [CardKB](https://docs.m5stack.com/#/en/unit/cardkb) (Grove端子接続)
* M5Stack faces のキーボード (QWERTYタイプ)



## アプリ書換について

TWELITE 無線マイコン用のファームウェアを M5Stack から書き込むことが出来ます。

FAT32フォーマットしたSDカード上の最上位フォルダに BIN フォルダを作成し、BIN フォルダ中にファームウェアをコピーしておきます。

* ファームウェアのファイル名により一部識別（RED/BLUE用）しているので、ファイル名はWin/Mac/Linux用のTWELITE STAGE でビルドしたファイル名は変更しないようにしてください。