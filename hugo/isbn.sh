#!/bin/bash

read -p "Enter an ISBN: " ISBN

curl -q 'https://www.babelio.com/recherche.php' \
	-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:129.0) Gecko/20100101 Firefox/129.0' \
	-H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/png,image/svg+xml,*/*;q=0.8' \
	-H 'Accept-Language: en-US,en;q=0.8,fr;q=0.5,fr-FR;q=0.3' \
	-H 'Origin: https://www.babelio.com' \
	-H 'DNT: 1' \
	-H 'Connection: keep-alive' \
	-H 'Referer: https://www.babelio.com/recherche.php' \
	-H 'Cookie: p=FR; disclaimer=1' \
	-H 'Upgrade-Insecure-Requests: 1' \
	-H 'Sec-Fetch-Dest: document' \
	-H 'Sec-Fetch-Mode: navigate' \
	-H 'Sec-Fetch-Site: same-origin' \
	-H 'Sec-Fetch-User: ?1' \
	-H 'Priority: u=0, i' \
  -F "Recherche=$ISBN" \
  -F 'recherche=' > page.html

iconv -f ISO-8859-1 -t UTF-8 page.html > pageu.html
# Extract book titles
titles=$(rg -o '<a href="/livres/[^"]*" class="titre1" >[^<]+</a>' pageu.html | sed -E 's/.*class="titre1" >([^<]+)<.*/\1/')

# Extract author names
authors=$(rg -o '<a href="/auteur/[^"]*" class="libelle" >[^<]+</a>' pageu.html | sed -E 's/.*class="libelle" >([^<]+)<.*/\1/')

# Extract book URLs
urls=$(rg -o '<a href="/livres/[^"]*' pageu.html | sed -E 's/<a href="([^"]*)/https:\/\/www.babelio.com\1/')

# Extract book thumbnail URLs
thumbnails=$(rg -o '<img loading="lazy" src="[^"]*"' pageu.html | sed -E 's/.*src="([^"]*)"/\1/')

echo $titles
echo $authors
echo $urls
echo $thumbnails

rm page.html pageu.html
