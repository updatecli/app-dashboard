# Updatecli Application Dashboard

The Updatecli Application Dashboard is a frontend application that shows current and expected version for listed application.
The application relies on the file `data.json` to generate the list of monitored application in the browser.
The data file relies on Updatecli to be automatically updated.

To use this project, you need to:

1. Add/Remove the application monitored  to/from file `public/data.json` then add/remove

1. Add/remove Updatecli manifest from directory `updatecli/updatecli.d/`

More information on [Updatecli](https://github.com/updatecli/updatecli)

## Project setup

### Requirements

* nodejs
* npm
* updatecli

### Install dependencies
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

### Run Updatecli in DryRun
```
export UPDATECLI_GITHUB_ACTOR=<your github username>
export UPDATECLI_GITHUB_TOKEN=<your github PAT>
updatecli diff --config updatecli/updatecli.d --values updatecli/values.yaml --experimental
```

### Run Updatecli
```
export UPDATECLI_GITHUB_ACTOR=<your github username>
export UPDATECLI_GITHUB_TOKEN=<your github PAT>
updatecli apply --config updatecli/updatecli.d --values updatecli/values.yaml --experimental
```
