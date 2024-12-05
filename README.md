
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
- **PostgreSQL as the database**: A powerful, open-source relational database management system for robust data handling.
- **User authentication with Devise**: Secure user registration, login, and password management out of the box.
- **Friendly URLs with FriendlyId**: Clean, readable URLs that improve user experience and SEO.
- **Search functionality using Ransack**: Advanced search capabilities allowing users to filter and find data efficiently.
- **Activity tracking with Public Activity**: Monitor user actions and interactions throughout the application.
- **Role management with Rolify**: Flexible role-based access control to manage user permissions seamlessly.
- **Bootstrap for styles**: Responsive and modern design with a mobile-first approach for a polished user interface.
- **Authorization with Pundit**: Fine-grained control over user access to resources and actions, ensuring data security.
- **Form handling with Simple Form**: Easy-to-use forms with enhanced functionality for a better user experience.
- **Faker for test data**: Generate realistic fake data for development and testing purposes.
- **Haml for templating**: Clean and concise HTML templating language that streamlines view creation.
- **Font Awesome icons**: A library of scalable vector icons to enhance the visual appeal of the application.
- **Pagy**: A library for pagination.
- **Chartkick**: For Analytics and displaying graphs.
- **groupdate**: For grouping in Chartkick

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
