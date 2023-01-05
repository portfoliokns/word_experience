function copyToClipboard (tagValue) {
    try {
      navigator.clipboard.writeText(tagValue);
    } catch (error) {
      alert('コピーに失敗しました(通信プロトコルがHTTPSではないため、コピー機能が機能しない状態です。手動でコピーしてください)');
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