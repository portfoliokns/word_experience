// function get_dfp (){
//   const fpPromise = import('https://openfpcdn.io/fingerprintjs/v3')
//   .then(FingerprintJS => FingerprintJS.load())

//   fpPromise
//   .then(fp => fp.get())
//   .then(result => {
//       console.log(result.visitorId);
//       console.log(result.confidence.score);
//       console.log(result.confidence.comment);
//       console.log(navigator.plugins);
//       console.log(navigator.userAgent);
//       console.log(navigator.language);
//       console.log(navigator.hardwareConcurrency);
//       console.log(screen.colorDepth);
//       console.log(new Date().getTimezoneOffset());
//       console.log(window.sessionStorage);
//       console.log(navigator.connection);
//       console.log(navigator.deviceMemory);
//       console.log(navigator.languages);
//       console.log(navigator.maxTouchPoints);
//       console.log(navigator.mediaCapabilities);
//       console.log(navigator.vendor);
//       console.log(navigator.webdriver);
//       console.log(screen.height);
//       console.log(screen.orientation);
//       console.log(screen.width);
//   })
// };

// window.addEventListener('load', get_dfp);


function sub_main_hidden(){
  try {
    const password_form = document.getElementById("sub_main");
    password_form.setAttribute("style", "display: none;");
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
};

function sub_main_display(){
  try {
    const password_form = document.getElementById("sub_main");
    password_form.setAttribute("style", "display: flex;");
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