function yesnoCheck(that) {
    if (that.value == "other") {
  alert("check");
        document.getElementById("ifYes").style.display = "block";
    } else {
        document.getElementById("ifYes").style.display = "none";
    }
}