function alertChecker() {
    var alerts = document.getElementsByClassName('alert');
    if(alerts[0].innerText.length == 0){
        alerts[0].classList.remove("block");
    }else{
        alerts[0].classList.add("block");
    }
}

export default alertChecker
