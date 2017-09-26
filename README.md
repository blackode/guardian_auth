# GuardianAuth
This is the working example of ** Guardian Authentication ** implemented using the ** Postgresql ** database. In this example I am using the default `localhost` for live authentication for live database. 

## Features
   * User Registrations Listing Editing and Deleting
   * User Sessions Creation/Deletion
   * If the new user is created, a session is automatically created and treating that user as a logged in user automatically.
   * Authentication Url Redirection. 
   
If the user try to visit the unauthorized urls with out logging in then he is redirected to login page. If he already logged in and trying to visit login page, if the token is still exists, he is redirected to authenticated users. 
   
## Technologies 
The following are the  versions used at the time of writing this template.             
   * `Elixir 1.5.1`
   * `Erlang 20.0`
   * `Phoenix 1.3.0`
## Authentication Elixir Modules
   * `Guardian ~> 0.14`
   * `bcrypt_elixir ~> 1.0`
   *  `comeonin ~> 4.0`             
   
** NOTE ** 
For bcrypt_elixir version 1.0, you need to be using `Erlang 20.0`                
Downgrade to `bcrypt_elixir version 0.12`, if you use the older version of the `Erlang 19`.

## Usage
You can use this as an Authentication Template or Boilerplate and start focussing on your development instead of spending time in writing 
user signin and signout.             
Just clone it using the url `https://github.com/blackode/guardian_auth.git` and change the MODULE NAMES  and APP_NAMES according to your project. 


## Starting Server    
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

#### Buy me a Coffee if this is useful Thanks for Reading.
 https://paypal.me/ankanna
