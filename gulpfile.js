var gulp = require('gulp');
const minimist = require('minimist')
const bsc = require('./scripts/gulpTasks/bsc')
const npmPackage = require('./package.json');
require('dotenv').config()

const projects = {
    TMDApp: 'tmd.bsconfig.json'
}

const knownOptions = {
    string: ['project', 'name', 'buildNumber', 'rokuIp'],
    boolean: ['npm'],
    default: {
        project: 'TMDApp',
        buildNumber: 'DEBUG',
        npm: false
    }
};

const options = minimist(process.argv.slice(2), knownOptions);

const npmEnabledOptions = {
    ...options,
    npm: true
}
if (options.rokuIp) {
    process.env.ROKU_DEV_TARGET = options.rokuIp
}
const selectedProject = projects[options.project]
const dependencyType = options.npm ? "NPM" : "DEV"
const defaultPackageName = `TMDApp_${dependencyType}_${npmPackage.version}.RC_${options.buildNumber}`


tasks = {
    build: gulp.series(bsc.build(selectedProject, options)),
    package: gulp.series(bsc.package(selectedProject, options.name ?? defaultPackageName, options)),
    deploy: gulp.series(bsc.deploy(selectedProject, options)),
}

// EXPORTS
module.exports = {
    ...tasks
}
