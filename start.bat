npx light-server -s ./static/ -p 8000 -d 300 -w """elm/**/*.elm # cd elm && elm make src/App.elm --output=../static/app.js"""
REM -w "static/*.css # # reloadcss"