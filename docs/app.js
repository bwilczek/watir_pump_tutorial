$(function() {

  let delay = 0
  if(document.location.href.match(/random_delay/)) {
    delay = parseInt((Math.random() * 800) + 200)
  }

  // Greeter
  setTimeout(() => {
    $('.start_hidden').show()
  }, delay)

  $('button#set_name').click((e) => {
    $('span#greeted_name').text($('input#name').val())
  })

  // ToDo lists
  $('div[role="todo_list"] button').click((e) => {
    setTimeout(() => {
      let newText = e.target.parentNode.querySelector('input').value
      if(newText == '') {
        return
      }
      let ul = e.target.parentNode.querySelector('ul')
      let newLi = document.createElement('li')
      let nameSpan = document.createElement('span')
      nameSpan.innerText = newText
      nameSpan.setAttribute('role', 'name')
      let rmA = document.createElement('a')
      rmA.setAttribute('role', 'rm')
      rmA.onclick = rmTodoItem
      rmA.innerText = '[rm]'
      newLi.appendChild(nameSpan)
      newLi.appendChild(rmA)
      ul.appendChild(newLi)
      e.target.parentNode.querySelector('input').value = ''
    }, delay)
  })

  rmTodoItem = (e) => {
    setTimeout(() => {
      let li = e.target.parentNode
      li.parentNode.removeChild(li)
    }, delay)
  }

  $('a[role="rm"]').click(rmTodoItem)
});

function getUrlParams(url) {
  // http://stackoverflow.com/a/23946023/2407309
  if (typeof url == 'undefined') {
    url = window.location.search
  }
  url = url.split('#')[0] // Discard fragment identifier.
  let urlParams = {}
  let queryString = url.split('?')[1]
  if (!queryString) {
    if (url.search('=') !== false) {
      queryString = url
    }
  }
  if (queryString) {
    let keyValuePairs = queryString.split('&')
    for (let i = 0; i < keyValuePairs.length; i++) {
      let keyValuePair = keyValuePairs[i].split('=')
      let paramName = keyValuePair[0]
      let paramValue = keyValuePair[1] || ''
      urlParams[paramName] = decodeURIComponent(paramValue.replace(/\+/g, ' '))
    }
  }
  return urlParams
}

function displayUrlParams() {
  let params = getUrlParams()
  let k, v
  for(k in params) {
    v = params[k]
    $('#url-params').append($(`<li>${k}: ${v}</li>`))
  }
}
