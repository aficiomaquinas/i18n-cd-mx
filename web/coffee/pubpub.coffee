jQuery('link[rel=stylesheet][href="css/main.css"]').remove()

jQuery('head').append('<link rel="stylesheet" type="text/css" href="http://localhost:8080/css/main-pub-mod-raw.css">')

jQuery('head').append('<script src="http://localhost:35729/livereload.js"></script>')

console.log "Injected cdmx css."