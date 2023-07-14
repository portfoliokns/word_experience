document.addEventListener("DOMContentLoaded", function() {

  //DOM初期化
  const Random_Sentence_Url_Api = "https://api.quotable.io/random";
  const typeDisplay = document.getElementById("typeDisplay");
  const typeInput = document.getElementById("typeInput");
  const passedTimer = document.getElementById("passedTimer");
  const limitTimer = document.getElementById("limitTimer");
  const startButton = document.getElementById("startButton");
  const retireButton = document.getElementById("retireButton");

  //DOM初期化（音声関連）
  const typingBgmContent = document.getElementById("bgm_sound");
  const typingSoundContent = document.getElementById("typing_sound");
  const typingMissSoundContent = document.getElementById("typing_miss_sound");
  const clearSoundContent = document.getElementById("clear_sound");
  const recoverySoundContent = document.getElementById("recovery_sound");
  const gameOverSoundContent = document.getElementById("game_over_sound");
  const bgmSlider = document.getElementById("bgm_volume_slider");
  const typingSlider = document.getElementById("typing_volume_slider");
  const missSlider = document.getElementById("miss_volume_slider");
  const clearSlider = document.getElementById("clear_volume_slider");
  const recoverySlider = document.getElementById("recovery_volume_slider");
  const gameOverSlider = document.getElementById("game_over_volume_slider");
  const typeSound = new Audio("../sounds/audio_typing-sound.mp3");
  const wrongSound = new Audio("../sounds/audio_wrong.mp3");
  const correctSound = new Audio("../sounds/audio_correct.mp3");
  const bombSound = new Audio("../sounds/audio_bomb.mp3");
  const bgmSound = new Audio("../sounds/audio_bgm.mp3");
  const recoverySound = new Audio("../sounds/audio_recovery.mp3");
  bgmSound.volume = 0.3;
  bgmSlider.value = bgmSound.volume;

  //パラメータ
  let typeMissParams = 2.000;
  let typeMissCounter = 0;
  let typeCorrectParams = 2;
  let correctTime = 0;
  let sentenceNum = 3;
  let correctTypeSegment = 15;

  class sentenceQueue {
    constructor() {
      this.setEnqueues();
    };

    async setEnqueues() {
      this.elements = [];
      for (let index = 0; index < sentenceNum; index++) {
        let sentence = await GetRandomSentence();
        this.enqueue(sentence);
      }
    };

    enqueue(element) {
      this.elements.push(element);
    };

    dequeue() {
      if (this.elements.length === 0) {
        return "不具合が発生しました。管理人にお問合せください。";
      }
      return this.elements.shift();
    };

    isEmpty() {
      if (this.elements.length > 0) {
        return false;
      } else {
        return true;
      }
    };
  };

  //文章情報を初期化
  const sentences = new sentenceQueue();

  // 入力キーの制御
  typeInput.addEventListener("keydown", function(event) {
    const eventKeys = ["ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight", "Backspace", "Tab", "Enter"];
    if (eventKeys.includes(event.key)) {
      event.preventDefault();
    }
  });

  // 日本語入力チェック
  let previousComposition = '';
  typeInput.addEventListener('compositionstart', () => {
    previousComposition = typeInput.value;
  });
  typeInput.addEventListener('compositionend', () => {
    const currentComposition = typeInput.value;
    if (currentComposition !== previousComposition) {
      alert("日本語入力または日本語変換による操作は、動作が保証できません。IMEが必ず半角英数になっていることを確認してください。");
    }
    previousComposition = currentComposition;
  });

  // inputTextの入力値を判定する
  typeInput.addEventListener("input", () => {

    let inputText = typeInput.value;

    const sentenceArray = typeDisplay.querySelectorAll("span");
    const arrayValue = inputText.split("");
    let reValue = "";
    let correctAll = true;
    let typeMiss = false;

    sentenceArray.forEach((characterSpan, index) => {
      if ((arrayValue[index] == null)) {
        characterSpan.classList.remove("typing_correct");
        characterSpan.classList.remove("typing_incorrect");
        correctAll = false;
      } else if(characterSpan.innerHTML == arrayValue[index]) {
        characterSpan.classList.add("typing_correct");
        characterSpan.classList.remove("typing_incorrect");
        TypingSoundPlay();
      } else {
        characterSpan.classList.add("typing_incorrect");
        characterSpan.classList.remove("typing_correct");
        TypeMissSoundPlay();
        typeInput.value = reValue;
        correctAll = false;
        typeMiss = true;
      }

      //復元用の文字列を作成
      reValue += arrayValue[index]
    })

    //タイプミスの有無でタイムを加算・減算する
    if (typeMiss) {
      CutDownTime();
    } else {
      AddTime();
    };

    //次の文章を設定する
    if (correctAll == true & sentences.isEmpty() == false) {
      typeInput.value = "";
      SetSentence();
      CorrectSoundPlay()
      return 0;
    };

    //ゲームにクリアした場合、ゲームを終了する
    if (correctAll == true & sentences.isEmpty() == true){
      ClearMode();
      return 0;
    };

  });

  // ランダムな文字を取得する
  function GetRandomSentence() {
    return fetch(Random_Sentence_Url_Api)
    .then((response) => response.json())
    .then((data) => data.content);
  };

  // 文章を1文字ずつ分解して、spanタグを生成する
  function SetSentence() {
    typeDisplay.innerText = "";
    let sentence = sentences.dequeue();
    let oneText = sentence.split("");
    oneText.forEach((character) => {
      const characterSpan = document.createElement("span");
      characterSpan.innerText = character;
      typeDisplay.appendChild(characterSpan);
    });
  };

  //タイマーのカウントを開始する
  let startTime;
  let nowTime
  let originTime = 90.000;
  let missTime = 0.000;
  let timerInterval;
  function StartTimer() {
    clearInterval(timerInterval);

    startTime = new Date();
    timerInterval = setInterval(() => {
      nowTime = originTime - getTimerTime() - missTime + correctTime;
      passedTimer.innerText = "経過時間： " + Math.floor(getTimerTime()) + "秒";
      if (nowTime < 0.000) nowTime = 0.000;
      limitTimer.innerText = "残り " + Math.ceil(nowTime) + "秒";
      if (nowTime <= 0.000) GameOverMode();
    }, 100);
  };

  // 経過時間を取得する(少数点第三位まで)
  function getTimerTime() {
    let time = (new Date() - startTime) / 1000;
    return time.toFixed(3);
  };

  //タイピングゲームを開始する
  startButton.addEventListener("click", () =>{
    PlayMode();
    SetSentence();
    StartTimer();
  });

  //リタイアする
  retireButton.addEventListener("click", () =>{
    RetireMode();
  });

  function setSoundVolume(content,sound, slider) {
    if (content.checked) {
      sound.volume = slider.value;
      slider.disabled = false;
    } else {
      sound.volume = 0;
      slider.disabled = true;
    }
  }

  //BGMをON/OFFする
  typingBgmContent.addEventListener("change", function() {
    setSoundVolume(this, bgmSound, bgmSlider);
  });

  //タイピング音をON/OFFする
  typingSoundContent.addEventListener("change", function() {
    setSoundVolume(this, typeSound, typingSlider);
  });

  //タイピングミス音をON/OFFする
  typingMissSoundContent.addEventListener("change", function() {
    setSoundVolume(this, wrongSound, missSlider);
  });

  //正解音をON/OFFする
  clearSoundContent.addEventListener("change", function() {
    setSoundVolume(this, correctSound, clearSlider);
  });

  //回復音をON/OFFする
  recoverySoundContent.addEventListener("change", function() {
    setSoundVolume(this, recoverySound, recoverySlider);
  });

  //ゲームオーバー音をON/OFFする
  gameOverSoundContent.addEventListener("change", function() {
    setSoundVolume(this, bombSound, gameOverSlider);
  });

  //音量を設定する
  bgmSlider.addEventListener("input", function() {
    bgmSound.volume = this.value;
  });
  typingSlider.addEventListener("input", function() {
    typeSound.volume = this.value;
  });
  missSlider.addEventListener("input", function() {
    wrongSound.volume = this.value;
  });
  clearSlider.addEventListener("input", function() {
    correctSound.volume = this.value;
  });
  recoverySlider.addEventListener("input", function() {
    recoverySound.volume = this.value;
  });
  gameOverSlider.addEventListener("input", function() {
    bombSound.volume = this.value;
  });

  //プレイモード
  function PlayMode() {
    limitTimer.innerText = "残り " + originTime + "秒";
    passedTimer.innerText = "経過時間：0秒";
    StartBGM()
    typeDisplay.innerText = "";
    typeInput.readOnly = false;
    typeInput.value = "";
    typeInput.focus();
    startButton.disabled = true;
    retireButton.disabled = false;
    typeMissCounter = 0;
    missTime = 0.000;
    typeCorrectCounter = 0;
    correctTime = 0;
  };

  //リタイアモード
  function RetireMode() {
    InitMode();
    BombSoundPlay()
    limitTimer.innerText = "Retire !!";
  };

  //ゲームオーバーモード
  function GameOverMode() {
    InitMode();
    BombSoundPlay()
    limitTimer.innerText = "Game Over !!";
  };

  //クリアモード
  function ClearMode() {
    InitMode();
    CorrectSoundPlay()
    limitTimer.innerText = "Clear !!";
  };

  //モードの初期化
  function InitMode() {
    clearInterval(timerInterval);
    timerInterval = null;
    StopBGM();
    startButton.disabled = false;
    retireButton.disabled = true;
    sentences.setEnqueues();
    typeInput.readOnly = true;
  };

  //BGM開始
  function StartBGM() {
    StopBGM();
    bgmSound.play();
  };

  //BGM終了
  function StopBGM() {
    bgmSound.pause();
    bgmSound.currentTime = 0;
  };

  //タイピングサウンド
  function TypingSoundPlay() {
    if (!typingSoundContent.checked) return;
    typeSound.play();
    typeSound.currentTime = 0;
  }
  
  //タイピングミスサウンド
  function TypeMissSoundPlay() {
    if (!typingMissSoundContent.checked) return;
    wrongSound.play();
    wrongSound.currentTime = 0;
  }

  //正解サウンド
  function CorrectSoundPlay() {
    if (!clearSoundContent.checked) return;
    correctSound.play();
    correctSound.currentTime = 0;
  }

  //回復サウンド
  function RecoverySoundPlay() {
    if (!recoverySoundContent.checked) return;
    recoverySound.play();
    recoverySound.currentTime = 0;
  }

  //爆発サウンド
  function BombSoundPlay() {
    if (!gameOverSoundContent.checked) return;
    bombSound.play();
    bombSound.currentTime = 0;
  }

  //タイムを減算する
  function CutDownTime() {
    typeMissCounter += 1;
    missTime = typeMissCounter * typeMissParams;
    typeCorrectCounter = 0;
  };

  //タイムを加算する
  function AddTime() {
    typeCorrectCounter += 1;
    if (typeCorrectCounter % correctTypeSegment === 0) {
      correctTime += typeCorrectParams;
      RecoverySoundPlay()
    }
  };

  //禁止文字を置き替える
  function ReplaceCharacter(sentence) {
    sentence = sentence.replaceAll("–", "");
    sentence = sentence.replaceAll("...", "");
    return sentence
  };

});