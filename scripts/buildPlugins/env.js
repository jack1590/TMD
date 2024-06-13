const path = require('path')
const fs = require('fs')
require('dotenv').config()

module.exports = function () {
    return {
        name: 'replaceEnvVars',
        afterPublish: (program, files) => {
            const configFile = path.join(program.options.stagingFolderPath, '/config/config.json');
            let configContent = fs.readFileSync(configFile).toString();

            // Regular expression to find ${VARIABLE}
            const regex = /\$\{(\w+)\}/g;

            // Replace all occurrences of ${VARIABLE} with the corresponding environment variable value
            configContent = configContent.replace(regex, (match, p1) => {
                const envVarValue = process.env[p1];
                if (envVarValue !== undefined) {
                    return envVarValue;
                } else {
                    console.warn(`Environment variable ${p1} not found`);
                    return match; // Keep the original placeholder if the env variable is not found
                }
            });

            fs.writeFileSync(configFile, configContent);
        }
    };
};
