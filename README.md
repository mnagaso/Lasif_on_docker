# LASIF and LASIF serve environment on docker container

This is the dockerfile to prepare an environment with the minimum dependency requirements for using LASIF and LASIF server.

### to build and run the docker image
`docker-compose up -d`

### to attach (enter into) the docker container
`docker-compose ps` to verify the name of running container, then  
`docker attach NAME_OF_RUNNING_CONTAINER`  

Generally the NAME_OF_RUNNING_CONTAINER = lasif_on_docker_lasif_env_1 but it may depend the name of directory where docker-compose.yml file is placed.  

### to start the lasif server
Go into your project directory, or making a Tutorial project by lasif command,  
`lasif init_project Tutorial && cd Tutorial`  

Then start the lasif server  
`lasif server --open_to_outside`  

Ctrl+click the indicated url or directly putting `127.0.0.1:8008` on the url space of your web browser, will open the LASIF server GUI.  