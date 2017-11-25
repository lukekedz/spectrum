$(document).ready(function() {
  var i            = 0;
  var prevIdInt    = 7;
  var titleLetters = ["s", "p", "e", "c", "t", "r", "u", "m"];
  var titleColors  = [
    "#DE212B", 
    "#DE212B", 
    "#E34F27", 
    "#E34F27", 
    "#359655",
    "#359655", 
    "#356AB5", 
    "#356AB5" 
  ]

  setInterval(function() {
    letterId = "#" + titleLetters[i];
    prevId   = "#" + titleLetters[prevIdInt];

    $(prevId).css("color", titleColors[prevIdInt]);
    $(prevId).css("text-shadow", "none");

    textShadow = "-1px -1px 0 " + titleColors[i] + ", 1px -1px 0 " + titleColors[i] + ", -1px 1px 0 " + titleColors[i] + ", 1px 1px 0 " + titleColors[i]

    $(letterId).css("color", "white");
    $(letterId).css("text-shadow", textShadow);

    prevIdInt = i;
    if (i === 7) {
      i = 0;
    } else {
      i++;
    };
  }, 1000);
});