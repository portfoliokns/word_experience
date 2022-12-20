function password_no_control(){
  try {
    const password_form = document.getElementById("password_form");
    const password = document.getElementById("password");
    const passwordConfirmation = document.getElementById("password-confirmation");

    password.value = '';
    passwordConfirmation.value = '';
    password.disabled = true;
    passwordConfirmation.disabled = true;
    password_form.setAttribute("style", "display: none;");
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
};

function password_control(){
  try {
    const password_form = document.getElementById("password_form");
    const password = document.getElementById("password");
    const passwordConfirmation = document.getElementById("password-confirmation");

    password.value = '';
    passwordConfirmation.value = '';
    password.disabled = false;
    passwordConfirmation.disabled = false;
    password_form.setAttribute("style", "display: block;");
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
};

function change_form(status){
  try {
    if (status) {
      password_control()
    } else {
      password_no_control();
    };


  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
};

function init_form(){
  try {
    const passwordCheckBox = document.getElementById("password_check_box");
    passwordCheckBox.addEventListener('click', function() {
      const status = passwordCheckBox.checked
      change_form(status);
    })
    password_no_control();
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
};

window.addEventListener('load', init_form);