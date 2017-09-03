function change_background() {
  this.style.backgroundColor = '#80808044';
}

function defoult_background() {
  this.style.backgroundColor = '';
}

function hide_paragraph(){
  document.getElementById('message').style.display = 'none';
}

document.addEventListener('DOMContentLoaded', function(){
  var button = document.getElementById('sing_up_for_free')
  var button_submit = document.getElementById('input_button')
  var text_message = document.getElementById('message').innerHTML
  var login_button = document.getElementById('button').children
  button.addEventListener("mouseover", change_background);
  button.addEventListener("mouseout", defoult_background);
  if (!text_message){
    button_submit.addEventListener("click", function(){});
  } else {
    button_submit.addEventListener("click", hide_paragraph());
    alert(text_message);
  }
})
