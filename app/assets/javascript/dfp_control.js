function sub_main_hidden(){
  try {
    const subMain = document.getElementById("sub_main");
    subMain.setAttribute("style", "display: none;");
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
};

function sub_main_display(){
  try {
    const subMain = document.getElementById("sub_main");
    subMain.setAttribute("style", "display: flex;");
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
};

function change_form(status){
  try {
    if (status) {
      sub_main_display();
    } else {
      sub_main_hidden();
    };

  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
};

function init_form(){
  try {
    const understoodCheckBox = document.getElementById("understood_check_box");
    understoodCheckBox.addEventListener('click', function() {
      const status = understoodCheckBox.checked
      change_form(status);
    })
    sub_main_hidden();
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
};

window.addEventListener('load', init_form);

function set_dfp (){
  const fpPromise = import('https://openfpcdn.io/fingerprintjs/v3')
  .then(FingerprintJS => FingerprintJS.load())

  fpPromise
  .then(fp => fp.get())
  .then(result => {
    var textbox_element = document.getElementById("result_box");
    var new_element = document.createElement("div");
    new_element.textContent = result.visitorId;
    new_element.classList.add("devicefingerprinting_result");
    textbox_element.appendChild(new_element);
  })
};

function get_dfp (){
  const button = document.getElementById("button")
  button.addEventListener("click", (e) => {
    e.preventDefault();
    set_dfp();
  });
};

window.addEventListener('load', get_dfp);