window.onload = function() {
    if (document.cookie != "") {
        window.location.href = "/login";

    } else {
        document.body.className += "sunset-background";
        document.documentElement.className += "sunset-background";
        hiddenElements = document.getElementsByClassName("hidden");
        while (hiddenElements.length > 0) {
            var element = hiddenElements[0];
            element.className = element.className.replace(/hidden/, "");
            hiddenElements = document.getElementsByClassName("hidden");
        }
    }
}
