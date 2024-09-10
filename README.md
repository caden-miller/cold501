# Cold501 - a Ruby on Rails website for HEAT @ TAMU using pgSQL 
## Caden Miller, Erik Achtermann, James Guandolo, Shanti Patel

### Setup

1. Clone GitHub repo in your projects folder (called csce431 from here on out)
	- git clone git@github.com:caden-miller/cold501.git

2. Run docker command at csce431/ 
	- sudo docker run -it --volume "$(pwd):/csce431" -e DATABASE_USER=cold_app -e DATABASE_PASSWORD=cold_password -p 3000:3000 paulinewade/csce431:latest

3. Go into the project directory within Docker
	- cd csce431/cold501/

4. Install all rails gems
	- bundle install

5. Setup the rails database
	- rails db:create
	- rails db:migrate
	- rails db:seed

6. Run the server locally
	- rails s --binding=0.0.0.0

7. Navigate to the rails server in your browser
	- https://127.0.0.1/

### How to Contribute

1. Open another Ubuntu terminal at csce431/cold501/ (outside of docker instance)
	- this is where you commit things

2. We want to commit to a feature branch and follow TDD
	- check branch
		- git branch
	- switch branch
		- git switch <branch>
	- create an upstream reference to a new feature branch
		- git checkout -b <feature_branch>
	- only commit to a feature branch
	- make tests for your feature first in the spec/ directory
		- happy unit tests
		- sad unit tests
		- integration tests
	- once you're done working for the moment or want to commit your history
		- git add .
		- git commit -m "<explain what you did>"
		- git push origin <feature_branch>

3. Merge your changes and verify tests pass
	- create a pull request from <feature_branch> to dev on GitHub GUI
	- create a pull request from dev to test
		- ensure all tests pass
	- create a pull request from test to main
		- ensure the tests pass and the test branch is working locally

### How to Create a New Model

1. Scaffold the model
	- rails g scaffold User username:string name:string 
	- this will generate a user model and some views for user as well as update the routes so that the views are shown.

2. Update the database
	- rails db:migrate


