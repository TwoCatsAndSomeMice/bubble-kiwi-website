var colours = ["#EF562E","#FBC830","#790F6D"];

$('.pie').each(function(_, pie) {
  var circles = [];
  console.log(pie);
  var charts = JSON.parse(pie.innerText);
  console.log(charts);
  var primary = pie.attributes._primary.value;

  var p = parseFloat(pie.textContent);
  var label = pie.textContent.toString();
  var NS = "http://www.w3.org/2000/svg";
  var svg = document.createElementNS(NS, "svg");
  var title = document.createElementNS(NS, "title");
  svg.setAttribute("viewBox", "0 0 100 100");
  var offset = 0;
  var keys = Object.keys(charts);
  console.log(keys.length);
  for (var i = keys.length-1; i >= 0; i--) {
    var obj = charts[keys[i]];
    var p = obj.pct;
    console.log(p);
    console.log(charts[keys[i]]);

    var circle = document.createElementNS(NS, "circle");
    circle.setAttribute("r", 50);
    circle.setAttribute("cx", 50);
    circle.setAttribute("cy", 50);
    circle.setAttribute("fill", colours[i]);
    offset = offset + (p * 3.77);
    circle.setAttribute("stroke-dasharray", offset + " 377");
    svg.appendChild(circle);
  }
  
  title.textContent = pie.textContent;
  pie.innerText = '';
  svg.appendChild(title);
  svg.appendChild(circle);
  pie.appendChild(svg);
});

