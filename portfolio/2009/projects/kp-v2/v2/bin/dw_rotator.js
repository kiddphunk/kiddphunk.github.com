fooRotator.restartDelay = 500;
fooRotator.col=[];

function fooRotator(name,speed,path,tgt){
	this.name=name;
	this.speed=speed||4500;
	this.path=path||"";
	this.tgt=tgt;
	this.ctr=0;
	this.timer=0;
	this.imgs=[];
	this.index=fooRotator.col.length;
	fooRotator.col[this.index]=this;
	this.animString="fooRotator.col["+this.index+"]";
};

fooRotator.prototype.addImages=function(){
	var img;
	for(var i=0; arguments[i]; i++) {
		img=new Image();
		img.src=this.path+arguments[i];
		this.imgs[this.imgs.length]=img;
	}
};

fooRotator.prototype.rotate=function(){
	clearTimeout(this.timer);
	this.timer=null;
	if(this.ctr<this.imgs.length-1)
		this.ctr++;
	else this.ctr=0;
	
	var imgObj=document.images[this.name];
	if(imgObj){
		imgObj.src=this.imgs[this.ctr].src;
		this.timer=setTimeout(this.animString+".rotate()",this.speed);
	}
};

fooRotator.start=function(){
	var len=fooRotator.col.length,obj;
	for(var i=0; i<len; i++){
		obj=fooRotator.col[i];
		if(obj&&obj.name) {
			obj.timer=setTimeout(obj.animString+".rotate()",obj.speed);
		}
	}
};
