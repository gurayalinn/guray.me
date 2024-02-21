package main

import (
	"fmt"
	"log/slog"
	"net/http"
	"os"
	"strconv"
	"time"

	"github.com/gurayalinn/guray.me/pkg/handlers"
	env "github.com/gurayalinn/guray.me/pkg/helpers"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	// Run your server.
	if err := runServer(); err != nil {
		slog.Error("Failed to start server!", "details", err.Error())
		os.Exit(1)
	}
}

func runServer() error {
	// Validate environment variables.
	port, err := strconv.Atoi(env.Getenv("BACKEND_PORT", "8000"))
	if err != nil {
		return err
	}

	// Create a new Echo server.
	echo := echo.New()

	// Add Echo middlewares.
	echo.Use(middleware.Recover())
	echo.Use(middleware.Logger())

	// Content Security Policy
	// csp := "default-src 'self'; " +
	// 	// "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdn.jsdelivr.net https://eu.umami.is;" +
	// 	// "style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://eu.umami.is https://fonts.googleapis.com;" +
	// 	// "img-src 'self' data: https://res.cloudinary.com https://images.unsplash.com/ https://images.pexels.com/;" +
	// 	// "font-src 'self' https://fonts.gstatic.com https://raw.githubusercontent.com;" +
	// 	// "connect-src 'self' https://ssl.gstatic.com https://eu.umami.is;" +
	// 	"object-src 'none'; " +
	// 	"media-src 'self'; " +
	// 	"frame-src 'none'; " +
	// 	"frame-ancestors 'none'; " +
	// 	"form-action 'self'; " +
	// 	"base-uri 'self'; " +
	// 	"upgrade-insecure-requests; " +
	// 	"block-all-mixed-content; "

	// hstsMaxAge := 3600

	// e.Use(middleware.SecureWithConfig(middleware.SecureConfig{
	// 	XSSProtection:         "1; mode=block",
	// 	ContentTypeNosniff:    "nosniff",
	// 	XFrameOptions:         "SAMEORIGIN",
	// 	HSTSMaxAge:            hstsMaxAge,
	// 	ContentSecurityPolicy: csp,
	// }))

	// echo static files serve
	echo.Static("/assets", "assets")
	echo.Static("/dist", "dist")
	echo.Static("/", "assets/favicon/")
	echo.Static("/", "assets")

	// Routes
	echo.GET("/", handlers.IndexViewHandler)
	echo.GET("/api/hello", handlers.ShowContentAPIHandler)

	// Create a new server instance with options from environment variables.
	// For more information, see https://blog.cloudflare.com/the-complete-guide-to-golang-net-http-timeouts/
	const writeTimeout = 10 * time.Second

	const readTimeout = 5 * time.Second

	server := &http.Server{
		Addr:         fmt.Sprintf(":%d", port),
		Handler:      echo, // handle all Echo routes
		ReadTimeout:  readTimeout,
		WriteTimeout: writeTimeout,
	}

	// Send log message.
	slog.Info("Starting server... 🚀", "port", port)

	// echo.Logger.Fatal(echo.Start(server))
	return server.ListenAndServe()
}
