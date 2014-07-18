# Fix grunt dependency
s|"grunt": "~0.4.2"|"grunt": "0.4.2"|g

# Clean up URLs in Bootstrap docs
# s|href=".*/dist/css/bootstrap.min.css"|href="/assets/themes/leafy.css?body=1"|g
# s|src=".*/dist/js/bootstrap.min.js"|src="/assets/themes/leafy.js?body=1"|g
s|href=".*/dist/css/bootstrap.min.css"|href="/assets/themes/theme.css"|g
s|src=".*/dist/js/bootstrap.min.js"|src="/assets/themes/theme.js"|g
/jquery.min.js/d
/ads.html/d
/social-buttons.html/d

# Fix asset paths in docs
s|href="../assets|href="/assets/bootstrap|g
s|src="../assets|src="/assets/bootstrap|g
s|src="assets|src="/assets/bootstrap|g
s|src="../examples/screenshots|src="/assets/bootstrap/img/screenshots|g
