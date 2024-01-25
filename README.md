# touchOSC_-smartphone_music
スマートフォンの加速度センサーの値をOSCを用いてPCから音を鳴らします。

内容的には
- スマートフォンにTouchOSC(https://hexler.net/touchosc)をインストール
- TouchOSCからOSCを起動
    - 参考[iPhoneの加速度/ジャイロセンサーからTouchOSCを介してCsoundをコントロール](https://note.com/tmnkj/n/nea448ba72eec)
- PCではOSCを受信するのはProcessingのコード、sketch_sonic_piを用いて受信する。
    - 加速度センサーの値を用いて画面の色を変える
    - sonic_piに加速度センサーの値をOSCで送ります
- Sonic Piではsonic_pi/osc_play.rbを動かして音を鳴らします。
    - X/Y/Z軸ごとに違う音を鳴らします