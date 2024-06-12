const { readFileSync, writeFileSync } = require("fs")

/**
 * Get the file name of the prepared project file. Will either return the project passed in,
 * or "npm." + project for npm based builds
 * @param {string} project - base project file name
 * @param {commandOptions} options - command options
 * @returns {string} - file name of project file after peraration
 */
function getProjectFileName(project, options) {
    if (options.npm) {
        return `npm.${project}`
    } else {
        return project
    }
}

/**
 * Returns a task that perpares the project file for npm dpendency based builds
 * @param {string} project - base project file name
 * @param {commandOptions} options - command options
 * @returns {function} task that creates the temporary file if needed for npm based builds
 */
function prepareProjectFile(project, options) {
    if (!options.npm) {
        const task = async () => { }
        task.displayName = `Project file already exists at: ${project}`
        return task
    } else {
        const projectFileName = getProjectFileName(project, options)
        const baseFileName = project
        const projectFileTask = async () => {
            let json = JSON.parse(readFileSync(baseFileName).toString())
            if (!json.plugins || !json.files) {
                const extendsFile = readFileSync(json.extends).toString()
                const extendsJson = JSON.parse(extendsFile)
                if (!json.plugins) {
                    json.plugins = extendsJson.plugins
                }
                if (!json.files) {
                    json.files = extendsJson.files
                }
            }

            writeFileSync(projectFileName, JSON.stringify(json))
        }
        projectFileTask.displayName = `Prepare project file at ${projectFileName}`
        return projectFileTask
    }
}

module.exports = {
    getProjectFileName,
    prepareProjectFile
}
