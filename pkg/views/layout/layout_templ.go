// Code generated by templ - DO NOT EDIT.

// templ: version: v0.2.543
package layout

//lint:file-ignore SA4006 This context is only used if a nested component is present.

import "github.com/a-h/templ"
import "context"
import "io"
import "bytes"

import "github.com/gurayalinn/guray.me/pkg/views/pages"

func Layout(title string, metaTags, bodyContent templ.Component) templ.Component {
	return templ.ComponentFunc(func(ctx context.Context, templ_7745c5c3_W io.Writer) (templ_7745c5c3_Err error) {
		templ_7745c5c3_Buffer, templ_7745c5c3_IsBuffer := templ_7745c5c3_W.(*bytes.Buffer)
		if !templ_7745c5c3_IsBuffer {
			templ_7745c5c3_Buffer = templ.GetBuffer()
			defer templ.ReleaseBuffer(templ_7745c5c3_Buffer)
		}
		ctx = templ.InitializeContext(ctx)
		templ_7745c5c3_Var1 := templ.GetChildren(ctx)
		if templ_7745c5c3_Var1 == nil {
			templ_7745c5c3_Var1 = templ.NopComponent
		}
		ctx = templ.ClearChildren(ctx)
		_, templ_7745c5c3_Err = templ_7745c5c3_Buffer.WriteString("<!doctype html><html prefix=\"og: https://ogp.me/ns#\" lang=\"tr\" class=\"no-js\"><head><meta charset=\"UTF-8\">")
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		templ_7745c5c3_Err = metaTags.Render(ctx, templ_7745c5c3_Buffer)
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		_, templ_7745c5c3_Err = templ_7745c5c3_Buffer.WriteString("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\"><meta http-equiv=\"content-language\" content=\"tr\"><base target=\"_top\" href=\"/\"><title>")
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		var templ_7745c5c3_Var2 string
		templ_7745c5c3_Var2, templ_7745c5c3_Err = templ.JoinStringErrs(title)
		if templ_7745c5c3_Err != nil {
			return templ.Error{Err: templ_7745c5c3_Err, FileName: `pkg/views/layout/layout.templ`, Line: 15, Col: 17}
		}
		_, templ_7745c5c3_Err = templ_7745c5c3_Buffer.WriteString(templ.EscapeString(templ_7745c5c3_Var2))
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		_, templ_7745c5c3_Err = templ_7745c5c3_Buffer.WriteString("</title><!-- FAVICON --><link rel=\"manifest\" href=\"/assets/site.webmanifest\" crossorigin=\"use-credentials\"><meta name=\"msapplication-config\" content=\"/assets/browserconfig.xml\"><meta name=\"msapplication-TileColor\" content=\"#000\"><link rel=\"alternate\" type=\"application/rss+xml\" href=\"/assets/feed.xml\"><link rel=\"apple-touch-icon\" sizes=\"180x180\" href=\"/assets/favicon/apple-touch-icon.png\"><link rel=\"shortcut icon\" href=\"/assets/favicon/favicon.svg\" type=\"image/svg+xml\" sizes=\"any\"><link rel=\"mask-icon\" href=\"/assets/favicon/favicon.svg\" type=\"image/svg+xml\" sizes=\"any\"><link rel=\"icon\" href=\"/assets/favicon/favicon.svg\" type=\"image/svg+xml\" sizes=\"any\"><!-- OPENGRAPH --><meta property=\"og:title\" content=\"guray.me\"><meta property=\"og:description\" content=\"Güray ALIN - Kişisel web sitesi\"><meta property=\"og:type\" content=\"website\"><meta property=\"og:url\" content=\"http://guray.me\"><meta property=\"og:headline\" content=\"guray.me\"><meta property=\"og:author\" content=\"Güray ALIN\"><meta property=\"og:published_time\" content=\"2024-01-10T08:20:00+03:00\"><meta property=\"og:modified_time\" content=\"2024-01-10T09:20:00+03:00\"><meta property=\"og:updated_time\" content=\"2024-01-10T10:20:00+03:00\"><meta property=\"og:image\" content=\"http://guray.me/assets/favicon/favicon.svg\"><meta property=\"og:image:alt\" content=\"guray.me\"><meta property=\"og:image:width\" content=\"512\"><meta property=\"og:image:height\" content=\"512\"><meta property=\"og:site_name\" content=\"guray.me\"><meta property=\"og:locale\" content=\"tr_TR\"><meta property=\"og:locale:alternate\" content=\"en_US\"><!-- TWITTER --><meta name=\"twitter:title\" content=\"guray.me\"><meta name=\"twitter:description\" content=\"Güray ALIN - Kişisel web sitesi\"><meta name=\"twitter:url\" content=\"http://guray.me/\"><meta name=\"twitter:image\" content=\"http://guray.me/assets/img/favicon.svg\"><meta name=\"twitter:image:alt\" content=\"guray.me\"><meta name=\"twitter:card\" content=\"summary_large_image\"><meta name=\"twitter:creator\" content=\"@gurayalin\"><meta name=\"twitter:site\" content=\"@gurayalin\"><meta name=\"twitter:account_id\" content=\"1493274529774321666\"><!-- ROBOTS --><link rel=\"canonical\" href=\"http://guray.me/\"><meta name=\"robots\" content=\"index, follow, max-snippet:-1, max-video-preview:-1, max-image-preview:-1\"><meta name=\"googlebot\" content=\"index, follow\"><meta name=\"google-analytics\" content=\"G-\"><meta name=\"google-site-verification\" content=\"KEY\"><link rel=\"author\" href=\"/assets/humans.txt\"><link rel=\"copyright\" href=\"http://guray.me/\"><link rel=\"me\" href=\"http://twitter.com/gurayalin\"><link rel=\"me\" href=\"http://www.linkedin.com/in/gurayalin\"><link rel=\"alternate\" href=\"http://guray.me/\" hreflang=\"x-default\"><!-- MOBILE --><meta name=\"HandheldFriendly\" content=\"true\"><meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\"><meta name=\"apple-mobile-web-app-title\" content=\"guray.me\"><meta name=\"apple-mobile-web-app-capable\" content=\"yes\"><meta name=\"mobile-web-app-capable\" content=\"yes\"><meta name=\"application-name\" content=\"guray.me\"><!-- THEME --><meta name=\"supported-color-schemes\" content=\"light dark\"><meta name=\"color-scheme\" content=\"light dark\"><meta name=\"theme-color\" content=\"#fff\" media=\"(prefers-color-scheme: light)\"><meta name=\"theme-color\" content=\"#000\" media=\"(prefers-color-scheme: dark)\"><!-- SECURITY CONFIGS --><meta name=\"referrer\" content=\"strict-origin-when-cross-origin\"><meta http-equiv=\"x-dns-prefetch-control\" content=\"on\"><meta http-equiv=\"X-Content-Type-Options\" content=\"nosniff\"><meta http-equiv=\"Cache-Control\" content=\"max-age=31536000\"><meta http-equiv=\"Strict-Transport-Security\" content=\"max-age=31536000; includeSubDomains; preload\"><!-- CSP CONFIG --><link rel=\"stylesheet\" href=\"/assets/fonts/Inter/inter.css\" rel=\"preload\"><link rel=\"stylesheet\" href=\"/assets/css/print.css\" media=\"print\" rel=\"preload\"><link rel=\"stylesheet\" href=\"/assets/css/style.css\" media=\"all\" rel=\"preload\"></head>")
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		templ_7745c5c3_Err = templ.RenderScriptItems(ctx, templ_7745c5c3_Buffer, pages.BodyScripts())
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		_, templ_7745c5c3_Err = templ_7745c5c3_Buffer.WriteString("<body class=\"bg-stone-300 dark:bg-slate-800 w-full h-full antialiased font-sans\" onload=\"")
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		var templ_7745c5c3_Var3 templ.ComponentScript = pages.BodyScripts()
		_, templ_7745c5c3_Err = templ_7745c5c3_Buffer.WriteString(templ_7745c5c3_Var3.Call)
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		_, templ_7745c5c3_Err = templ_7745c5c3_Buffer.WriteString("\"><div id=\"app\" class=\"flex flex-col min-h-screen justify-between w-full\">")
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		templ_7745c5c3_Err = Header().Render(ctx, templ_7745c5c3_Buffer)
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		templ_7745c5c3_Err = bodyContent.Render(ctx, templ_7745c5c3_Buffer)
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		templ_7745c5c3_Err = Footer().Render(ctx, templ_7745c5c3_Buffer)
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		_, templ_7745c5c3_Err = templ_7745c5c3_Buffer.WriteString("<script defer type=\"module\" src=\"/assets/js/bundle.js\"></script><!-- JSON-LD --><script type=\"application/ld+json\">\n\t\t\t{\n\t\t\t\t\"@context\": \"https://schema.org\",\n\t\t\t\t\"@type\": \"WebSite\",\n\t\t\t\t\"name\": \"guray.me\",\n\t\t\t\t\"alternateName\": \"guray.me\",\n\t\t\t\t\"url\": \"http://guray.me/\",\n\t\t\t\t\"description\": \"Güray ALIN - Kişisel web sitesi\",\n\t\t\t\t\"headline\": \"guray.me\",\n\t\t\t\t\"mainEntityOfPage\": \"http://guray.me/\",\n\t\t\t\t\"image\": \"http://guray.me/assets/favicon/favicon.svg\",\n\t\t\t\t\"datePublished\": \"2024-01-10T08:20:00+03:00\",\n\t\t\t\t\"dateModified\": \"2024-01-10T09:20:00+03:00\"\n\t\t\t\t}\n\t\t\t\t</script></div></body></html>")
		if templ_7745c5c3_Err != nil {
			return templ_7745c5c3_Err
		}
		if !templ_7745c5c3_IsBuffer {
			_, templ_7745c5c3_Err = templ_7745c5c3_Buffer.WriteTo(templ_7745c5c3_W)
		}
		return templ_7745c5c3_Err
	})
}
