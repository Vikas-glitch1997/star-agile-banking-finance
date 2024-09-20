pipeline {
    agent any

    tools {
        // Use the Maven tool configured in Jenkins. Ensure the name "maven s/w" matches the configured Maven tool.
        maven "maven s/w"
    }

    stages {
        stage('Build') {
            steps {
                // Checkout code from the specified GitHub repository.
                git 'https://github.com/Vikas-glitch1997/star-agile-banking-finance.git'

                // Run Maven clean package while ignoring test failures.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
    }
}
