function change_background() {
  this.style.backgroundColor = '#80808044';
}

function change_background1() {
  this.style.backgroundColor = '#F2F2F2';
}

function defoult_background() {
  this.style.backgroundColor = '';
}

function hide_paragraph(){
  document.getElementById('message').style.display = 'none';
}

document.addEventListener('DOMContentLoaded', function(){
  var button = document.getElementById('sign_up_for_free')
  var button_submit = document.getElementById('input_button')
  var login_buttons = document.getElementById('button').children
  var form = document.getElementsByTagName('tbody')
  button.addEventListener("mouseover", change_background);
  button.addEventListener("mouseout", defoult_background);

  $('#main_form').submit(function(e){
    e.preventDefault();
    $.ajax({
    url: "/urls",
    method: "post",
    data: $(this).serialize(),
    success: function(data) {
      parsed_data = JSON.parse(data);
      var position = form[0].children.length;
      if (!parsed_data.id){
        alert(parsed_data.long_url[0]);
      } else {
        $('tbody').append('\
          <tr id="content">\
            <td>' + (position + 1) + '</td>\
            <td>' + parsed_data.long_url + '</td>\
            <td><a href=" ' + parsed_data.short_url + ' ">' + parsed_data.short_url + '</a></td>\
            <td class="click_count">' + parsed_data.click_count + '</td>\
          </tr>'
        );
      }
    }
  });
  });

  login_buttons[0].addEventListener("mouseover", change_background);
  login_buttons[0].addEventListener("mouseout", defoult_background);
  login_buttons[1].addEventListener("mouseover", change_background1);
  login_buttons[1].addEventListener("mouseout", defoult_background);
})
