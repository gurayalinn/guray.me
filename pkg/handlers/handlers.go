package handlers

import (
	"context"
	"log"
	"log/slog"
	"net/http"
	"os"
	"path"

	layout "github.com/gurayalinn/guray.me/pkg/views/layout"
	pages "github.com/gurayalinn/guray.me/pkg/views/pages"

	"github.com/a-h/templ"
	"github.com/angelofallars/htmx-go"
	"github.com/labstack/echo/v4"
)

func Static(filename string, t templ.Component) {
	outputDir := "assets/"
	if _, err := os.Stat(outputDir); os.IsNotExist(err) {
		mkdirErr := os.Mkdir(outputDir, 0o755)
		if mkdirErr != nil {
			log.Fatalf("failed to create output directory: %v", mkdirErr)
		}
	}

	name := path.Join(outputDir, filename)

	f, err := os.Create(name)
	if err != nil {
		log.Fatalf("failed to create output file: %v", err)
	}

	err = t.Render(context.Background(), f)
	if err != nil {
		log.Fatalf("failed to write index page: %v", err)
	}
}

// This custom Render replaces Echo's echo.Context.Render() with templ's templ.Component.Render().
func templateRender(c echo.Context, statusCode int, t templ.Component) error {
	c.Response().Writer.WriteHeader(statusCode)
	c.Response().Header().Set(echo.HeaderContentType, echo.MIMETextHTML)
	return htmx.NewResponse().RenderTempl(c.Request().Context(), c.Response().Writer, t)
}

// indexViewHandler handles a view for the index page.
func IndexViewHandler(c echo.Context) error {
	// Define template meta tags.
	metaTags := pages.MetaTags(
		"guray.me, Güray, Güray ALIN, Web, Yazılım, Siber Güvenlik", // define meta keywords
		"Güray ALIN - Kişisel web sitesi",                           // define meta description
	)

	// Define template body content.
	bodyContent := pages.BodyContent(
		"Welcome !",                      // define h1 text
		"Güray ALIN - personal website.", // define p text
	)

	// Define template layout for index page.
	indexTemplate := layout.Layout(
		"ANASAYFA",  // define title text
		metaTags,    // define meta tags
		bodyContent, // define body content
	)

	Static("index.html", indexTemplate)

	return templateRender(c, http.StatusOK, indexTemplate)
}

// showContentAPIHandler handles an API endpoint to show content.
func ShowContentAPIHandler(c echo.Context) error {
	// Check, if the current request has a 'HX-Request' header.
	// For more information, see https://htmx.org/docs/#request-headers
	if !htmx.IsHTMX(c.Request()) {
		// If not, return HTTP 400 error.
		c.Response().WriteHeader(http.StatusBadRequest)
		slog.Error("request API", "method", c.Request().Method, "status", http.StatusBadRequest, "path", c.Request().URL.Path)
		return echo.NewHTTPError(http.StatusBadRequest, http.StatusText(http.StatusBadRequest))
	}

	// Write HTML content.
	_, err := c.Response().Write([]byte("<p>🎉 Yes, <strong>htmx</strong> is ready to use! (<code>GET /api/hello</code>)</p>"))
	if err != nil {
		return err
	}

	return htmx.NewResponse().Write(c.Response().Writer)
}
