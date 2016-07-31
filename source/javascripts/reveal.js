$('.panel-question').each(function(_, question) {

  // keep the question id
  var questionId = question.id;
  var revealed = false;
  var answerDivs = [];

  // find the options for the questions
  $(question).find('input').each(function(_, answer) {

    // generate the id to the answer div
    var divSelector =  '#' + answer.id.replace(questionId, 'answer');
    // keep a list of answer's ids
    answerDivs.push(divSelector);

    // make the whole list item being clickable
    var btn = $(answer).parent();
    btn.click(function() {

      // hide all the answers
      $.each(answerDivs, function(_, selector) {
        $(selector).hide();
      });

      // reveal the answer
      var answer = $(divSelector);
      answer.show();

      // smooth scrolling to the answer
      $('html,body').animate({
        scrollTop: answer.offset().top
      }, 500);

    });

  });
});
