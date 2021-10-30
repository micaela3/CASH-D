function addQuery(val){
	if(val){
		if(window.location.href.indexOf("?") > -1){
			let index = window.location.href.indexOf(val.substring(0, val.indexOf("=")));
			if(index > -1 ){
				console.log("heklk");
				if(index < window.location.href.indexOf("&")){
					console.log("hello");
					window.location.href = window.location.href.replace(window.location.href.substring(index, window.location.href.indexOf("&")), val);
				}else{
					window.location.href = window.location.href.replace(window.location.href.substring(index, window.location.href.length), val);
				}
			}else{
				window.location.href += '&' + val;
			}
		} else {
			window.location.href += "?" + val;
		}
	}
}

export default addQuery
