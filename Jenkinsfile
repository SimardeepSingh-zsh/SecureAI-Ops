pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/SimardeepSingh-zsh/SecureAI-Ops.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Run Security Scripts') {
            parallel {
                stage('AI Key Rotation') {
                    steps {
                        sh 'python AIKeyRotation.py'
                    }
                }
                stage('Access Monitor') {
                    steps {
                        sh 'python AccessMonitor.py'
                    }
                }
                stage('Compliance Check') {
                    steps {
                        sh 'python ComplianceCheck.py'
                    }
                }
                stage('Data Encryption') {
                    steps {
                        sh 'python DataEncryption.py'
                    }
                }
                stage('GDPR Breach Notifier') {
                    steps {
                        sh 'python GDPRBreachNotifier.py'
                    }
                }
                stage('HIPAA Compliance Check') {
                    steps {
                        sh 'python HIPAAComplianceCheck.py'
                    }
                }
                stage('Security Audit') {
                    steps {
                        sh 'python SecurityAudit.py'
                    }
                }
            }
        }

        stage('Run PowerShell Scripts') {
            steps {
                script {
                    if (isUnix()) {
                        error 'PowerShell scripts can only run on Windows agents'
                    } else {
                        powershell 'SecurityBaseline.ps1'
                        powershell 'NetworkLockdown.ps1'
                    }
                }
            }
        }

        stage('Run Bash Scripts') {
            steps {
                sh 'bash ContainerScan.sh'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    if (fileExists('chatbot-deployment.yaml')) {
                        sh 'kubectl apply -f chatbot-deployment.yaml'
                    }
                    if (fileExists('deployment.yaml')) {
                        sh 'kubectl apply -f deployment.yaml'
                    }
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/*.log', allowEmptyArchive: true
        }
        success {
            mail to: 'youremail@example.com',
                 subject: 'Build Successful',
                 body: 'The Jenkins build was successful.'
        }
        failure {
            mail to: 'youremail@example.com',
                 subject: 'Build Failed',
                 body: 'The Jenkins build failed. Please check the logs for details.'
        }
    }
}
