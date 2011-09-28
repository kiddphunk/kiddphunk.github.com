// Copyright © 2000 by Apple Computer, Inc., All Rights Reserved.
//
// You may incorporate this Apple sample code into your own code
// without restriction. This Apple sample code has been provided "AS IS"
// and the responsibility for its operation is yours. You may redistribute
// this code, but you are not permitted to redistribute it as
// "Apple sample code" after having made changes.
// ********************************
// application-specific functions *
// ********************************

// store variables to control where the popup will appear relative to the cursor position
// positive numbers are below and to the right of the cursor, negative numbers are above and to the left
var xOffset = 30;
var yOffset = -5;



    
function showPopup (targetObjectId, oldTargetObjectId, eventObj) {
    if(eventObj) {    
	
	// account for times when click on popup (example: href links)
    if (window.currentlyVisiblePopup == targetObjectId) {
		if (window.lastStrip == oldTargetObjectId) {
		    changeObjectVisibility(oldTargetObjectId, 'visible');
		}
	    return false;
    }
    
	// hide any currently-visible popups
	hideCurrentPopup();

	// stop event from bubbling up any farther
	eventObj.cancelBubble = true;
	
    changeObjectVisibility(oldTargetObjectId, 'hidden');
	if (window.lastStrip) {
	    changeObjectVisibility(window.lastStrip, 'visible');
	}
	// and make it visible
	if( changeObjectVisibility(targetObjectId, 'visible') &&
		changeObjectVisibility(targetObjectId+"2", 'visible') ) {
	    // if we successfully showed the popup
	    // store its Id on a globally-accessible object
	    window.currentlyVisiblePopup = targetObjectId;
	    window.lastStrip = oldTargetObjectId;
	    return true;
	} else {
	    // we couldn't show the popup, boo hoo!
	    return false;
	}
    } else {
	// there was no event object, so we won't be able to position anything, so give up
	return false;
    }
} // showPopup


function showPopups (targetObjectId1, targetObjectId2, targetObjectId3, oldTargetObjectId, eventObj) {
    if(eventObj) {
    
	// hide any currently-visible popups
	hideCurrentPopup();
	
	// stop event from bubbling up any farther
	eventObj.cancelBubble = true;
	
    changeObjectVisibility(oldTargetObjectId, 'hidden');
    changeObjectVisibility(lastStrip, 'visible');

	// and make it visible
	if( changeObjectVisibility(targetObjectId1, 'visible') && 
		changeObjectVisibility(targetObjectId2, 'visible') &&
		changeObjectVisibility(targetObjectId3, 'visible')) {
	    // if we successfully showed the popup
	    // store its Id on a globally-accessible object
	    window.currentlyVisiblePopup1 = targetObjectId1;
	    window.currentlyVisiblePopup2 = targetObjectId2;
	    window.currentlyVisiblePopup3 = targetObjectId3;
	    window.lastStrip = oldTargetObjectId;
	    return true;
	} else {
	    // we couldn't show the popup, boo hoo!
	    return false;
	}
    } else {
	// there was no event object, so we won't be able to position anything, so give up
	return false;
    }
} // showPopup

function showPopupOriginal (targetObjectId, eventObj) {
    if(eventObj) {
    
	// hide any currently-visible popups
	hideCurrentPopup();
	
	// stop event from bubbling up any farther
	eventObj.cancelBubble = true;
	
	// move popup div to current cursor position 
	// (add scrollTop to account for scrolling for IE)
	var newXCoordinate = (eventObj.pageX)?eventObj.pageX + xOffset:eventObj.x + xOffset + ((document.body.scrollLeft)?document.body.scrollLeft:0);
	var newYCoordinate = (eventObj.pageY)?eventObj.pageY + yOffset:eventObj.y + yOffset + ((document.body.scrollTop)?document.body.scrollTop:0);
	moveObject(targetObjectId, newXCoordinate, newYCoordinate);

	// and make it visible
	if( changeObjectVisibility(targetObjectId, 'visible') ) {
	    // if we successfully showed the popup
	    // store its Id on a globally-accessible object
	    window.currentlyVisiblePopup = targetObjectId;
	    return true;
	} else {
	    // we couldn't show the popup, boo hoo!
	    return false;
	}
    } else {
	// there was no event object, so we won't be able to position anything, so give up
	return false;
    }
} // showPopup

function hideCurrentPopup() {
    // note: we've stored the currently-visible popup on the global object window.currentlyVisiblePopup
    if(window.currentlyVisiblePopup) {
	changeObjectVisibility(window.currentlyVisiblePopup, 'hidden');
	window.currentlyVisiblePopup = false;
    }
    if(window.currentlyVisiblePopup1) {
	changeObjectVisibility(window.currentlyVisiblePopup1, 'hidden');
	window.currentlyVisiblePopup1 = false;
    }
    if(window.currentlyVisiblePopup2) {
	changeObjectVisibility(window.currentlyVisiblePopup2, 'hidden');
	window.currentlyVisiblePopup2 = false;
    }
    if(window.currentlyVisiblePopup3) {
	changeObjectVisibility(window.currentlyVisiblePopup3, 'hidden');
	window.currentlyVisiblePopup3 = false;
    }
} // hideCurrentPopup



// ***********************
// hacks and workarounds *
// ***********************

// initialize hacks whenever the page loads
window.onload = initializeHacks;

// setup an event handler to hide popups for generic clicks on the document
document.onclick = hideCurrentPopup;

function initializeHacks() {
    // this ugly little hack resizes a blank div to make sure you can click
    // anywhere in the window for Mac MSIE 5
    if ((navigator.appVersion.indexOf('MSIE 5') != -1) 
	&& (navigator.platform.indexOf('Mac') != -1)
	&& getStyleObject('blankDiv')) {
	window.onresize = explorerMacResizeFix;
    }
    resizeBlankDiv();
    // this next function creates a placeholder object for older browsers
    createFakeEventObj();
}

function createFakeEventObj() {
    // create a fake event object for older browsers to avoid errors in function call
    // when we need to pass the event object to functions
    if (!window.event) {
	window.event = false;
    }
} // createFakeEventObj

function resizeBlankDiv() {
    // resize blank placeholder div so IE 5 on mac will get all clicks in window
    if ((navigator.appVersion.indexOf('MSIE 5') != -1) 
	&& (navigator.platform.indexOf('Mac') != -1)
	&& getStyleObject('blankDiv')) {
	getStyleObject('blankDiv').width = document.body.clientWidth - 20;
	getStyleObject('blankDiv').height = document.body.clientHeight - 20;
    }
}

function explorerMacResizeFix () {
    location.reload(false);
}

