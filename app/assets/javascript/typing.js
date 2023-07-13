document.addEventListener("DOMContentLoaded", function() {

  //DOM初期化
  const Random_Sentence_Url_Api = "https://api.quotable.io/random";
  const typeDisplay = document.getElementById("typeDisplay");
  const typeInput = document.getElementById("typeInput");
  const passedTimer = document.getElementById("passedTimer");
  const limitTimer = document.getElementById("limitTimer");
  const startButton = document.getElementById("startButton");

  //サウンド初期化
  const typeSound = new Audio("../sounds/audio_typing-sound.mp3");
  const wrongSound = new Audio("../sounds/audio_wrong.mp3");
  const correctSound = new Audio("../sounds/audio_correct.mp3");
  const bombSound = new Audio("../sounds/audio_bomb.mp3");
  const bgmSound = new Audio("../sounds/audio_bgm.mp3");
  const recoverySound = new Audio("../sounds/audio_recovery.mp3");

  //パラメータ
  let typeMissParams = 2.000;
  let typeMissCounter = 0;
  let typeCorrectParams = 2;
  let correctTime = 0;

  class sentenceQueue {
    constructor() {
      this.elements = [];
      SetRandomSentence();
    }

    enqueue(element) {
      this.elements.push(element);
    }

    dequeue() {
      if (this.elements.length === 0) {
        return "キューは空です";
      }
      return this.elements.shift();
    }

    isEmpty() {
      if (this.elements.length > 0) {
        return false;
      } else {
        return true;
      }
    }
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
      } else if(characterSpan.innerText == arrayValue[index]) {
        characterSpan.classList.add("typing_correct");
        characterSpan.classList.remove("typing_incorrect");
        typeSound.play();
        typeSound.currentTime = 0;
      } else {
        characterSpan.classList.add("typing_incorrect");
        characterSpan.classList.remove("typing_correct");
        wrongSound.play();
        wrongSound.currentTime = 0;
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
      return 0;
    };

    //ゲームにクリアした場合、ゲームを終了する
    if (correctAll == true & sentences.isEmpty() == true){
      // SetSentence();
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

  //（非同期処理）ランダムな文字列を取得して、画面に表示する(タイマーもスタートする)
  async function SetRandomSentence() {
    for (let index = 0; index < 3; index++) {
      let sentence = await GetRandomSentence();
      sentence = ReplaceCharacter(sentence);
      sentences.enqueue(sentence);
    }
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
  let originTime = 30.000;
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
    // SetRandomSentence();
    SetSentence();
    StartTimer();
  });

  //プレイ中
  function PlayMode() {
    limitTimer.innerText = "残り " + originTime + "秒";
    passedTimer.innerText = "経過時間：0秒";
    StartBGM()
    typeDisplay.innerText = "";
    typeInput.readOnly = false;
    typeInput.value = "";
    typeInput.focus();
    startButton.innerText = "リスタートする";
    typeMissCounter = 0;
    missTime = 0.000;
    typeCorrectCounter = 0;
    correctTime = 0;
  };

  //ゲームオーバーモード
  function GameOverMode() {
    clearInterval(timerInterval);
    timerInterval = null;
    StopBGM();
    bombSound.play();
    bombSound.currentTime = 0;
    limitTimer.innerText = "Game Over !!";
    typeInput.readOnly = true;
    startButton.innerText = "もう一度挑戦する";
    SetRandomSentence();
  };

  //クリアモード
  function ClearMode() {
    clearInterval(timerInterval);
    timerInterval = null;
    StopBGM();
    correctSound.play();
    correctSound.currentTime = 0;
    limitTimer.innerText = "Clear !!";
    typeInput.readOnly = true;
    startButton.innerText = "もう一度挑戦する";
    SetRandomSentence();
  };

  //BGM開始
  function StartBGM() {
    StopBGM();
    bgmSound.volume = 0.3;
    bgmSound.play();
  };

  //BGM終了
  function StopBGM() {
    bgmSound.pause();
    bgmSound.currentTime = 0;
  };

  //タイムを減算する
  function CutDownTime() {
    typeMissCounter += 1;
    missTime = typeMissCounter * typeMissParams;
  };

  //タイムを加算する
  function AddTime() {
    typeCorrectCounter += 1;
    if (typeCorrectCounter % 15 === 0) {
      correctTime += typeCorrectParams;
      recoverySound.play();
      recoverySound.currentTime = 0;
    }
  };

  function ReplaceCharacter(sentence) {
    sentence = sentence.replaceAll("–", "");
    sentence = sentence.replaceAll("...", "");
    return sentence
  };

});