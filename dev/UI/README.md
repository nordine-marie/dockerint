##UI FOLDER README 

### Build the Dockerfile
```
docker build -t dockerint_web_ui .
```
### Run the UI web server container

```
docker run -it --rm -d -p 8080:80 --name web dockerint_web_ui
```

The UI would then be available over [**http://localhost:8080/**](http://localhost:8080/)

