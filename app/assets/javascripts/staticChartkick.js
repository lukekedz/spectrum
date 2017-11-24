$(document).ready(function() {
  selectedTeamsSet = new Set;
  category         = "";

  selectTeam = function(id) {
    var teamCardId = "#team-" + id;

    if (selectedTeamsSet.has(id)) {
      $(teamCardId)[0].className = "card-panel grey lighten-2"
      selectedTeamsSet.delete(id);
    } else {
      $(teamCardId)[0].className = "card-panel blue lighten-2"
      selectedTeamsSet.add(id);
    };
  };

  selectAllTeams = function() {
    clearTeamSet();

    var i = 1;
    while (i <= 12) {
      selectedTeamsSet.add(i);

      var teamCardId = "#team-" + i;
      $(teamCardId)[0].className = "card-panel blue lighten-2";
      i += 1;
    };
  };

  selectCategory = function(cat) {
    var categoryId = "#" + cat;

    if (cat === category) {
      $(categoryId)[0].className = "card-panel grey lighten-2";
      clearCategory();
      category = "";
    } else {
      clearCategory();
      $(categoryId)[0].className = "card-panel blue lighten-2";
      category = cat;
    };
  };

  resetAll = function() {
    clearTeamSet();
    clearCategory();
    category = "";
  };

  clearTeamSet = function() {
    var i = 1;
    
    while (i <= 12) {
      var teamCardId = "#team-" + i;
      $(teamCardId)[0].className = "card-panel grey lighten-2";
      i += 1;
    };

    selectedTeamsSet.clear();
  };

  clearCategory = function() {
    var cats = ["g", "a", "ppp", "pim", "def", "fow", "sog", "hit", "w", "sv", "so", "gaa", "prcnt"]

    cats.forEach(function(cat) {
      var categoryId = "#" + cat;
      $(categoryId)[0].className = "card-panel grey lighten-2";
    });
  };

  clearAndCloseModal = function() {
    $('#chart-modal').empty();
    $('#chart').modal('close');
    resetAll();
  }

  modifySelection = function() {
    $('#chart-modal').empty();
    $('#chart').modal('close');
  }

  loadGraph = function() {
    if (selectedTeamsSet.size == 0) {
      alert('You must select at least one team!');
      return;
    };

    if (category === "") {
      alert('You must select a category.');
      return;
    };

    $.ajax({
      data: { teams: Array.from(selectedTeamsSet), category: category },
      type: "GET",
      url: "/site/static_chartkick_modal",
      success: function(data) {
        $('#chart-modal').append(data);
        $('#chart').modal('open');
      }
    });
  };

});
