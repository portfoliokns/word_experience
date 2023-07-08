document.addEventListener("DOMContentLoaded", function() {

  //DOM初期化
  const Random_Sentence_Url_Api = "https://api.quotable.io/random";
  const typeDisplay = document.getElementById("typeDisplay");
  const typeInput = document.getElementById("typeInput");
  const timer = document.getElementById("timer");
  const startButton = document.getElementById("startButton");

  //サウンド初期化
  const typeSound = new Audio("../sounds/audio_typing-sound.mp3");
  const wrongSound = new Audio("../sounds/audio_wrong.mp3");
  const correctSound = new Audio("../sounds/audio_correct.mp3");
  const bombSound = new Audio("../sounds/audio_bomb.mp3");

  // 入力キーの制御
  typeInput.addEventListener("keydown", function(event) {
    const eventKeys = ["ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight", "Backspace", "Tab", "Enter"];
    if (eventKeys.includes(event.key)) {
      event.preventDefault();
    }
  });

  // inputTextの入力値を判定する
  typeInput.addEventListener("input", () => {

    let inputText = typeInput.value;
    inputText = inputText.replace(/[^\sa-zA-Z'; ,.\-]/g, "");

    const sentenceArray = typeDisplay.querySelectorAll("span");
    const arrayValue = inputText.split("");
    let reValue = "";
    let correct = true;

    sentenceArray.forEach((characterSpan, index) => {
      if ((arrayValue[index] == null)) {
        characterSpan.classList.remove("typing_correct");
        characterSpan.classList.remove("typing_incorrect");
        correct = false;
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
        correct = false;
      }

      //復元用の文字列を作成
      reValue += arrayValue[index]
    })

    //ゲームにクリアした場合、ゲームを終了する
    if (correct == true){
      ClearMode();
    }

  });

  // ランダムな文字を取得する
  function GetRandomSentence() {
    return fetch(Random_Sentence_Url_Api)
    .then((response) => response.json())
    .then((data) => data.content);
  };

  //（非同期処理）ランダムな文字列を取得して、画面に表示する(タイマーもスタートする)
  async function SetRandomSentence() {
    const sentence = await GetRandomSentence();
    
    // 文章を1文字ずつ分解して、spanタグを生成する
    let oneText = sentence.split("");
    oneText.forEach((character) => {
      const characterSpan = document.createElement("span");
      characterSpan.innerText = character;
      typeDisplay.appendChild(characterSpan);
    });

    StartTimer();
  };

  //タイマーのカウントを開始する
  let startTime;
  let originTime = 30;
  let timerInterval;
  function StartTimer() {
    clearInterval(timerInterval);

    startTime = new Date();
    timerInterval = setInterval(() => {
      nowTime = originTime - getTimerTime()
      timer.innerText = "残り" + nowTime + "秒";
      if (nowTime <= 0) GameOverMode();
    }, 1000);
  };

  // 経過時間を取得する
  function getTimerTime() {
    return Math.floor((new Date() - startTime) / 1000);
  };

  //タイピングゲームを開始する
  startButton.addEventListener("click", () =>{
    PlayMode();
    SetRandomSentence();
  });

  function PlayMode() {
    timer.innerText = "残り" + originTime + "秒";
    typeDisplay.innerText = "";
    typeInput.readOnly = false;
    typeInput.value = "";
    typeInput.focus();
    startButton.innerText = "リスタートする";
  };

  function GameOverMode() {
    clearInterval(timerInterval);
    timerInterval = null;
    bombSound.play();
    bombSound.currentTime = 0;
    timer.innerText = "Game Over !!";
    typeInput.readOnly = true;
    startButton.innerText = "もう一度挑戦する";
  };

  function ClearMode() {
    clearInterval(timerInterval);
    timerInterval = null;
    correctSound.play();
    correctSound.currentTime = 0;
    timer.innerText = "Clear !!";
    typeInput.readOnly = true;
    startButton.innerText = "もう一度挑戦する";
  };

});