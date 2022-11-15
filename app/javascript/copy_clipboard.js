function copyToClipboard (tagValue) {
    try {
      navigator.clipboard.writeText(tagValue);
    } catch (error) {
      alert('コピーに失敗しました(通信プロトコルがHTTPS(有料)ではなく、HTTPであるため、APIが機能しない状態です。)');
    }
}

function copy_word (){
  const textForm = document.querySelectorAll(".word_name");
  textForm.forEach(function (button) {
    button.addEventListener("click", (e) => {
      e.preventDefault();
      copyToClipboard(button.value)
    });
  });
};

window.addEventListener('load', copy_word);