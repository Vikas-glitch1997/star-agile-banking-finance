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

        stage('Generate Test Reports') {
            steps {
                // Use relative path to surefire-reports to avoid issues with workspace changes.
                publishHTML([
                    allowMissing: false, 
                    alwaysLinkToLastBuild: false, 
                    keepAll: false, 
                    reportDir: 'target/surefire-reports',  // Relative path
                    reportFiles: 'index.html', 
                    reportName: 'HTML Report', 
                    reportTitles: '', 
                    useWrapperFileDirectly: true
                ])
            }
        }

        stage('Create Docker Image') {
            steps {
                // Build a Docker image from the Dockerfile in the root of the project.
                sh 'docker build -t vikaskumargt/bankingfinance:1.0 .'
            }
        }
       stage('Docker-Login') {
           steps {
               withCredentials([usernamePassword(credentialsId: 'docker-login', passwordVariable: 'dockerpassword', usernameVariable: 'dockerlogin')]) {
               sh 'docker login -u ${dockerlogin} -p ${dockerpassword}'
                                   }
                        }
                }
       stage('Push-Image') {
           steps {
               sh 'docker push vikaskumargt/bankingfinance:1.0'
                     }
                }
       stage('Config & Deployment') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AwsAccessKey', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    dir('terraform-files') {
                    sh 'sudo chmod 600 virginia.pem'
                    sh 'terraform init'
                    sh 'terraform validate'
                    sh 'terraform apply --auto-approve'
}
    }
}
}
    }
}
