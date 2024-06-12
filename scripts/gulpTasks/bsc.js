const { series } = require('gulp')
const shell = require('gulp-shell')
const { getProjectFileName, prepareProjectFile } = require('./projectFile')


/**
 * Runs the bsc command with options
 * @param {} options options to pass to bsc - project: project file json, outFile: name of zip
 * @returns task that executes bsc command
 */
function runBsc(options) {
    let command = './node_modules/.bin/bsc '

    // Make the command path Windows-compatible.
    if (process.platform.toLowerCase() === "win32") { // Even if OS is on 64 bits, platform has the value "win32". See https://nodejs.org/api/process.html#process_process_platform.
        command = '.\\node_modules\\.bin\\bsc '
    }

    // Append command options.
    for (const key in options) {
        command += `--${key}=${options[key]} `
    }

    const task = shell.task([
        command
    ])
    task.displayName = command

    return task
}

/**
 * build, package, or deploy a project with bsc (BrighterScript compiler)
 */
module.exports = {
    build: (project, options = { npm: false }) => {
        const actualProjectName = getProjectFileName(project, options)
        return series(
            prepareProjectFile(project, options),
            runBsc({
                project: actualProjectName,
                createPackage: false,
                deploy: false
            })
        )
    },
    package: (project, outFile, options = { npm: false }) => {
        const actualProjectName = getProjectFileName(project, options)
        return series(
            prepareProjectFile(project, options),
            runBsc({
                project: actualProjectName,
                outFile: `out/${outFile}`,
                createPackage: true,
                deploy: false,
            })
        )
    },
    deploy: (project, options = { npm: false }) => {
        const actualProjectName = getProjectFileName(project, options)
        return series(
            prepareProjectFile(project, options),
            runBsc({
                project: actualProjectName,
                createPackage: true,
                deploy: true,
                host: process.env.ROKU_DEV_TARGET,
                username: "rokudev",
                password: process.env.ROKU_DEV_PASSWORD || 'rokudev'
            })
        )
    }
};
