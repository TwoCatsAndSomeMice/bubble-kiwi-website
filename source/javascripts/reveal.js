$('.panel-question').each(function(_, question) {

  // keep the question id
  var questionId = question.id;
  var revealed = false;

  // find the options for the questions
  $(question).find('input').each(function(_, answer) {

    // generate the id to the answer div
    var divSelector =  '#' + answer.id.replace(questionId, 'answer');

    // make the whole list item being clickable
    var btn = $(answer).parent();
    btn.click(function() {

      // only reveal one
      if (!revealed) {
        $(divSelector).show();
        revealed = true;
      }
    });

  });
});
