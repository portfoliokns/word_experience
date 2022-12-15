function changeFontColor (obj, params) {
  try {
    if (obj != null){
      obj.addEventListener('mouseover', function(){
        this.setAttribute("style", "color: " + params)
      });
  
      obj.addEventListener('mouseout', function(){
        this.removeAttribute("style")
      });
    };
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
}

function changeBackgroundColorForEach (objects, params) {
  try {
    objects.forEach(function (obj) {
      obj.addEventListener('mouseover', function(){
        this.setAttribute("style", "background-color: " + params)
      });
  
      obj.addEventListener('mouseout', function(){
        this.removeAttribute("style")
      });
    });
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
}

function changeBackgroundColor (obj, params) {
  try {
    if (obj != null){
      obj.addEventListener('mouseover', function(){
        this.setAttribute("style", "background-color: " + params)
      });
  
      obj.addEventListener('mouseout', function(){
        this.removeAttribute("style")
      });
    };
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
}

function mouse_over (){
  const iconText = document.getElementById("icon_text");
  const questionFormButton = document.getElementById("question_form_button");
  const manualFormButton = document.getElementById("manual_form_button");
  const aboutFormButton = document.getElementById("about_form_button");
  const tweetButton = document.getElementById("tweet_button");
  const logoutButton = document.getElementById("logout_button");
  const userNicknameButton = document.getElementById("user_nickname_button");
  const loginButton = document.getElementById("login_button");
  const signUpButton = document.getElementById("sign_up_button");
  changeFontColor(iconText,"#8bb2ec");
  changeBackgroundColor(questionFormButton,"#f7ddd6");
  changeBackgroundColor(manualFormButton,"#f7ddd6");
  changeBackgroundColor(aboutFormButton,"#f7ddd6");
  changeBackgroundColor(tweetButton,"#8ac8ee");
  changeBackgroundColor(logoutButton,"#ebc19e");
  changeBackgroundColor(userNicknameButton,"#b7bcec");
  changeBackgroundColor(loginButton,"#ebc19e");
  changeBackgroundColor(signUpButton,"#99e1e3");

  const sideBarContents = document.querySelectorAll(".side_bar_content");
  changeBackgroundColorForEach(sideBarContents,"#1df2201c");
  
  const orangeButton = document.getElementById("orange_button");
  const blueButton = document.getElementById("blue_button");
  const grayButton = document.getElementById("gray_button");
  changeBackgroundColor(orangeButton,"#ebc19e");
  changeBackgroundColor(blueButton,"#8ac8ee");
  changeBackgroundColor(grayButton,"#b0aca8");

  const silverButtons = document.querySelectorAll(".word_button_edit");
  changeBackgroundColorForEach(silverButtons,"#d5d6ed66");
};

window.addEventListener('load', mouse_over);