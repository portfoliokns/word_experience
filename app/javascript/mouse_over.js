function changeFontColor (obj, params) {
  try {
    if (obj != null){
      obj.addEventListener('mouseover', function(){
        this.setAttribute("style", "color: " + params);
      });
  
      obj.addEventListener('mouseout', function(){
        this.removeAttribute("style");
      });
    };
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
}

function changeColorUnderlineForEach (objects, params) {
  try {
    objects.forEach(function (obj) {
      obj.addEventListener('mouseover', function(){
        this.setAttribute("style", "text-decoration: underline; color: " + params);
      });
  
      obj.addEventListener('mouseout', function(){
        this.removeAttribute("style");
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
        this.setAttribute("style", "background-color: " + params);
      });
  
      obj.addEventListener('mouseout', function(){
        this.removeAttribute("style");
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
        this.setAttribute("style", "background-color: " + params);
      });
  
      obj.addEventListener('mouseout', function(){
        this.removeAttribute("style");
      });
    });
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
}

function tooltipForEach (tooltip_blocks) {
  try {
    tooltip_blocks.forEach(function (tooltip_block) {
      tooltip_block.addEventListener('mouseover', function(){
        const tooltip = tooltip_block.children["tooltip"];
        tooltip.setAttribute("style", "display: block;");
      });

      tooltip_block.addEventListener('mouseout', function(){
        const tooltip = tooltip_block.children["tooltip"];
        tooltip.removeAttribute("style");
      });
    });
  } catch (error) {
    alert('javascriptで問題が発生しました。' + error);
  }
}

function iconFocusForEach (objects,params) {
    try {
      objects.forEach(function (obj) {
        obj.addEventListener('mouseover', function(){
          const previousElement = obj.previousElementSibling
          previousElement.setAttribute("style", "-webkit-text-stroke:1px " + params);
        });
    
        obj.addEventListener('mouseout', function(){
          const previousElement = obj.previousElementSibling
          previousElement.removeAttribute("style");
        });
      });
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

  const reputationLinkStar = document.querySelectorAll(".reputation_link_star");
  const reputationLinkBad = document.querySelectorAll(".reputation_link_bad");
  const copyTexts = document.querySelectorAll(".word_name");
  const silverButtons = document.querySelectorAll(".word_button_edit");
  const userProfileLinks = document.querySelectorAll(".user_profile_link");
  iconFocusForEach(reputationLinkStar,"#4e7651eb");
  iconFocusForEach(reputationLinkBad,"#484bef");
  changeBackgroundColorForEach(copyTexts,"#f0fbfb");
  changeBackgroundColorForEach(silverButtons,"#b3b4ce42");
  changeColorUnderlineForEach(userProfileLinks,"#373cd3");

  const tooltip_blocks = document.querySelectorAll(".tooltip_block");
  tooltipForEach(tooltip_blocks);
};

window.addEventListener('load', mouse_over);