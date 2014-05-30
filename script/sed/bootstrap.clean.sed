# Clean up URLs in Bootstrap docs
s|href=".*/dist/css/bootstrap.min.css"|href="//assets/themes/leafy.css?body=1"|g
s|href=".*/dist/js/bootstrap.min.js"|href="//assets/themes/leafy.js?body=1"|g
/jquery.min.js/d
/ads.html/d

# Fix asset paths in docs
s|href="../assets/|href="/assets/bootstrap/|g
s|src="../assets/|src="/assets/bootstrap/|g
s|src="assets/|src="/assets/bootstrap/|g
