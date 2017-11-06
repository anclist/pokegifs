class PokemonController < ApplicationController

  def show
    pokemon_res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    pokemon_body = JSON.parse(pokemon_res.body)

    name  = pokemon_body["name"]
    id = pokemon_body["id"]
    types = pokemon_body["types"][0]["type"]["name"]

    giphy_res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name}&rating=g")
    giphy_body = JSON.parse(giphy_res.body)

    giphy = giphy_body["data"][0]["url"]

    render json: { "id": id, "name": name, "types": [types], "gif": giphy }
  end
end
