
# Ruby on Rails: Learn 25+ gems and build a Startup MVP 2023

Welcome to my journy on this Ruby on Rails bootcamp! 
This application is built with Rails 7.2.1 and is designed to be a robust web application leveraging a variety of gems for functionality.

## Table of Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)

## Features
- PostgreSQL as the database
- User authentication with Devise
- Friendly URLs with FriendlyId
- Search functionality using Ransack
- Activity tracking with Public Activity
- Role management with Rolify
- Bootstrap for styles

## Requirements
- Ruby 3.2.2
- Rails 7.2.1
- PostgreSQL

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
   ```

2. **Install dependencies: Make sure you have Bundler installed, then run:**

	```bash
	bundle install
	```

3. **Set up the database: Create the database and run migrations:**

	```bash
	rails db:create
	rails db:migrate
	rails db:seed
	```

4. **Start the Rails server:**

	```bash
    rails server
	```
Visit the application: Open your browser and go to http://localhost:3000.

## Configuration

Update your config/database.yml with your PostgreSQL credentials.

## Usage
 

 1. Create a new user: Navigate to the sign-up page.
 2. Log in: Use the login page to access your account.
 3.  Explore features: Utilize the various features offered by the application, such as searching, user activity tracking, and more.
