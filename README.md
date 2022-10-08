# Updatecli Application Dashboard

The Updatecli Application Dashboard is a frontend application that shows current and expected version for listed application.
The application relies on the file `data.json` to generate the list of monitored application in the browser.
The data file relies on Updatecli to be automatically updated.

To use this project, you need to:

. Add/remove the application monitored  to the file `data.json` then add/remove
. Add/remove Updatecli manifest from directory `updatecli/updatecli.d/`

More information on [Updatecli](https://github.com/updatecli/updatecli)

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
