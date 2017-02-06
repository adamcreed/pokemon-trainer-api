# Pokemon-Trainer-API
> A sinatra based API that tracks pokemon trainers and their pokemon.

# Description
This api gives commands for creating, tracking, and editing teams of pokemon.

# Commands
* get '/api/pokemon/:name'
  * Shows all trainers with a given pokemon.
* post '/api/pokemon'
  * Creates a new pokemon and assigns it to a trainer.
* patch '/api/pokemon/:id'
  * Changes an existing pokemon.
* delete '/api/pokemon/:id'
  * Deletes a pokemon.

* get '/api/trainers'
  * Gives a list of all trainers.
* get '/api/trainers/:id'
  * Gives the pokemon team for the chosen trainer.
* post '/api/trainers/:id'
  * Creates a new trainer.
* patch '/api/trainers/:id'
  * Changes an existing trainer.
* delete '/api/trainers/:id'
  * Deletes a trainer.

## About / Contact

Pokemon is owned by The Pokemon Company and Nintendo/Creatures/Game Freak.

Adam Reed – [GitHub](https://github.com/adamcreed/)
 – <kusa.xisa@gmail.com>
