

# About Project 
This project is  complete demonstration to run a reactjs application using following technology stack -
1. github 
2. reactjs
3. strapi( backend cms template )
4. rds mysql 
5. docker / docker-hub/ docker-compose / container orchistration
6. ecr (elastic container registry)
7. ecs fargate
8. aws auto-scaling group
9. load balancer
10. ci/cd pipeline 

#  how to initializing with Git 

## create a new repository on the command line
```
echo "# github-ecr-ecs-fargate-strapi-reactjs-01" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/abhiramdas99/github-ecr-ecs-fargate-strapi-reactjs-01.git
git push -u origin main
```
## push an existing repository from the command line
```
git init
git add .
git commit -m "1st commit"
git remote add origin https://github.com/abhiramdas99/github-ecr-ecs-fargate-strapi-reactjs-01.git
git branch -M main
git push -u origin main
```

# Local Test in Developers Laptop : 
## Test your project in your local machine 
1. make sure your within in root directory of this project 
3. execute the below command for to initialized to your project for strapi with typescript template-
```
 npx create-strapi-app@latest . --template typescript --quickstart
```
4. install typescript dependencies
```
npm install --save-dev typescript @types/node @strapi/typescript-utils
```
5. Start the Strapi server in development mode
```
npm run develop
```
6. Checkout with the default url - http://localhost:1337/admin
7. Press ctrl + c to terminate the application

## Test your project through docker container 
1. Create a docker file location:  file://./Dockerfile
2. Create a .dockerignore file  location: file://./.dockerignore
3. Build the docker image from this app
```
docker build -t my-strapi-app .
```
4. run your Strapi Docker container in detached mode
```
docker run -d -p 1337:1337 --name my-strapi-container my-strapi-app
```
5. Checkout with the default url - http://localhost:1337/admin

## Important troubleshooting during Local test 
1. make sure that, the port should be empty, and other software not used that. 
- For window:
```
netstat -an | find "1337"
```
- For Linux:
```
netstat -an | grep 1337
```
For mac:
```
lsof -i :1337
```
2. make sure container is running properly 
- check the image create or not 
```
docker images 
```
- check the container is running or not 
```
docker ps -a
```

# Deploy to aws ecs-fargate from Developer Desktop through ECR : 
## Prerequisite:
1. aws cli should be configure with IAM user access 
2. aws ECR should be create 
3. aws ECS should be create 

## push to aws ecr :
1. Retrieve an authentication token and authenticate your Docker client to your registry. Use the AWS CLI:
```
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 536984075386.dkr.ecr.ap-south-1.amazonaws.com
```
2. tag with aws  ecr image 
```
docker tag my-strapi-app:latest <AWS_ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/my-strapi:latest
```
3. push to docker container 
```
docker push <AWS_ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/my-strapi:latest
```
## IAM setup 
- Create Task Execution role and provide permission:
1. Navigate - IAM > Roles > Select trusted entity > type: AWS service
2. User case - Elastic Container Service > Elastic Container Service Task
3. Permissions policies 
  - AmazonECSTaskExecutionRolePolicy
  - AmazonRDSFullAccess
  - AmazonS3FullAccess
  - CloudWatchLogsFullAccess
  - SecretsManagerReadWrite
4. role name : ecsTaskExecutionRole

## Cloudwatch setup 
- Crate new log group to  catch the  ecs fargate logs 
1. Cloudwatch > Logs > Log Groups 
2. Create new log group as name : /ecs/my-strapi-tf + retention period- 1 week 

## deploy to ecs fargate cluster ( devops task )
- Create Task Definitions
1. Task definition family name : my-strapi-tf 
2. Launch type : AWS Fargate
3. Operating system/Architecture : Linux / X86_64
4. Task size : 1 vCPU +  2 GB memory 
5. Task role : ecsTaskExecutionRole
6. Container setup : 
  - name : strapi 
  - image uri : <AWS_ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/my-strapi:latest
  - Essential container : Yes
  - Private registry :  Yes 
  - Port mapping : Container port - 1337 / tcp  ( Make sure container port should be same as mention in image) 
  - resource allocation limit :  1 cpu +  1 gb memory hard limit 
  - Environment : NA 
7. Log Collection : 
  - awslogs-group : /ecs/my-strapi-tf
  - awslogs-region : ap-south-1
  - awslogs-stream-prefix : ecs
  - awslogs-create-group : true 

- Create Cluster:
1. Navigate - Amazon Elastic Container Service > Create cluster 
2. cluster name -  my-strapi-cluster
3. ecs > Clusters > my-strapi-cluster > Services
4. Compute options > Launch type > Fargate > Latest
5. deployment configuration > task > Task definition > my-strapi-tf
6. make sure the port no- 1337 should be  allow  to public  to access the fargate ecs


