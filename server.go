package demoslandingvideo

import (
	"net/http"
	"github.com/yosssi/ace"
	"appengine"
)

// Magic values for the template engine
func appEngineEnvironment(e string) string {
	if appengine.IsDevAppServer() {
		if e == "isDevelopment" {
			return "true"
			} else {
				return ""
			}
		} else {
			if e == "isProduction" {
				return "true"
				} else {
					return ""
				}
		}
}

func homeHandler(w http.ResponseWriter, r *http.Request) {
	c := appengine.NewContext(r)

	data := map[string]string{
		"isDevelopment": appEngineEnvironment("isDevelopment"),
		"isProduction": appEngineEnvironment("isProduction"),
		"currentHostname": appengine.DefaultVersionHostname(c),
	}

	tpl, err := ace.Load("base", "inner", &ace.Options{
			BaseDir: "views",
			DynamicReload: true})
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	if err := tpl.Execute(w, data); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func init() {
	http.HandleFunc("/", homeHandler)
}