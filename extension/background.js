chrome.browserAction.onClicked.addListener(function() {
  chrome.tabs.getSelected(window.id, function (tab) {
    var url = tab.url;
    chrome.tabs.create({'url': "http://localhost:3000/letters/new"});
    chrome.tabs.executeScript(null,{
      "code": "document.getElementsByClassName('container__pick-form__url-group__url-value')[0].value='"+url+"'"
    });
  });
});
