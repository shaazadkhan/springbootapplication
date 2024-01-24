pipeline {
    tools {
    jdk 'jdk17'
    maven 'maven3'
    }
    agent any
 
    stages {
         stage('Git Checkout') {
            steps {
                echo '###### Jenkin getting the code from a GitHub repository  ###### '
                git url:"https://github.com/shaazadkhan/springbootapplication.git",branch:"main"
            }
        }
        stage('Code Compile') {
            steps {
                 echo '###### Maven clean and compile the java code  ###### '
                 sh 'mvn clean compile'
              }
        }
        stage('Unit Tests') {
            steps {
                 echo '###### Jenkin running the test cases ###### '
                 sh 'mvn test'
           }
       }
       stage('Code Quality Check') {
            steps {
                echo '###### Jenkin running SonarQube analysis ######'
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar' // Example Maven SonarQube analysis command
                }
            }
        } 
        stage('OWASP Dependency-Check Vulnerabilities') {
            steps {
                echo '###### Jenkin running OWASP dependency check ######'
                dependencyCheck additionalArguments: ' --scan ./ ', odcInstallation: 'Check-DP'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage('Code Build') {
            steps {
                 echo '###### Jenkin running to generate a artifact file  ###### '
                 sh 'mvn clean install'
           }
       }
        stage('Docker Build') {
            steps {
                echo '###### Jenkin building the docker image #####'
                sh "docker build -t springbootapplicationservices ."
            }
        } 
         stage('Docker Push') {
            steps {
                echo '###### Jenkin pushing docker image to docker hub #####'
                withCredentials([usernamePassword(credentialsId:"dockerHub",usernameVariable:"dockerHubUser",passwordVariable:"dockerHubPass")]){
                       sh "docker tag springbootapplicationservices  ${env.dockerHubUser}/springbootapplication-1:latest"
                       sh "docker login -u ${dockerHubUser} -p ${dockerHubPass}"
                       sh "docker push ${env.dockerHubUser}/springbootapplication-1:latest"
                      
                }
             
            }
        }   
        stage('Docker Deployed') {
            steps {
                echo '##### Jenkin running docker image ######'
                sh "sh /home/shaazad/Desktop/docker/docker-script.sh"
           }
        }       
     }
 }
