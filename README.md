

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

## step :
1. Retrieve an authentication token and authenticate your Docker client to your registry. Use the AWS CLI:
```
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 536984075386.dkr.ecr.ap-south-1.amazonaws.com
```
2. tag with aws  ecr image 
```
docker tag my-strapi-app:latest 536984075386.dkr.ecr.ap-south-1.amazonaws.com/my-strapi:latest
```
3. push to docker container 
```
docker push 536984075386.dkr.ecr.ap-south-1.amazonaws.com/my-strapi:latest
```


